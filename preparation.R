setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(dplyr)
library(tidyr)
library(forcats)
library(ggplot2)
library(cowplot)
library(purrr)

# You will have to download the zipped VDem .csv manually from 
# https://v-dem.net/data/the-v-dem-dataset/country-year-v-dem-core-v13/.

# Downloading the necessary data sets:
# TIES:
download.file(
  "https://sanctions.web.unc.edu/wp-content/uploads/sites/18834/2021/04/TIESv4-1.xls",
  "ties4-1.xls"
)
# NMC:
download.file(
  "https://correlatesofwar.org/wp-content/uploads/NMC_Documentation-6.0.zip",
  "NMC.zip"
)
unzip("NMC.zip", exdir ="NMC", overwrite = TRUE)
unzip("NMC/NMC-60-abridged.zip", exdir = "NMC/data_abridged", overwrite = TRUE)
# Alliance Data:
download.file(
  "https://correlatesofwar.org/wp-content/uploads/version4.1_csv.zip",
  "alliances.zip"
)
unzip("alliances.zip", exdir = "alliances", overwrite = TRUE)
# VDEM:
unzip("V-Dem-CY-Core_csv_v13.zip", exdir = "vdem", overwrite = TRUE)
# Dyadic Inter-State War data set:
download.file(
  "https://correlatesofwar.org/wp-content/uploads/Dyadic-Interstate-War-Dataset.zip",
  "interstate_wars.zip"
)
unzip("interstate_wars.zip", exdir = "interstate_wars", overwrite = TRUE)

# Reading the data:
ties <- readxl::read_xls("ties4-1.xls")
cow <- readr::read_csv("https://correlatesofwar.org/wp-content/uploads/COW-country-codes.csv")
cinc <- readr::read_csv("NMC/data_abridged/NMC-60-abridged.csv")
alliances <- readr::read_csv("alliances/version4.1_csv/alliance_v4.1_by_dyad_yearly.csv")
vdem <- readr::read_csv("vdem/V-Dem-CY-Core-v13.csv")
wars <- readr::read_csv("interstate_wars/directed_dyadic_war.csv")
gdp <- haven::read_dta("pwt1001.dta")
trade <- readr::read_csv("trade_full.csv")

ties <- 
  ties |> 
  filter(imposition == 1) |> 
  select(
    caseid, startyear, sancimpositionstartyear, 
    endyear, primarysender, sender1, targetstate,
    finaloutcome, settlementnaturesender
  ) |> 
  mutate(sancstartyear = as.numeric(gsub(",.*$", "", sancimpositionstartyear))) |> 
  select(-sancimpositionstartyear) |> 
  select(caseid, startyear, sancstartyear, everything())

cow <- 
  cow |> 
  rename("iso" = StateAbb, "code" = CCode, "full" = StateNme) |> 
  distinct() |> 
  rbind(data.frame(iso = "EU", code = 1000, full = "European Union"))

# Adding country codes:
ties <- 
  ties |> 
  left_join(cow, by = c("primarysender" = "code")) |> 
  rename("sender" = iso, "sender_full" = full) |> 
  left_join(cow, by = c("targetstate" = "code")) |> 
  rename("target" = iso, "target_full" = full) |> 
  select(caseid, sender, target, everything())

# Making the dyads:
# note that 79 sanctions miss "primarysender":
ties |> 
  filter(is.na(primarysender)) |> 
  nrow()

ties <- ties |> mutate(dyad = map2_chr(sender, target, \(x, y) paste0(x, "-", y)))

# Imputing imposition year (5 cases):
ties <- 
  ties |> 
  mutate(sancstartyear = ifelse(is.na(sancstartyear), startyear, sancstartyear))

ties <- 
  ties |> 
  # If missing endyear, assume sanctions went on:
  # (I assign a year beyond the range of the panel to be able to easily
  # identify imputations later on, and it does not matter for what I am doing)
  mutate(endyear = ifelse(is.na(endyear), 3000, endyear)) |> 
  group_by(dyad) |> 
  mutate(
    # Number of prior sanctions (disregarding overlaps):
    prior = map_int(sancstartyear, \(x) sum(x > sancstartyear)),
    # Number of non-overlapping prior sanctions: 
    prior_non_overlapping = map_int(sancstartyear, \(x) sum(x > endyear))
  ) |> 
  ungroup()

# add dummy for prior sanctions:
ties <- ties |> mutate(prior_dummy = ifelse(prior > 0, 1, 0))

# Add success:
ties <- 
  ties |> 
  mutate(
    # Maximalist:
    success = ifelse(finaloutcome %in% c(6, 7), 1, 0), # 6/7 = partial/total acquiescence
    # Minimalist:
    success_min = ifelse(finaloutcome %in% c(6, 7, 10), 1, 0) # 10 = negotiated settlement
  )

# Drop episodes without primary sender:
ties <- ties |> filter(!is.na(primarysender))

# Covariates:

# Alliances:
make_dyad_code <- function(x, y) paste0(x, "-", y)

alliances <- 
  alliances |> 
  select(ccode1, ccode2, year, defense:entente) |> 
  left_join(cow |> select(-full), by = c("ccode1" = "code")) |> 
  rename("id1" = iso) |> 
  left_join(cow |> select(-full), by = c("ccode2" = "code")) |> 
  rename("id2" = iso) |> 
  filter(year >= 1944 & year <= 2006) |> 
  select(id1, id2, year, defense:entente) |> 
  mutate(
    dyad1 = map2_chr(id1, id2, make_dyad_code),
    dyad2 = map2_chr(id2, id1, make_dyad_code)
  ) |> 
  select(-c(id1, id2))

alliances <- 
  alliances |> 
  select("dyad" = dyad1, year, defense:entente) |> 
  rbind(alliances |> select("dyad" = dyad2, year, defense:entente)) |> 
  distinct() |> 
  group_by(dyad, year) |> 
  summarise(across(defense:entente, sum)) |> 
  ungroup() |> 
  mutate(across(defense:entente, \(x) ifelse(x > 0, 1, 0)))

# To add lag:
alliances <- alliances |> mutate(year = year + 1)

ties <- 
  ties |> 
  left_join(alliances, by = c("dyad", "sancstartyear" = "year")) |> 
  mutate(across(c(defense:entente), \(x) ifelse(is.na(x), 0, x)))

alliance_vars <- c("defense", "neutrality", "nonaggression", "entente")
ties$formal_alliance <- ifelse(rowSums(ties[, alliance_vars]) > 0, 1, 0)

# Add Composite indicator of national capabilities (CINC; measure for "power"):
# Needed: deal with EU?

cinc <- cinc |> mutate(year = year +1)

ties <- 
  ties |> 
  left_join(
    cinc |> select(ccode, year, "cinc_target" = cinc), 
    by = c("targetstate" = "ccode", "sancstartyear" = "year")
  ) |> 
  left_join(
    cinc |> select(ccode, year, "cinc_sender" = cinc),
    by = c("primarysender" = "ccode", "sancstartyear" = "year")
  ) |> 
  mutate(power_diff = cinc_sender - cinc_target)

# VDEM:
vdem <- 
  vdem |> 
  filter(year %in% 1944:2004) |> 
  select(country_text_id, year, v2x_polyarchy) |> 
  mutate(
    ccode = countrycode::countrycode(country_text_id, "iso3c", "gwn"),
    year = year + 1
  ) |> 
  rename("polyarchy" = v2x_polyarchy) |> 
  select(-country_text_id)

ties <- 
  ties |> 
  left_join(vdem, by = c("primarysender" = "ccode", "sancstartyear" = "year")) |> 
  rename("polyarchy_sender" = "polyarchy") |> 
  left_join(vdem, by = c("targetstate" = "ccode", "sancstartyear" = "year")) |> 
  rename("polyarchy_target" = "polyarchy")

# gdp:
gdp_clean <- 
  gdp |> 
  select("iso3" = countrycode, year, "gdp" = rgdpo) |> 
  mutate(
    ccode = countrycode::countrycode(iso3, "iso3c", "gwn"),
    year = year + 1
  ) |> 
  filter(!is.na(ccode))

ties <- 
  ties |> 
  left_join(
    gdp_clean |> select(gdp, year, ccode), 
    by = c("targetstate" = "ccode", "sancstartyear" = "year")
  ) |> 
  rename("target_gdp" = gdp) |> 
  left_join(
    gdp_clean |> select(gdp, year, ccode), 
    by = c("primarysender" = "ccode", "sancstartyear" = "year")
  ) |> 
  rename("sender_gdp" = gdp)

# Trade dependence

trade <- 
  trade |> 
  mutate(
    dependence = trade_volume_with_sender / target_total_volume,
    year = year + 1
  ) |> 
  select(dyad, year, dependence) |> 
  filter(!is.na(dependence))

ties <- ties |> left_join(trade, by = c("dyad", "sancstartyear" = "year"))
# Some EDA:

# most sanctioned dyad:
top_dyads <- 
  ties |> 
  mutate(
    dyad_full = map2_chr(sender_full, target_full, \(x, y) paste(x, "on", y)),
    dyad_full = stringr::str_replace(dyad_full, "United States of America", "USA")
  ) |> 
  group_by(dyad_full) |> 
  summarise(prior = max(prior_non_overlapping)) |> 
  arrange(desc(prior)) |> 
  head(10) |> 
  ggplot(aes(x = prior, y = fct_reorder(dyad_full, prior))) +
  geom_col() +
  labs(
    x = "Number of Sanctions", 
    y = "Dyad (Sender First)", 
    title = "Dyads",
    caption = "= maximum number of prior, non-overlapping\nsanctions in the dyad"
  ) +
  theme_minimal()

# Most prolific senders:
top_senders <- 
  ties |> 
  ungroup() |> 
  count(sender_full) |> 
  arrange(desc(n)) |> 
  head(10) |> 
  ggplot(aes(x = n, y = fct_reorder(sender_full, n))) +
  geom_col() +
  labs(x = "Number of Sanctions Imposed", y = "Sender", title = "Senders") +
  theme_minimal()

top_targets <- 
  ties |> 
  ungroup() |> 
  count(target_full) |> 
  arrange(desc(n)) |> 
  head(10) |> 
  ggplot(aes(x = n, y = fct_reorder(target_full, n))) +
  geom_col() +
  labs(x = "Number of Sanctions Imposed On", y = "Target", title = "Targets") +
  theme_minimal()

plot_grid(
  plot_grid(top_senders, top_targets, nrow = 1, ncol = 2),
  plot_grid(NULL, top_dyads, NULL, nrow = 1, rel_widths = c(0.5, 1, 0.5)),
  nrow = 2
)

# Most targeted:
ties |> 
  ungroup() |> 
  count(target_full) |> 
  arrange(desc(n))

# Distribution of sanctions/dyad:
ties |> 
  count(prior_non_overlapping) |> 
  ggplot(aes(x = prior_non_overlapping, y = n)) +
  geom_col() +
  scale_x_continuous(breaks = seq(0, 8, 1)) +
  labs(x = "Number of Previous Sanctions (Dyad)", y = "N") +
  theme_minimal()

ties |> 
  mutate(treated = ifelse(prior_non_overlapping > 0, 1, 0)) |> 
  count(treated)

# Showing that power relations are relatively persistent over time:
top_dyads <- 
  ties |> 
  filter(!is.na(sender), !is.na(power_diff)) |> 
  count(dyad) |> 
  arrange(desc(n)) |> 
  head(16) |> 
  pull(dyad)

ties |> 
  filter(dyad %in% top_dyads) |>  
  select(dyad, sancstartyear, power_diff) |> 
  distinct() |> 
  mutate(dyad = factor(dyad, levels = top_dyads, ordered = TRUE)) |> 
  ggplot(aes(x = sancstartyear, y = power_diff)) +
  geom_line() +
  geom_hline(yintercept = 0, lty = "dashed", color = "grey50") +
  theme_minimal() +
  labs(
    x = "", 
    y= "Power Difference (CINC)"
  ) +
  facet_wrap(~dyad)

ties |> 
  ggplot(aes(x = sancstartyear, y = power_diff)) +
  geom_hline(yintercept = 0, lty = "dashed", color = "grey50") +
  geom_violin(aes(group = sancstartyear), color = "lightgrey") +
  geom_boxplot(aes(group = sancstartyear), size = 0.5, color = "grey50", fill = "lightgrey") +
  geom_smooth(color = "black") +
  theme_minimal() +
  labs(x = "", y = "Power Difference Sender-Target (CINC)")

# Success:
ties <- ties |> ungroup()
for_success <- 
  ties |> 
  mutate(across(starts_with("success"), \(x) ifelse(x == 0, "Unsuccessful", "Successful")))

maximalist <- 
  for_success |> 
  count(success) |> 
  mutate(`%` = n / sum(n), definition = "Maximalist \n(Excl. negotiated settlements)")

minimalist <- 
  for_success |> 
  count(success_min) |> 
  rename("success" = success_min) |> 
  mutate(`%` = n / sum(n), definition = "Minimalist \n(Incl. negotiated settlements)")

rbind(maximalist, minimalist) |> 
  ggplot(aes(x = success, y = n, fill = success)) +
  geom_col() +
  geom_text(
    aes(label = paste0(as.character(round(`%` * 100, digits = 2)), "%")), 
    vjust = -0.5
  ) +
  scale_fill_grey(start = 0.6, end = 0.4) +
  facet_wrap(~definition) +
  theme_minimal() +
  labs(x = "", y = "N")

# Success over time

by_year <- 
  ties |> 
  group_by(sancstartyear) |> 
  mutate(succ = ifelse(success == 1, "Yes", "No")) |> 
  ggplot(aes(x = sancstartyear, fill = succ)) +
  geom_bar() +
  scale_fill_grey(start = 0.6, end = 0.4) +
  scale_x_continuous(breaks = seq(1940, 2000, 10)) +
  labs(
    fill = "Successful?", 
    x = "", 
    y = "Number of Sanctions Imposed",
    title = "By Year"
  ) +
  theme_minimal()

# By decade:

by_decade <- 
  ties |> 
  mutate(
    decade = sancstartyear - sancstartyear %% 10, 
    succ = ifelse(success == 1, "Yes", "No")
  ) |> 
  ggplot(aes(x = decade, fill = succ)) +
  geom_bar() +
  scale_fill_grey(start = 0.6, end = 0.4) +
  scale_x_continuous(breaks = seq(1940, 2000, 10)) +
  labs(
    fill = "Successful?", 
    x = "", 
    y = "Number of Sanctions Imposed",
    title = "By Decade"
  ) +
  theme_minimal()

plot_grid(
  by_year, by_decade, nrow = 2
)

write.csv(ties, "ties_custom.csv")

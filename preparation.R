#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(dplyr)
library(tidyr)
library(forcats)
library(ggplot2)
library(purrr)

download.file(
  "https://sanctions.web.unc.edu/wp-content/uploads/sites/18834/2021/04/TIESv4-1.xls",
  "ties4-1.xls"
)

ties <- readxl::read_xls("ties4-1.xls")
cow <- readr::read_csv("https://correlatesofwar.org/wp-content/uploads/COW-country-codes.csv")

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

# adding prior sanctions:
# by dyad:

### Testing for counting sanctions within last 5/10 years:

arr <- 
  ties |> 
  select(caseid, dyad, everything()) |> 
  arrange(dyad, startyear)

within_last_five <- integer(length = nrow(arr))
within_last_ten <- integer(length = nrow(arr))

for (i in seq_len(nrow(arr))) {
  curr <- arr$sancstartyear[[i]]
  curr_dyad <- arr$dyad[[i]]
  
  if (is.na(curr)) {
    within_last_five[[i]] <- NA
    within_last_ten[[i]] <- NA
  } else {
    within_last_five[[i]] <- arr |> filter(dyad == curr_dyad, sancstartyear <= curr, sancstartyear >= (curr - 5)) |> nrow()
    within_last_ten[[i]] <- arr |> filter(dyad == curr_dyad, sancstartyear <= curr, sancstartyear >= (curr - 10)) |> nrow()
  }
}

ties <- arr |> cbind(within_last_five, within_last_ten)

###

ties <- 
  ties |> 
  mutate(counter = 1) |> 
  group_by(dyad) |> 
  arrange(dyad, startyear) |> 
  mutate(
    number_imposed = cumsum(counter),
    prior = number_imposed - 1
  ) |> 
  ungroup()

# Imputing imposition year (5 cases):
ties <- 
  ties |> 
  mutate(sancstartyear = ifelse(is.na(sancstartyear), startyear, sancstartyear))

# add dummy for prior sanctions:
ties <- ties |> mutate(prior_dummy = ifelse(prior > 0, 1, 0))

# add dummy for initial sanction (= no prior sanctions):
ties <- ties |> mutate(first_sanction = ifelse(prior == 0, 1, 0))

# Add success:
ties <- 
  ties |> 
  mutate(
    success = ifelse(finaloutcome %in% c(6, 7), 1, 0),
    success_min = ifelse(finaloutcome %in% c(6, 7, 10), 1, 0) # 10 = negotiated settlement after imposition
  )

# Non-directional Dyad:
ties <- 
  ties |> 
  select(caseid, sender, target) |> 
  pivot_longer(cols = c("sender", "target")) |> 
  select(-name) |> 
  arrange(caseid, value) |> 
  group_by(caseid) |> 
  summarise(dyad_nd = paste(value, collapse = "-")) |> 
  right_join(ties, by = "caseid")

ties <- 
  ties |> 
  mutate(counter = 1) |> 
  group_by(dyad_nd) |> 
  arrange(dyad_nd, startyear) |> 
  mutate(
    number_imposed_nd = cumsum(counter),
    prior_nd = number_imposed_nd - 1
  ) |> 
  ungroup()

# Some EDA:

# most sanctioned dyad:
top_dyads <- 
  ties |> 
  filter(!is.na(primarysender)) |> 
  #count(dyad) |>
  mutate(
    dyad_full = map2_chr(sender_full, target_full, \(x, y) paste(x, "on", y)),
    dyad_full = stringr::str_replace(dyad_full, "United States of America", "USA")
  ) |> 
  count(dyad_full) |> 
  arrange(desc(n)) |> 
  head(10) |> 
  ggplot(aes(x = n, y = fct_reorder(dyad_full, n))) +
  geom_col(fill = "lightgrey", color = "black") +
  labs(x = "Number of sanctions (dyad, sender first)", y = "", title = "Dyads") +
  theme_classic()

ties |> 
  count(dyad_nd) |> 
  arrange(desc(n))

# Most prolific senders:
top_senders <- 
  ties |> 
  count(sender_full) |> 
  filter(!is.na(sender_full)) |> 
  arrange(desc(n)) |>
  head(10) |> 
  ggplot(aes(x = n, y = fct_reorder(sender_full, n))) +
  geom_col(fill = "lightgrey", color = "black") +
  labs(x = "Number of sanctions (sender)", y = "", title = "Senders") +
  theme_classic()

cowplot::plot_grid(top_senders, top_dyads)

# Most targeted:
ties |> 
  count(target_full) |> 
  arrange(desc(n))

# Distribution of sanctions/dyad:
ties |> 
  ggplot(aes(x = number_imposed)) +
  geom_histogram(binwidth = 1, fill = "lightgrey", color = "black") +
#  geom_vline(xintercept = mean(ties$number_imposed)) +
#  annotate("text", label = "mean", x = 3, y = 410, angle = 90) +
#  geom_vline(xintercept = median(ties$number_imposed)) +
#  annotate("text", label = "median", x = 2.2, y = 405, angle = 90) +
  labs(x = "Number of Sanctions (Dyad)", y = "N") +
  theme_classic()

# Success:
for_success <- 
  ties |> 
  mutate(across(starts_with("success"), \(x) ifelse(x == 0, "Unsuccessful", "Successful")))

for_success |> 
  count(success) |> 
  mutate(`%` = n / 845)

for_success |> 
  count(success_min) |> 
  mutate(`%` = n / 845)

write.csv(ties, "ties_custom.csv")

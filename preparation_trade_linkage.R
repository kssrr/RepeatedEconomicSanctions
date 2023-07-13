setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(fixest)
library(dplyr)
library(tidyr)
library(forcats)
library(ggplot2)
library(purrr)
library(lmtest)
library(sandwich)

download.file(
  "https://correlatesofwar.org/wp-content/uploads/COW_Trade_4.0.zip",
  destfile = "trade.zip"
)

unzip("trade.zip", exdir = "trade", overwrite = TRUE)

national <- readr::read_csv("trade/COW_Trade_4.0/National_COW_4.0.csv")
dyadic <- readr::read_csv("trade/COW_Trade_4.0/Dyadic_COW_4.0.csv")
cow <- readr::read_csv("https://correlatesofwar.org/wp-content/uploads/COW-country-codes.csv")

dyadic[dyadic == -9] <- NA
national[national == -9] <- NA
# Total national trade (im&ex in mio/USD):

national <- 
  national |> 
  select(ccode, year, imports, exports) |> 
  mutate(total_volume = imports + exports) |> 
  filter(year %in% 1944:2006) |> 
  left_join(
    cow |> 
      select(CCode, StateAbb) |> 
      distinct(), 
    by = c("ccode" = "CCode")
  ) |> 
  rename("state" = StateAbb)

# Bilateral (dyadic) trade:

# Making directionally dyadic data set:
dyadic <- 
  dyadic |> 
  filter(year %in% 1944:2006) |> 
  select(ccode1, ccode2, year, flow1, flow2)

dyadic <- 
  dyadic |> 
  rename(
    "sender" = ccode1,
    "target" = ccode2,
    "exports_to_sender" = flow1,
    "imports_from_sender" = flow2
  ) |> 
  rbind(
    dyadic |> 
      rename(
        "target" = ccode1,
        "sender" = ccode2,
        "imports_from_sender" = flow1,
        "exports_to_sender" = flow2
      )
  ) |> 
  mutate(trade_volume_with_sender = exports_to_sender + imports_from_sender)

# Putting together:
full <- 
  dyadic |> 
  # sender side:
  left_join(national, by = c("sender" = "ccode", "year")) |> 
  rename_with(
    function(name) paste0("sender_", name), 
    .cols = c(imports, exports, total_volume, state)
  ) |> 
  # target side:
  left_join(national, by = c("target" = "ccode", "year")) |> 
  rename_with(
    function(name) paste0("target_", name), 
    .cols = c(imports, exports, total_volume, state)
  )

# Trade linkage = target's trade with sender as percentage of overall trade:
full <- 
  full |> 
  mutate(
    trade_linkage = trade_volume_with_sender / target_total_volume,
    # also adding the dyad code like in TIES:
    dyad = map2_chr(sender_state, target_state, \(x, y) paste0(x, "-", y))
  )

# Change in trade linkage:

full <- 
  full |> 
  group_by(dyad) |> 
  arrange(year, .by_group = TRUE) |>
  mutate(change_in_trade_linkage = trade_linkage / lag(trade_linkage) - 1) |>
  ungroup()

full |> 
  select(-change_in_trade_linkage) |> 
  distinct() |> 
  write.csv("trade_full.csv")

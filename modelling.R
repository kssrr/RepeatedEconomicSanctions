setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# I do all modeling explicitly. There may be smarter ways to code this, 
# but I want to remain entirely transparent about what I am calculating.

# For all tables, you can set `output = "latex"` inside `regtable()` to 
# generate the LaTeX for the tables. I only slightly modified some of the 
# rows in the GOF section to be more explicit. 

library(plm)
library(dplyr)
library(tidyr)
library(purrr)
library(fixest)
library(forcats)
library(ggplot2)
library(kableExtra)
library(modelsummary)

options(modelsummary_format_numeric_latex = "plain")

ties <- readr::read_csv("ties_custom.csv")

# I print all models this way, using `modelsummary::modelsummary()`:
regtable <- function(models, ...) {
  modelsummary(
    models,
    stars = c("*" = .1, "**" = .05, "***" = .01),
    gof_omit = "Log.Lik|BIC|F$",
    ...
  )
}

# Some preparation:

ties <- 
  ties |> 
  mutate(
    post_cold_war = ifelse(sancstartyear > 1991, 1, 0), # Post-CW dummy
    decade = sancstartyear - sancstartyear %% 10        # decade (for appendix)
  )

ties <- 
  ties |> 
  arrange(dyad, sancstartyear) |> 
  group_by(dyad) |> 
  mutate(trend = row_number()) |> # dyad specific linear trend (for robustness)
  ungroup()

# generate dataset of only complete observations across covariates
# (for easy access later):
no_missings_allowed <- c(
  "cinc_sender", "cinc_target", "post_cold_war", "formal_alliance",
  "polyarchy_sender", "polyarchy_target", "sender_gdp", "target_gdp", 
  "dependence"
)

ties_nm <- 
  ties |> 
  filter(if_all(all_of(no_missings_allowed), \(x) !is.na(x)))

# Maximalist definition of success:

models_maximalist <- list(
  "(1)" = feols(
    success ~ prior_non_overlapping,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  "(2)" = feols(
    success ~ prior_non_overlapping + cinc_sender + cinc_target + post_cold_war + formal_alliance + polyarchy_sender + polyarchy_target,
    data = ties,
    vcov = driscoll_kraay() ~ dyad,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad"
  ),
  "(3)" = feols(
    success ~ prior_non_overlapping + log(sender_gdp) + log(target_gdp) + dependence,
    data = ties,
    vcov = driscoll_kraay() ~ dyad,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad"
  ),
  "(4)" = feols(
    success ~ prior_non_overlapping + log(sender_gdp) + log(target_gdp) + post_cold_war + cinc_sender + cinc_target + formal_alliance + polyarchy_sender + polyarchy_target + dependence,
    data = ties,
    vcov = driscoll_kraay() ~ dyad,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad"
  )
)

models_maximalist |> 
  regtable(
    coef_rename = c(
      "prior_non_overlapping" = "Prior Sanctions",
      "log(sender_gdp)" = "Log (GDP) - Sender",
      "log(target_gdp)" = "Log (GDP) - Target",
      "dependence" = "Trade Dependence - Target",
      "cinc_sender" = "CINC - Sender",
      "cinc_target" = "CINC - Target",
      "formal_alliance" = "Formal Alliance",
      "polyarchy_sender" = "Polyarchy - Sender",
      "polyarchy_target" = "Polyarchy - Target"
    )
  ) |> 
  add_header_above(c(" " = 1, "Success \nExcl. negotiated settlements" = 4))

# Factor Regression

factor_model <- 
  ties |> 
  mutate(prior_fac = factor(prior_non_overlapping)) |> 
  feols(
    # Just change "success" to "success_min" below to generate figure 9:
    success ~ prior_fac + log(sender_gdp) + log(target_gdp) + post_cold_war + cinc_sender + cinc_target + formal_alliance + polyarchy_sender + polyarchy_target + dependence,
    data = _,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  )

factor_model |> 
  broom::tidy() |> 
  filter(grepl("prior_fac", term)) |> 
  mutate(
    lower = estimate - std.error, 
    upper = estimate + std.error,
    term = as.numeric(stringr::str_remove(term, "prior_fac"))
  ) |> 
  ggplot(aes(x = term, y = estimate)) +
  geom_hline(yintercept = 0, lty = "dashed", color = "grey50") +
  geom_line(aes(group = NA), color = "grey") +
  geom_point() +
  geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.1) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.2, fill = "grey") +
  labs(x = "Number of Previous Sanctions", y = "Estimate") +
  scale_x_continuous(breaks = seq(1, 8, 1)) +
  theme_minimal()

# Minimalist definition:

models_minimalist <- list(
  "(1)" = feols(
    success_min ~ prior_non_overlapping,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  "(2)" = feols(
    success_min ~ prior_non_overlapping + cinc_sender + cinc_target + post_cold_war + formal_alliance + polyarchy_sender + polyarchy_target,
    data = ties,
    vcov = driscoll_kraay() ~ dyad,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad"
  ),
  "(3)" = feols(
    success_min ~ prior_non_overlapping + log(sender_gdp) + log(target_gdp) + dependence,
    data = ties,
    vcov = driscoll_kraay() ~ dyad,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad"
  ),
  "(4)" = feols(
    success_min ~ prior_non_overlapping + log(sender_gdp) + log(target_gdp) + post_cold_war + cinc_sender + cinc_target + formal_alliance + polyarchy_sender + polyarchy_target + dependence,
    data = ties,
    vcov = driscoll_kraay() ~ dyad,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad"
  )
)

models_minimalist |> 
  regtable(
    coef_rename = c(
      "prior_non_overlapping" = "Prior Sanctions",
      "log(sender_gdp)" = "Log (GDP) - Sender",
      "log(target_gdp)" = "Log (GDP) - Target",
      "dependence" = "Trade Dependence - Target",
      "cinc_sender" = "CINC - Sender",
      "cinc_target" = "CINC - Target",
      "formal_alliance" = "Formal Alliance",
      "polyarchy_sender" = "Polyarchy - Sender",
      "polyarchy_target" = "Polyarchy - Target"
    )
  ) |> 
  add_header_above(c(" " = 1, "Success \nIncl. negotiated settlements" = 4))


# Graphical results (Not included):

tidy_models <- function(models, def) {
  models |> 
    map(broom::tidy) |> 
    map2(names(models), \(df, n) df |> mutate(model = n)) |> 
    map(\(df) df |> filter(term == "prior_non_overlapping")) |> 
    reduce(rbind) |> 
    mutate(
      definition = def,
      lower = estimate - std.error, 
      upper = estimate + std.error
    )
}

models <- list(
  "Excl. negotiated settlements" = models_maximalist,
  "Incl. negotiated settlements" = models_minimalist
)

models <-
  map2(models, names(models), \(model, def) tidy_models(model, def)) |>
  reduce(rbind)

models |> 
  ggplot(
    aes(x = factor(definition), y = estimate, color = model, shape = model)
  ) +
  geom_hline(yintercept = 0, lty = "dotted", color = "grey50") +
  geom_point(position = position_dodge(width = .2), size = 2) +
  geom_errorbar(
    aes(ymin = lower, ymax = upper), 
    position = position_dodge(width = .2),
    width = 0.2
  ) +
  theme_minimal() +
  scale_color_grey() +
  labs(
    x = "", 
    y = "Estimate",
    color = "Model",
    shape = "Model"
  ) +
  theme(legend.position = "bottom") +
  coord_flip()

###############
# Robustness: #
###############

# Dyad-specific time-trend:

models_time <- list(
  "All Obs." = feols(
    success ~ trend,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  "All Obs." = feols(
    success ~ prior_non_overlapping + trend,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  "Complete Obs." = feols(
    success ~ prior_non_overlapping + trend,
    data = ties_nm,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  "Complete Obs." = feols(
    success ~ prior_non_overlapping + trend + cinc_sender + cinc_target + post_cold_war + formal_alliance + polyarchy_sender + polyarchy_target + log(sender_gdp) + log(target_gdp) + dependence,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  )
)

models_time |> 
  regtable(
    coef_map = c(
      "prior_non_overlapping" = "Prior Sanctions",
      "trend" = "Dyad-specific linear trend"
    )
  ) |> 
  add_header_above(c(" " = 1, "Success \nExcl. negotiated settlements" = 4))

# Overall time trend:

models_time_overall <- list(
  feols(
    success ~ prior_non_overlapping,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  feols(
    success ~ sancstartyear,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  feols(
    success ~ prior_non_overlapping + sancstartyear,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  feols(
    success ~ prior_non_overlapping + sancstartyear + prior_non_overlapping:sancstartyear,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  feols(
    success ~ prior_non_overlapping + sancstartyear + cinc_sender + cinc_target + post_cold_war + formal_alliance + polyarchy_sender + polyarchy_target + log(sender_gdp) + log(target_gdp) + dependence,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  feols(
    success ~ prior_non_overlapping + sancstartyear + prior_non_overlapping:sancstartyear + cinc_sender + cinc_target + post_cold_war + formal_alliance + polyarchy_sender + polyarchy_target + log(sender_gdp) + log(target_gdp) + dependence,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  )
)

models_time_overall |> 
  regtable(
    coef_rename = c(
      "prior_non_overlapping" = "Prior Sanctions",
      "sancstartyear" = "Year of Imposition"
    ),
    coef_omit = 4:12
  ) |> 
  add_header_above(c(" " = 1, "Success \nExcl. negotiated settlements" = 6))

# US imposed vs. non-US imposed

# us_sender dummy is being automatically removed because of collinearity

us_models <- list(
  "All Obs." = feols(
    success ~ prior_non_overlapping,
    data = ties[ties$sender == "USA", ],
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  "Complete Obs." = feols(
    success ~ prior_non_overlapping,
    data = ties_nm[ties_nm$sender == "USA", ],
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  "Complete Obs." =feols(
    success ~ prior_non_overlapping + log(target_gdp) + post_cold_war + cinc_target + formal_alliance + polyarchy_target + dependence,
    data = ties[ties$sender == "USA", ],
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  )
)

non_us_models <- list(
  "All Obs." = feols(
    success ~ prior_non_overlapping,
    data = ties[ties$sender != "USA", ],
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  "Complete Obs." = feols(
    success ~ prior_non_overlapping,
    data = ties_nm[ties_nm$sender != "USA", ],
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  "Complete Obs." =feols(
    success ~ prior_non_overlapping + log(sender_gdp) + log(target_gdp) + post_cold_war + cinc_sender + cinc_target + formal_alliance + polyarchy_sender + polyarchy_target + dependence,
    data = ties[ties$sender != "USA", ],
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  )
)

c(us_models, non_us_models) |> 
  regtable(
    coef_rename = c("prior_non_overlapping" = "Prior Sanctions"),
    coef_omit = c(2:10) # dropping covariates from the table.
  ) |> 
  add_header_above(c(" " = 1, "Success \nExcl. negotiated settlements" = 6)) |> 
  add_header_above(c(" " = 1, "US imposed" = 3, "Non-US imposed" = 3))

#############
# Appendix: #
#############

# Allowing overlap:

models_maximalist2 <- list(
  "(1)" = feols(
    success ~ prior,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad",
    vcov = driscoll_kraay() ~ dyad
  ),
  "(2)" = feols(
    success ~ prior + cinc_sender + cinc_target + post_cold_war + formal_alliance + polyarchy_sender + polyarchy_target,
    data = ties,
    vcov = driscoll_kraay() ~ dyad,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad"
  ),
  "(3)" = feols(
    success ~ prior + log(sender_gdp) + log(target_gdp) + dependence,
    data = ties,
    vcov = driscoll_kraay() ~ dyad,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad"
  ),
  "(4)" = feols(
    success ~ prior + log(sender_gdp) + log(target_gdp) + post_cold_war + cinc_sender + cinc_target + formal_alliance + polyarchy_sender + polyarchy_target + dependence,
    data = ties,
    vcov = driscoll_kraay() ~ dyad,
    panel.id = c("dyad", "sancstartyear"),
    fixef = "dyad"
  )
)

models_maximalist2 |> 
  regtable(
    coef_rename = c(
      "prior" = "Prior and Ongoing Sanctions",
      "log(sender_gdp)" = "Log (GDP) - Sender",
      "log(target_gdp)" = "Log (GDP) - Target",
      "dependence" = "Trade Dependence - Target",
      "cinc_sender" = "CINC - Sender",
      "cinc_target" = "CINC - Target",
      "formal_alliance" = "Formal Alliance",
      "polyarchy_sender" = "Polyarchy - Sender",
      "polyarchy_target" = "Polyarchy - Target"
    )
  ) |> 
  add_header_above(c(" " = 1, "Success \nExcl. negotiated settlements" = 4))


# Two-way FEs:

models_2fe <- list(
  feols(
    success ~ prior_non_overlapping,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = c("dyad", "decade"),
    vcov = driscoll_kraay() ~dyad
  ),
  feols(
    success ~ prior_non_overlapping,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = c("dyad", "sancstartyear"),
    vcov = driscoll_kraay() ~dyad
  ),
  feols(
    success ~ prior_non_overlapping,
    data = ties_nm,
    panel.id = c("dyad", "sancstartyear"),
    fixef = c("dyad", "decade"),
    vcov = driscoll_kraay() ~dyad
  ),
  feols(
    success ~ prior_non_overlapping,
    data = ties_nm,
    panel.id = c("dyad", "sancstartyear"),
    fixef = c("dyad", "sancstartyear"),
    vcov = driscoll_kraay() ~dyad
  ),
  feols(
    success ~ prior_non_overlapping + cinc_sender + cinc_target + post_cold_war + formal_alliance + polyarchy_sender + polyarchy_target + log(sender_gdp) + log(target_gdp) + dependence,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = c("dyad", "decade"),
    vcov = driscoll_kraay() ~dyad
  ),
  feols(
    success ~ prior_non_overlapping + cinc_sender + cinc_target + post_cold_war + formal_alliance + polyarchy_sender + polyarchy_target + log(sender_gdp) + log(target_gdp) + dependence,
    data = ties,
    panel.id = c("dyad", "sancstartyear"),
    fixef = c("dyad", "sancstartyear"),
    vcov = driscoll_kraay() ~dyad
  )
)

models_2fe |> 
  regtable(
    coef_rename = c("prior_non_overlapping" = "Prior Sanctions"),
    coef_omit = 2:10,
    output = "latex"
  ) |> 
  add_header_above(c(" " = 1, "Success \nExcl. negotiated settlements" = 6))

# Hausman-test

# I use plm for the Hausman-test since `plm::phtest()` is really convenient to use.
# The model is fundamentally the same as above. 

# The choice of fixed-effects was a "design" choice, but I still ran Hausman tests
# to see whether it also made statistical sense.

fixed_effects <- plm(
  success ~ prior_non_overlapping + log(sender_gdp) + log(target_gdp) + post_cold_war + cinc_sender + cinc_target + formal_alliance + polyarchy_sender + polyarchy_target + dependence, 
  data = ties, 
  index = c("dyad", "sancstartyear"),
  model = "within"
)

random_effects <- plm(
  success ~ prior_non_overlapping + log(sender_gdp) + log(target_gdp) + post_cold_war + cinc_sender + cinc_target + formal_alliance + polyarchy_sender + polyarchy_target + dependence, 
  data = ties, 
  index = c("dyad", "sancstartyear"),
  model = "random"
)

phtest(fixed_effects, random_effects)

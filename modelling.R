setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(dplyr)
library(purrr)
library(ggplot2)
library(modelsummary)
library(kableExtra)
library(plm)
library(fixest)

ties <- readr::read_csv("ties_custom.csv")

# Same routine for different definitions of independent and dependent variable:
fit_models <- function(independent, dependent, data = ties) {
  formula <- reformulate(independent, response = dependent)

  # Return a list of models:
  list(
    # Naive linear model:
    "Naive" = lm(
      formula,
      data = data
    ),
    # Panel linear model, dyad FE, Driscoll-Kraay SE:
    "Panel" = feols(
      formula,
      data = data,
      panel.id = c("dyad", "sancstartyear"),
      fixef = "dyad",
      vcov = "DK"
    )
  )
}

regtable <- function(models, ...) {
  modelsummary(
    models,
    stars = c("*" = .1, "**" = .05, "***" = .01),
    gof_omit = "Log.Lik|BIC|F$",
    ...
  )
}

# Naive linear model & Dyad Fixed-Effects:

models_minimalist <- fit_models("prior_non_overlapping", "success_min") # incl. negotiated 
models_maximalist <- fit_models("prior_non_overlapping", "success") # excl. negotiated

# Manually fitting the models with covariates:
with_cov_max <- feols(
  success ~ prior_non_overlapping + power_diff + formal_alliance + polyarchy_sender + polyarchy_target,
  data = ties,
  vcov = "DK",
  panel.id = c("dyad", "sancstartyear"),
  fixef = "dyad"
)

with_cov_min <- feols(
  success_min ~ prior_non_overlapping + power_diff + formal_alliance + polyarchy_sender + polyarchy_target,
  data = ties,
  vcov = "DK",
  panel.id = c("dyad", "sancstartyear"),
  fixef = "dyad"
)

models_maximalist$`Panel with Covariates` <- with_cov_max
models_minimalist$`Panel with Covariates` <- with_cov_min

# Visually (all models):

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
  coord_flip()

c(models_maximalist, models_minimalist) |> 
  regtable(
    coef_rename = c(
      "prior_non_overlapping" = "Prior Sanctions",
      "power_diff" = "Power Difference (Sender-Target)",
      "formal_alliance" = "Formal Alliance",
      "polyarchy_sender" = "Polyarchy - Sender",
      "polyarchy_target" = "Polyarchy - Target"
    ),
    coef_omit = "Intercept",
    format = "latex"
  ) |> 
  add_header_above(
    c(
      " " = 1,
      "Success \n(Excl. negotiated settlements)" = 3,
      "Success \n(Incl. negotiated settlements)" = 3
    )
  )

c(models_maximalist, models_minimalist) |> 
  regtable(
    coef_rename = c("prior_non_overlapping" = "Prior Sanctions"),
    coef_omit = "Intercept|power_diff|formal_alliance|polyarchy_*",
    format = "latex"
  ) |> 
  add_header_above(
    c(
      " " = 1,
      "Success \n(Excl. negotiated settlements)" = 3,
      "Success \n(Incl. negotiated settlements)" = 3
    )
  )

# Robustness

# Non-US sanctions:
usa <- ties |> filter(sender == "USA")
no_usa <- ties |> filter(sender != "USA") 

usa_max <- fit_models("prior_non_overlapping", "success", data = usa)
usa_min <- fit_models("prior_non_overlapping", "success_min", data = usa)

usa_max_wcov <- feols(
  success ~ prior_non_overlapping + power_diff + formal_alliance + polyarchy_sender + polyarchy_target,
  data = usa,
  vcov = "DK",
  panel.id = c("dyad", "sancstartyear"),
  fixef = "dyad"
)

usa_min_wcov <- feols(
  success_min ~ prior_non_overlapping + power_diff + formal_alliance + polyarchy_sender + polyarchy_target,
  data = usa,
  vcov = "DK",
  panel.id = c("dyad", "sancstartyear"),
  fixef = "dyad"
)

usa_max$`Panel with Covariates` <- usa_max_wcov
usa_min$`Panel with Covariates` <- usa_min_wcov

c(usa_max, usa_min) |> regtable()

no_usa_max <- fit_models("prior_non_overlapping", "success", data = no_usa)
no_usa_min <- fit_models("prior_non_overlapping", "success_min", data = no_usa)

no_usa_max_wcov <- feols(
  success ~ prior_non_overlapping + power_diff + formal_alliance + polyarchy_sender + polyarchy_target,
  data = no_usa,
  vcov = "DK",
  panel.id = c("dyad", "sancstartyear"),
  fixef = "dyad"
)

no_usa_min_wcov <- feols(
  success_min ~ prior_non_overlapping + power_diff + formal_alliance + polyarchy_sender + polyarchy_target,
  data = no_usa,
  vcov = "DK",
  panel.id = c("dyad", "sancstartyear"),
  fixef = "dyad"
)

no_usa_max$`Panel with Covariates` <- usa_max_wcov
no_usa_min$`Panel with Covariates` <- usa_min_wcov

c(no_usa_max, no_usa_min) |> regtable()

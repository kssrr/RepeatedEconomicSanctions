#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(dplyr)
library(purrr)
library(ggplot2)
library(modelsummary)
library(kableExtra)
library(plm)
library(fixest)

ties <- readr::read_csv("ties_custom.csv")

# Same routine for different definitions of independent and dependent variable:
create_models <- function(independent, dependent) {
  formula <- reformulate(independent, response = dependent)

  # Return a list of models:
  list(
    # Naive linear model:
    "Naive" = lm(
      formula,
      data = ties
    ),
    # Panel linear model, dyad FE, white SE:
    "Panel" = feols(
      formula,
      data = ties,
      panel.id = c("dyad", "startyear"),
      fixef = "dyad",
      vcov = "white"
    ),
    # Panel linear model, dyad FE, Driscoll-Kraay SE:
    "Panel (DK)" = feols(
      formula,
      data = ties,
      panel.id = c("dyad", "startyear"),
      fixef = "dyad",
      vcov = "DK"
    )
  )
}

# Maximalist definition of sanctions:
models_maximalist <- create_models("prior", "success")

modelsummary(
  models_maximalist,
  stars = c("*" = .1, "**" = .05, "***" = .01),
  coef_omit = "Intercept",
  coef_rename = c("Prior Sanctions" = "prior"),
  gof_omit = "Log.Lik.|Std.Errors|FE: dyad|R2 Within|F",
  add_rows = tribble(
    ~ name, ~naive, ~panel, ~panel_dk,
    "FE (dyad)", "No",    "Yes",    "Yes",
    "Std. Errors", "", "", "Driscoll-Kray (L=2)"
  ),
  output = "ZZZ_results_maximalist.tex"
)

# Minimalist definition (including negotiated settlements):
models_minimalist <- create_models("prior", "success_min")

modelsummary(
  models_minimalist,
  stars = c("*" = .1, "**" = .05, "***" = .01),
  coef_omit = "Intercept",
  coef_rename = c("Prior Sanctions" = "prior"),
  gof_omit = "Log.Lik.|Std.Errors|FE: dyad|R2 Within|F",
  add_rows = tribble(
    ~ name, ~naive, ~panel, ~panel_dk,
    "FE (dyad)", "No",    "Yes",    "Yes",
    "Std. Errors", "", "", "Driscoll-Kray (L=2)"
  ),
  output = "ZZZ_results_minimalist.tex"
)

# Looking at sanctions within last five/ten years:
five <- create_models("within_last_five", "success")
five_min <- create_models("within_last_five", "success_min")

ten <- create_models("within_last_ten", "success")
ten_min <- create_models("within_last_ten", "success_min")


full_time_based <- c(ten, ten_min, five, five_min)

to_print <- modelsummary(
  full_time_based,
  stars = c("*" = .1, "**" = .05, "***" = .01),
  coef_omit = "Intercept",
  coef_rename = c(
    "within_last_ten" = "Prior Sanctions (last 10 years)",
    "within_last_five" = "Prior Sanctions (last 5 years)"
  ),
  gof_omit = "Log.Lik.|Std.Errors|FE: dyad|R2 Within|F"
)

to_print |> 
  add_header_above(
    c(
      " " = 1, 
      "Maximalist" = 3, 
      "Minimalist" = 3, 
      "Maximalist" = 3,
      "Minimalist" = 3
    )
  ) |> 
  kable(format = "latex") #|> 
  save_kable("ZZZ_results_time_based.tex")

# Visually (all models):

tidy_models <- function(models, def) {
  models |> 
    map(broom::tidy) |> 
    map2(names(models), \(df, n) df |> mutate(model = n)) |> 
    map(\(df) df |> filter(term != "(Intercept)")) |> 
    reduce(rbind) |> 
    mutate(
      definition = def,
      lower = estimate - std.error, 
      upper = estimate + std.error
    )
}

models <- list(
  "Overall (Maximalist)" = models_maximalist,
  "Overall (Minimalist)" = models_minimalist,
  "Within last 10 years \n(Maximalist)" = ten,
  "Within last 10 years \n(Minimalist)" = ten_min,
  "Within last 5 years \n(Maximalist)" = five,
  "Within last 5 years \n(Minimalist)" = five_min
)

models <-
  map2(models, names(models), \(model, def) tidy_models(model, def)) |>
  reduce(rbind)

models |> 
  ggplot(
    aes(x = factor(definition), y = estimate, color = model, shape = model)
  ) +
  geom_hline(yintercept = 0, lty = "dotted", color = "grey50") +
  geom_point(position = position_dodge(width = .3), size = 2) +
  geom_errorbar(
    aes(ymin = lower, ymax = upper), 
    position = position_dodge(width = .3),
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

## ties |>
##   mutate(duration = endyear - sancstartyear) |>
##   summarise(dur = mean(duration, na.rm = TRUE))

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
fit_models <- function(independent, dependent) {
  formula <- reformulate(independent, response = dependent)

  # Return a list of models:
  list(
    # Naive linear model:
    "Naive" = lm(
      formula,
      data = ties
    ),
    # Panel linear model, dyad FE, Driscoll-Kraay SE:
    "Panel" = feols(
      formula,
      data = ties,
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
    coef_omit = "Intercept",
    gof_omit = "Log.Lik",
    ...
  )
}

# Overall:

models_minimalist <- fit_models("prior", "success_min") # incl. negotiated 
models_maximalist <- fit_models("prior", "success") # excl. negotiated

c(models_minimalist, models_maximalist) |> 
  regtable(coef_rename = c("prior" = "Prior Sanctions")) |> 
  add_header_above(
    c(
      " " = 1,
      "Success \n(Minimalist)" = 2,
      "Success \n(Maximalist)" = 2
    )
  ) 

# Looking at sanctions within last five/ten years:

five <- fit_models("within_last_five", "success")
five_min <- fit_models("within_last_five", "success_min")
ten <- fit_models("within_last_ten", "success")
ten_min <- fit_models("within_last_ten", "success_min")


full_time_based <- c(ten, ten_min, five, five_min)

full_time_based |>
  regtable(
    coef_rename = c(
      "within_last_ten" = "Prior Sanctions (last 10 years)",
      "within_last_five" = "Prior Sanctions (last 5 years)"
    )
  ) |> 
  add_header_above(
    c(
      " " = 1, 
      "Success \n(Maximalist)" = 2, 
      "Success \n(Minimalist)" = 2, 
      "Success \n(Maximalist)" = 2,
      "Success \n(Minimalist)" = 2
    )
  )

# Dummy (prior sanctions vs. no prior sanctions):

dummy_max <- fit_models("prior_dummy", "success")
dummy_min <- fit_models("prior_dummy", "success_min")

c(dummy_min, dummy_max) |> 
  regtable(coef_rename = c("prior_dummy" = "Prior Sanctions (dummy)")) |> 
  add_header_above(
    c(
      " " = 1,
      "Success \n(Minimalist)" = 2,
      "Success \n(Maximalist)" = 2
    )
  )

# Initial sanction dummy:
initial_max <- fit_models("first_sanction", "success")
initial_min <- fit_models("first_sanction", "success_min")

c(initial_min, initial_max) |> 
  regtable(coef_rename = c("first_sanction" = "Initial Sanction")) |> 
  add_header_above(
    c(
      " " = 1,
      "Success \n(Minimalist)" = 2,
      "Success \n(Maximalist)" = 2
    )
  )

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

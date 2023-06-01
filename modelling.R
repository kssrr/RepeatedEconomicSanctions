setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(dplyr)
library(purrr)
library(ggplot2)
library(modelsummary)
library(kableExtra)
library(plm)
library(fixest)

ties <- readr::read_csv("ties_custom.csv")

# Maximalist definition of sanctions:
models_maximalist <- list(
  "Naive" = lm(
    success ~ prior, 
    data = ties
  ),
  "Panel" = plm(
    success ~ prior,
    data = ties,
    index = "dyad",
    effect = "individual",
    model = "within"
  ),
  "Panel (DK)" = feols(
    success ~ prior, 
    data = ties, 
    panel.id = c("dyad", "startyear"),
    fixef = "dyad",
    vcov = "DK"
  )
)

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
models_minimalist <- list(
  "Naive" = lm(
    success_min ~ prior, 
    data = ties
  ),
  "Panel" = plm(
    success_min ~ prior,
    data = ties,
    index = "dyad",
    effect = "individual",
    model = "within"
  ),
  "Panel (DK)" = feols(
    success_min ~ prior, 
    data = ties, 
    panel.id = c("dyad", "startyear"),
    fixef = "dyad",
    vcov = "DK"
  )
)

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

five <- list(
  "Naive" = lm(
    success ~ within_last_five, 
    data = ties
  ),
  "Panel" = plm(
    success ~ within_last_five,
    data = ties,
    index = "dyad",
    effect = "individual",
    model = "within"
  ),
  "Panel (DK)" = feols(
    success ~ within_last_five, 
    data = ties, 
    panel.id = c("dyad", "startyear"),
    fixef = "dyad",
    vcov = "DK"
  )
)

five_min <- list(
  "Naive" = lm(
    success_min ~ within_last_five, 
    data = ties
  ),
  "Panel" = plm(
    success_min ~ within_last_five,
    data = ties,
    index = "dyad",
    effect = "individual",
    model = "within"
  ),
  "Panel (DK)" = feols(
    success_min ~ within_last_five, 
    data = ties, 
    panel.id = c("dyad", "startyear"),
    fixef = "dyad",
    vcov = "DK"
  )
)

ten <- list(
  "Naive" = lm(
    success ~ within_last_ten, 
    data = ties
  ),
  "Panel" = plm(
    success ~ within_last_ten,
    data = ties,
    index = "dyad",
    effect = "individual",
    model = "within"
  ),
  "Panel (DK)" = feols(
    success ~ within_last_ten, 
    data = ties, 
    panel.id = c("dyad", "startyear"),
    fixef = "dyad",
    vcov = "DK"
  )
)

ten_min <- list(
  "Naive" = lm(
    success_min ~ within_last_ten, 
    data = ties
  ),
  "Panel" = plm(
    success_min ~ within_last_ten,
    data = ties,
    index = "dyad",
    effect = "individual",
    model = "within"
  ),
  "Panel (DK)" = feols(
    success_min ~ within_last_ten, 
    data = ties, 
    panel.id = c("dyad", "startyear"),
    fixef = "dyad",
    vcov = "DK"
  )
)

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

models <- rbind(
  tidy_models(
    models_maximalist, 
    def = "Overall \n(Maximalist)"
  ),
  tidy_models(
    models_minimalist, 
    def = "Overall \n(Minimalist)"
  ),
  tidy_models(
    ten, 
    def = "Within last 10 years \n(Maximalist)"
  ),
  tidy_models(
    ten_min, 
    def = "Within last 10 years \n(Minimalist)"
  ),
  tidy_models(
    five, 
    def = "Within last 5 years \n(Maximalist)"
  ),
  tidy_models(
    five_min, 
    def = "Within last 5 years \n(Minimalist)"
  )
)

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


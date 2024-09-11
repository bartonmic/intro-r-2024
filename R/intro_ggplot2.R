# load libraries ----
library(dplyr)
library(ggplot2)
library(readxl)

# load data ----
df_ice <- read_xlsx("data/icebreaker_answers.xlsx")

# create plots ----


tt_mi_fig <- df_ice |>
  ggplot(
    aes(x = travel_time,y = travel_mode)
    ) +
    geom_point()

tt_mi_fig

tt_mi_ox_fig <- df_ice |>
  ggplot(
    aes(x = travel_time, y = travel_distance, color = travel_mode)
  ) +
  geom_point() +
  xlab("Travel Time") +
  ylab("Travel Distance")

tt_mi_ox_fig

# adding new layer to the base figure (making black and white)
tt_mi_2 <- tt_mi_ox_fig +
  theme_bw()
tt_mi_2

# Faceting
ice_facet_fig <- df_ice |>
  ggplot(aes(x = travel_time, y = travel_distance)) +
  geom_point() + 
  facet_wrap(. ~ travel_mode, scales = "free")

ice_facet_fig

# filter first
tt_mode_car_fig <- df_ice |>
  filter(travel_mode == "bus") |>
  ggplot(aes(x = travel_time, y = travel_distance)) +
  geom_point() +
  theme_bw()

tt_mode_car_fig


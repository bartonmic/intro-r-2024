#### Aggregating and Summarizing Data ####

# import libraries ----
library(readxl)
library(dplyr)
library(ggplot2)

# read in the excel file ----
df <- read_excel("data/icebreaker_answers.xlsx")
df
summary(df)

# custom summaries of a data frame ----
df |> summarize(
  avg_dist = mean(travel_distance),
  sd_dist = sd(travel_distance),
  pct60_dist = quantile(travel_distance, prob = 0.6),
  avg_time = mean(travel_time)
)

# an aside, if you want integers, must specify
df |> mutate(travel_time = as.integer(travel_time))

# assign the summary if you want to save
# View() may show more precision
df_summ <- df |> summarize(
  avg_dist = mean(travel_distance),
  sd_dist = sd(travel_distance),
  pct60_dist = quantile(travel_distance, prob = 0.6),
  avg_time = mean(travel_time)
)
# View(df_summ) # same as clicking df_sum in environment window

# Aggregating and summarizing subsets ----
#   of a data frame
df <- df |>
  mutate(travel_speed = travel_distance / travel_time * 60)

df |>
  summarize(avg_speed = mean(travel_speed))

# average speed by mode
df |> group_by(travel_mode) |>
  summarize(avg_speed = mean(travel_speed))

# sort by avg_speed
df |> group_by(travel_mode) |>
  summarize(avg_speed = mean(travel_speed)) |>
  arrange(desc(avg_speed))

# grouped data frame
#df <- df |> group_by(travel_mode)
groups(df)

# grouping by multiple variables
df_mode_comma_grp <- df |> group_by(travel_mode, serial_comma) |>
  summarize(avg_speed = mean(travel_speed))

# have to explicitly ungroup()


# frequencies ----
#   so common there are shortcuts
df |> group_by(serial_comma) |>
  summarize(n = n())

df |> group_by(serial_comma) |>
  tally()

df |> count(serial_comma)

# can arrange this also
df |> count(serial_comma, sort=T)

# clculate a mode split (percentage using each travel mode)
df |> count(travel_mode)
df |> group_by(travel_mode) |>
  summarize(split = n() / nrow(df) * 100) |>
  arrange(desc(split))
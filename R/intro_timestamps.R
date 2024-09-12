# load libraries ----
library(dplyr)
library(ggplot2)
library(lubridate)

# load data ----

stations <- read.csv("data/portal_stations.csv")
detectors <- read.csv("data/portal_detectors.csv")
data <- read.csv("data/agg_data.csv")

str(detectors)
head(detectors$start_date)

# convert timestamps ----
detectors$start_date <- ymd_hms(detectors$start_date) |>
  with_tz("US/Pacific")
head(detectors$start_date)

# list of acceptable timezones
OlsonNames()

detectors$end_date <- ymd_hms(detectors$end_date) |>
  with_tz("US/Pacific")
head(detectors$end_date)

# filter for open detectors (no end date)
open_det <- detectors |>
  filter(is.na(end_date))
open_det

# I want the total daily volume and average volume and average speed/static
data_stid <- data |>
  left_join(open_det, by = c("detector_id" = "detectorid")) |>
  select(detector_id, starttime, volume, speed, countreadings, stationid)

# convert starttime to date format
data_stid$starttime <- ymd_hms(data_stid$starttime) |>
  with_tz("US/Pacific")

# aggregate by day
daily_data <- data_stid |>
  mutate(date = floor_date(starttime, unit = "day")) |>
  group_by(stationid,
           date) |>
  summarize(
    daily_volume = sum(volume),
    daily_obs = sum(countreadings),
    mean_speed = mean(speed)
  ) |>
  as.data.frame()

# plot data to check it out
daily_volume_fig <- daily_data |>
  ggplot(aes(x = date, y = daily_volume)) +
  geom_line() +
  geom_point() +
  facet_grid(stationid ~ ., scales = "free")
daily_volume_fig

library(plotly)
ggplotly(daily_volume_fig)

length(unique(daily_data$stationid))

stids <- unique(daily_data$stationid)

start_date <- ymd("2023-03-01")
end_date <- ymd("2023-03-31")
date_df <- data.frame(
  date_seq = rep(seq(start_date, end_date, by = "1 day")),
  station_id = rep(stids, each = 31)
)

data_with_gaps <- date_df |>
  left_join(daily_data, by = c("date_seq" = "date",
                               "station_id" = "stationid")
            )
write.csv(data_with_gaps, "data/data_with_gaps.csv", row.names = F)
saveRDS(data_with_gaps, "data/data_with_gaps.rds")

mod_date_fig <- data_with_gaps |>
  filter(station_id %in% c(1056, 1057, 1059)) |>
  ggplot(aes(x = date_seq, y = daily_volume)) +
  geom_line(aes(color = "blue")) +
  geom_point(aes(color = "skyblue")) +
  facet_grid(station_id ~ .)
mod_date_fig

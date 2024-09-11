sta_meta <- read.csv("data/portal_stations.csv")

str(sta_meta)

head(sta_meta)
tail(sta_meta)

nrow(sta_meta)

summary(sta_meta)


# Using Data Import shortcut to read in xlsx and copy/paste code
library(readxl)
icebreaker_answers <- read_excel("data/icebreaker_answers.xlsx")
View(icebreaker_answers)
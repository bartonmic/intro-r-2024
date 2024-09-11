#### Practice Problem: Loading and manipulating a data frame ####
# Don't forget: Comment anywhere the code isn't obvious to you!

# Load the readxl and dplyr packages

library(dplyr)
library(readxl)

# Use the read_excel function to load the class survey data

icebreaker_answers <- read_excel("data/icebreaker_answers.xlsx")
View(icebreaker_answers)

# Take a peek!

# Create a travel_speed column in your data frame using vector operations and 
#   assignment

icebreaker_answers$travel_speed <- 
  icebreaker_answers$travel_distance / 
  icebreaker_answers$travel_time * 60

View(icebreaker_answers)

# Look at a summary of the new variable--seem reasonable?

summary(icebreaker_answers)
hist(icebreaker_answers$travel_speed)
boxplot(icebreaker_answers$travel_speed ~ icebreaker_answers$travel_mode)

# Choose a travel mode, and use a pipe to filter the data by your travel mode

icebreaker_answers |>
  filter(
    travel_mode == "bus"
  )

# Note the frequency of the mode (# of rows returned)

# Repeat the above, but this time assign the result to a new data frame

bus <- icebreaker_answers |>
  filter(
    travel_mode == "bus"
  )

# Look at a summary of the speed variable for just your travel mode--seem 
#   reasonable?

summary(bus)

# Filter the data by some arbitrary time, distance, or speed threshold

icebreaker_answers |>
  filter(
    travel_speed <= 10 | travel_speed >= 20
  )


# Stretch yourself: Repeat the above, but this time filter the data by two 
#   travel modes (Hint: %in%)

icebreaker_answers |>
  filter(
    travel_mode %in% c("bus", "light rail")
  )

# Calculate the average speed for each mode of transportation
avg_speed_by_mode <- icebreaker_answers |>
  group_by(travel_mode) |>
  summarize(avg_speed = mean(travel_speed, na.rm = TRUE))

# View the result
print(avg_speed_by_mode)

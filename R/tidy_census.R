# import libraries ----
library(tidycensus) # acts as gateway to the census API for ACS and Decinial data
                    # for more info: https://walker-data.com/tidycensus/
library(dplyr)
library(tidyr)
library(ggplot2)

#### Run on first use if not already stored in R ####
# installs into R user environment
census_api_key("myCensusAPIKey", install=T) 
readRenviron("~/.Renviron")
####

#### User functions ####

####

# get a searchable census variable table
v19 <- load_variables(2019, "acs5")
v19 |> filter(grepl("^B08006_", name))

# get the data for transit, wfh, and total workers ----
# ?get_acs
comm_19_raw <- get_acs(geography = "tract",
                       variable = c(wfh = "B08006_017",
                                    transit = "B08006_008",
                                    tot = "B08006_001"),
                       county = "Multnomah",
                       state = "OR",
                       year = 2019,
                       survey = "acs5",
                       geometry = FALSE # can retrieve library(of)
                                        # spatial geoms pre-joined
                       )
comm_19_raw

comm_19 <- comm_19_raw |>
  pivot_wider(id_cols = GEOID:NAME,
              names_from = variable,
              values_from = estimate:moe)

comm_19


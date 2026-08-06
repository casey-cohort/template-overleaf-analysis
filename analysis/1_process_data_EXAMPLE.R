# Create analytic data set

pacman::p_load('tidyverse', 'here')

sightings <- read_csv(here('data/raw/occurrences_EXAMPLE.csv')) %>%
  group_by(year, quarter = quarter(date), organism_name) %>%
  summarize(sightings = n())

tourists <- read_csv(here('data/raw/tourism_EXAMPLE.csv')) %>%
  group_by(year, quarter) %>%
  summarize(trips = sum(trips))

weather <- read_csv(here('data/raw/weather_EXAMPLE.csv')) %>%
  group_by(year, quarter = quarter(date)) %>%
  summarize(rainy_days = sum(rainy, na.rm = TRUE))

reduce(list(sightings, tourists, weather), ~ full_join(.x, .y, by = c('year', 'quarter'))) %>%
  write_csv(here('data/processed/quarterly_obs_EXAMPLE.csv'))

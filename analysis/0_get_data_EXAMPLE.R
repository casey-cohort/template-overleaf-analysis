# Get raw data

pacman::p_load('here')

download.file('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/occurrences.csv', destfile = here('data/raw/occurrences_EXAMPLE.csv'))
download.file('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/tourism.csv', destfile = here('data/raw/tourism_EXAMPLE.csv'))
download.file('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/weather.csv', destfile = here('data/raw/weather_EXAMPLE.csv'))

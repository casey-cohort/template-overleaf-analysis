# Generate figures for manuscript

pacman::p_load('tidyverse', 'here')
source(here('tex_helpers.R'))

dat <- read_csv(here('data/processed/quarterly_obs_EXAMPLE.csv'))

write_tex_vars(
  list(
    `avgglowwormsightings_EXAMPLE` = dat %>% filter(organism_name == 'Glowworm') %>% pull(sightings) %>% mean(),
    `avgorchidsightings_EXAMPLE` = dat %>% filter(organism_name == 'Orchid') %>% pull(sightings) %>% mean()
  ),
  path = here('tex/vals.tex')
)

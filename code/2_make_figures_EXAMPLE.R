# Generate figures for manuscript

pacman::p_load('tidyverse', 'here')

dat <- read_csv(here('data/processed/quarterly_obs_EXAMPLE.csv'))

p <- ggplot(dat) + 
  geom_line(aes(x = year, y = sightings, color = organism_name)) +
  scale_y_log10() + 
  facet_wrap(~quarter)

ggsave(p, filename = here('tables_figures/lineplot_EXAMPLE.png'))
  
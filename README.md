# template-overleaf-analysis
Template repository for the R analysis portion of an overleaf project

## Setup

1. Create both an analysis and [manuscript](https://github.com/casey-cohort/template-overleaf-manuscript) repository from the templates. 
1. Create a **classic** [personal access](https://github.com/settings/personal-access-tokens) (PAT) token with read and write access to the manuscript repository. 
1. In this (analysis) repository, go to Settings > Secrets and Variables > Actions, and
create a new "Repository Secret". Paste the PAT into the "Secret" field and title it "MANUSCRIPT_PAT". 
1. Next click the "Variables" tab, and create a "Repository Variable". Title this one "MANUSCRIPT_REPO", and enter the name of your manuscript repo, including its owner. E.g. "a-einstein/relativity-manuscript". 
1. Make sure Actions are enabled under Settings > General > Actions permissions.
1. Update README file to reflect your project.

## Usage

Write figures, tables, etc. to the `tables_figures` directory. Write LateX files
to the `tex` directory. Whenever you push a change to these directories, they will
be copied to the manuscript directory as `tables_figures_sync` and `tex_sync`. These
will be overwritten in the target directory!

By convention the dynamic values file is `tex/analysis-values.tex` — the manuscript
template already `\input`s it as `tex_sync/analysis-values.tex`. Use another name only
if you also update the `\input` line(s) in the manuscript's `main.tex`.

A file `tex_helpers.R` is included to set up the LateX variables in R. It includes functions to:

### Write a tex variable list

`write_tex_vars` takes a named list and exports a .tex file that you can `%include` into your 
LateX manuscript to dynamically update formatted numbers or strings.

E.g. 

```r
source('tex_helpers.R')
write_tex_vars(list(a = 1, b = 1.2345, c = 1000000, d = 'dog'), 'tex/analysis-values.tex')
```

creates this file:

```tex
\newcommand{\a}{1}
\newcommand{\b}{1.23}
\newcommand{\c}{1,000,000}
\newcommand{\d}{dog}
```

Note that the numbers have been formatted. See the manuscript repository for details about
how to use these `\newcommand` shortcuts in your manuscript. 

### Write a single tex variable

If you want to customize individual tex values, you can handle the writing of the tex file
yourself and use the function `texify`. 

E.g. 

```r
texify('e', exp(1))

## [1] "\\newcommand{\\e}{2.72}"
```

Note that for character values, `texify` (and therefore `write_tex_vars`)
applies two automatic substitutions: `%` is escaped to `\%` for LaTeX, and
parentheses are rewritten to square brackets so confidence intervals render as
`[1.2, 3.4]` instead of `(1.2, 3.4)`. Underscores in the variable *name* are
stripped, since LaTeX command names can't contain them (`n_total` becomes
`\ntotal`).

### Nearly/More Than

Since we commonly use phrases like "almost", "nearly", "at least", or "more than" when 
describing numbers in a manuscript, some convenience functions are also included to be 
used in conjuction with the tex function. 

```r
nearly(9871, by = 10000) # "There are nearly ### instances per year."

## [1] 10000

more_than(58, by = 50) # "The study included more than ### interviews." 

## [1] 50
```

## Example Analysis

This repo contains a minimal example analysis pulled from the July 28, 2026 
[Tidy Tuesday](https://github.com/rfordatascience/tidytuesday/tree/main/data/2026/2026-07-28),
which has example data on tourism and animal sightings in Australia. 

The example outputs are also included in the manuscript repo. 

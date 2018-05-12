
<!-- README.md is generated from README.Rmd. Please edit that file -->

# oldr: An Implementation of the Rapid Assessment Method for Older People (RAM-OP) in R

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![CRAN](https://img.shields.io/cran/v/oldr.svg)](https://cran.r-project.org/package=oldr)
[![CRAN](https://img.shields.io/cran/l/oldr.svg)](https://CRAN.R-project.org/package=oldr)
[![CRAN](http://cranlogs.r-pkg.org/badges/oldr)](https://CRAN.R-project.org/package=oldr)
[![Travis](https://img.shields.io/travis/validmeasures/oldr.svg?branch=master)](https://travis-ci.org/validmeasures/oldr)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/validmeasures/oldr?branch=master&svg=true)](https://ci.appveyor.com/project/validmeasures/oldr)
[![codecov](https://codecov.io/gh/validmeasures/oldr/branch/master/graph/badge.svg)](https://codecov.io/gh/validmeasures/oldr)

[HelpAge International](http://www.helpage.org), [VALID
International](http://www.validinternational.org), and [Brixton
Health](http://www.brixtonhealth.com), with financial assistance from
the [Humanitarian Innovation Fund
(HIF)](http://www.elrha.org/hif/home/), have developed a **Rapid
Assessment Method for Older People (RAM-OP)** that provides accurate and
reliable estimates of the needs of older people. The method uses simple
procedures, in a short time frame (i.e. about two weeks including
training, data collection, data entry, and data analysis), and at
considerably lower cost than other methods. The **RAM-OP** method is
based on the following principles:

  - Use of a familiar *“household survey”* design employing a two-stage
    cluster sample design optimised to allow the use of a small primary
    sample (*m ≥ 16 clusters*) and a small overall (*n ≥ 192*) sample.

  - Assessment of multiple dimensions of need in older people (including
    prevalence of global, moderate and severe acute malnutrition) using,
    whenever possible, standard and well-tested indicators and question
    sets.

  - Data analysis performed using modern computer-intensive methods to
    allow estimates of indicator levels to be made with useful precision
    using a small sample size.

## Installing

This package is currently in active development in preparation for
submission to the CRAN repository. The development version of `oldr` can
be installed in `R` via the following commands:

``` r
# install.packages("devtools")
devtools::install_github("rapidsurveys/oldr")
```

## Usage

This package contains functions that support in the data processing,
analysis and visualisation of RAM-OP survey datasets collected using the
standard RAM-OP survey questionnaire. For a more detailed description of
the RAM-OP survey, read the [RAM-OP
manual](https://ram.validmeasures.org/ramOPmanual).


<!-- README.md is generated from README.Rmd. Please edit that file -->

# oldr: An Implementation of the Rapid Assessment Method for Older People (RAM-OP) <img src="man/figures/oldr.png" width="200" align="right" />

<!-- Badges start here-->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN](https://img.shields.io/cran/l/oldr.svg)](https://CRAN.R-project.org/package=oldr)
[![CRAN](https://img.shields.io/cran/v/oldr.svg)](https://cran.r-project.org/package=oldr)
[![CRAN](http://cranlogs.r-pkg.org/badges/oldr)](https://CRAN.R-project.org/package=oldr)
[![Travis](https://img.shields.io/travis/rapidsurveys/oldr.svg?branch=master)](https://travis-ci.org/rapidsurveys/oldr)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/rapidsurveys/oldr?branch=master&svg=true)](https://ci.appveyor.com/project/rapidsurveys/oldr)
[![R build
status](https://github.com/rapidsurveys/oldr/workflows/R-CMD-check/badge.svg)](https://github.com/rapidsurveys/oldr/actions)
[![codecov](https://codecov.io/gh/rapidsurveys/oldr/branch/master/graph/badge.svg)](https://codecov.io/gh/rapidsurveys/oldr)
[![CodeFactor](https://www.codefactor.io/repository/github/rapidsurveys/oldr/badge)](https://www.codefactor.io/repository/github/rapidsurveys/oldr)
<!-- Badges end here-->

<!-- [![cran checks](https://cranchecks.info/badges/summary/oldr)](https://cran.r-project.org/web/checks/check_results_oldr.html) -->

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

## Installation

You can install `oldr` from [CRAN](https://cran.r-project.org) with:

``` r
install.packages("oldr")
```

You can install the development version of `oldr` from
[GitHub](https://github.com/rapidsurveys/oldr) with:

``` r
if(!require(remotes)) install.packages("remotes")
remotes::install_github("rapidsurveys/oldr")
```

## Usage

This package contains functions that support in the data processing,
analysis and visualisation of RAM-OP survey datasets collected using the
standard RAM-OP survey questionnaire.

The figure below illustrates the RAM-OP workflow and indicates which
functions in the `oldr` package support which particular step in the
process.

<img src="man/figures/ramOPworkflow.png" width="80%" style="display: block; margin: auto;" />

For a more detailed description of the RAM-OP survey, read the [RAM-OP
manual](https://rapidsurveys.io/ramOPmanual/).

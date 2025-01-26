## Release summary

This is a patch release to address address a NOTE and an ERROR produced during
CRAN check

* NOTE on r-devel-windows-x86_64

```
Missing dependency on R >= 4.2.0 because package code uses the pipe
    placeholder syntax added in R 4.2.0.
    File(s) using such syntax:
      '01-opIndicators.R'
```

    - I have originally had dependency to R 4.1.0 thinking that this was the
    version in which placeholder syntax was added. I have now increased this to
    4.2.0.

* ERROR on r-release-macos-x86_64 for exampls and tests

```
Error: pandoc version 1.12.3 or higher is required and was not found (see the help page ?rmarkdown::pandoc_available)
```

    - I have now added a conditionality in the examples for the `report_op_*()` set of functions such that it will only be evaluated if the PANDOC version is at least `1.12.3`

    - I have added `skip_on_cran()` for all tests for the `report_op_*()` set of functions


## Test environments
* local OS X install, R 4.4.2
* local ubuntu 22.04 install, R 4.4.2
* win-builder (devel, release, and old release)
* github actions windows-latest, r: release
* github actions macOS-latest, r: release
* github actions ubuntu-22.04, r: release, devel, old release
* rhub windows-latest r devel
* rhub ubuntu 22.04 r devel
* rhub macos r devel
* rhub macos-arm64 r devel


## R CMD check results

### For all checks, the results showed:

  New submission

0 errors | 0 warnings | 1 note

* This is a new release.


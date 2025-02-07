# oldr 0.2.4.9000

This is a patch release of `{oldr}`. This fixes a NOTE and an ERROR on routine CRAN checks in preparation for an update CRAN release in the near future.

* NOTE on R version dependency

    - Since the package uses the base pipe (`|>`) and uses the placeholder syntax, the R version dependency has been updated from 4.1.0 to 4.2.0

* ERROR on minimum Pandoc version required

    - The release macOS flavour in CRAN checks most likely uses a version of Pandoc earlier than version `1.12.3` hence examples and tests for the `report_op_*()` function set is failing. A condition has now been added to the `report_op_*()` function set examples such that they will only be run/tested if the available Pandoc has version `1.12.3` or later. For tests, `report_op_*()` function set tests have been set to be skipped during CRAN checks.


# oldr 0.2.3

This is the first CRAN release of `{oldr}`.


# oldr 0.1.1

* Created full suite of estimator functions

* Create full suite of charting functions

* Created full suite of reporting functions

* Completed documentation via README and vignettes of RAM-OP workflow using `oldr`

* Completed ci/cd with Travis, AppVeyor and GitHub Actions

* Initiated coverage check using GitHub Actions and Codecov

* Added a `NEWS.md` file to track changes to the package.

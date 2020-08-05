## Resubmission
This is a resubmission. In have corrected the following issues as per CRAN
comments:

* Checked all examples to ensure they can run less than 5 seconds

* Checked all examples that I previously put within \dontrun{} and ensured
that they can run during package build and test and that they run for less than
5 seconds

* Re-worked functions that previously wrote into user's home filespace such
that they now write into `tempdir()` by default

* Removed redundant language in the title. The title now reads "An Implementation
of Rapid Assessment Method for Older People"

I performed all checks again with the following results:

## Test environments
* macOS latest (local R installation, R 4.0.2)
* ubuntu 16.04 (on travis-ci), R 4.0.2
* win-builder (release, oldrelease)
* windows latest (on github actions, release)
* macOS latest (on github actions, release)
* ubuntu 16.04 (on github actions, release)
* ubuntu 16.04, fedora, windows (on rhub, devel, release)

## R CMD check results

### For all checks, the results showed:

  New submission

0 errors | 0 warnings | 1 note

* This is a new release.

* All checks ran for less than 10 minutes

## Reverse dependencies

This is a new release. There are no reverse/downstream dependencies.


## RESUBMISSION

In this resubmission, I addressed the following comments from CRAN:

* It seems like you have too many spaces in your description field. Probably because linebreaks count as spaces too. Please remove unecassary ones.

    - I removed spaces from previous line before a line break and then removed the last two sentences to avoid creating more line breaks

* You have examples for unexported functions. Please either omit these examples or export these functions.

    - I removed all examples from unexported functions

* `\dontrun{}` should only be used if the example really cannot be executed

    - I removed `\dontrun{}` from the example for the `merge_op()` function.

* `if (FALSE)` in examples should never be used

    - I removed the `if (FALSE)` example in the `report_op_pdf()` function
    documentation and added `donttest{}` as the example takes longer than 5s.

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


## Release summary

This is a patch release to address address a NOTE produced during
CRAN check

* NOTE on r-devel-linux-x86_64-debian-clang, r-devel-linux-x86_64-debian-gcc, r-devel-linux-x86_64-fedora-clang, r-devel-linux-x86_64-fedora-gcc, r-devel-windows-x86_64

```
Missing dependency on R >= 4.2.0 because package code uses the pipe
    placeholder syntax added in R 4.2.0.
    File(s) using such syntax:
      '01-opIndicators.R'
```

    - I have originally had dependency to R 4.1.0 thinking that this was the
    version in which placeholder syntax was added. I have now increased this to
    4.2.0.

## Test environments
* local OS X install, R 4.5.2
* local ubuntu 22.04 install, R 4.5.2
* win-builder (devel, release, and old release)
* github actions windows-latest, r: release
* github actions macOS-latest, r: release
* github actions ubuntu-24.04, r: release, devel, old release
* rhub windows-latest r devel
* rhub ubuntu 24.04 r devel
* rhub macos r devel
* rhub macos-arm64 r devel
* macbuilder (devel)

## R CMD check results

### Local checks

0 errors | 0 warnings | 0 notes

### win-builder checks - devel and release

0 errors | 0 warnings | 0 notes

### win-builder checks - old release

0 errors | 0 warnings | 1 note

Author field differs from that derived from Authors@R
  Author:    'Mark Myatt [aut, cph], Ernest Guevarra [aut, cre, cph] (ORCID: <https://orcid.org/0000-0002-4887-4415>)'
  Authors@R: 'Mark Myatt [aut, cph], Ernest Guevarra [aut, cre, cph] (<https://orcid.org/0000-0002-4887-4415>)'

Both ORCID information are the same but formatted differently.

### GitHub Actions checks

0 errors | 0 warnings | 0 notes

### rhub checks

0 errors | 0 warnings | 0 notes

### macbuilder checks

0 errors | 0 warnings | 0 notes

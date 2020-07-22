## Test environments
* local R installation, R 4.0.2
* ubuntu 16.04 (on travis-ci), R 4.0.2
* win-builder (devel, release, oldrelease)
* github actions windows-latest (release)
* github actions macOS-latest (release)
* github actions ubuntu 16.04-latest (release)
* rhub windows, ubuntu 16.04, fedora (devel, release)

## R CMD check results

### For all checks, the results showed:

0 errors | 0 warnings | 1 note

* This is a new release.

### For rhub checks, the results showed:

  Build ID:   oldr_0.1.0.tar.gz-f8970ea2004444d1bbde69d0cd7c81fd
  Platform:   Windows Server 2008 R2 SP1, R-devel, 32/64 bit
  Submitted:  8m 34.8s ago
  Build time: 8m 14.6s

> checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Ernest Guevarra <ernest@guevarra.io>'
  
  New submission

0 errors ✓ | 0 warnings ✓ | 1 note x

-----

  Build ID:   oldr_0.1.0.tar.gz-d8e03fb66bfa4bceaf0f1fcf2248e854
  Platform:   Ubuntu Linux 16.04 LTS, R-release, GCC
  Submitted:  9m 57.4s ago

> checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Ernest Guevarra <ernest@guevarra.io>'
  
  New submission

0 errors ✓ | 0 warnings ✓ | 1 note x

-----

  Build ID:   oldr_0.1.0.tar.gz-4fb1544c0b2d49e1b4c69fc55d0b31d4
  Platform:   Fedora Linux, R-devel, clang, gfortran
  Submitted:  9m 57.4s ago

> checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Ernest Guevarra <ernest@guevarra.io>'
  
  New submission

0 errors ✓ | 0 warnings ✓ | 1 note x


## Reverse dependencies

This is a new release, so there are no reverse/downstream dependencies.



test_that("x is all variables", {
  expect_equal(length(get_variables()), 137)
})

test_that("x correct indicator set", {
  expect_true("resp1" %in% get_variables("demo"))
})

test_that("x correct indicator set", {
  expect_true("DDS" %in% get_variables("food"))
})

test_that("x correct indicator set", {
  expect_true("HHS1" %in% get_variables("hunger"))
})

test_that("x correct indicator set", {
  expect_true("ADL06" %in% get_variables("adl"))
})

test_that("x correct indicator set", {
  expect_true("wgP0" %in% get_variables("disability"))
})

test_that("x correct indicator set", {
  expect_true("K6" %in% get_variables("mental"))
})

test_that("x correct indicator set", {
  expect_true("DS" %in% get_variables("dementia"))
})

test_that("x correct indicator set", {
  expect_true("H1" %in% get_variables("health"))
})

test_that("x correct indicator set", {
  expect_true("M1" %in% get_variables("income"))
})

test_that("x correct indicator set", {
  expect_true("W1" %in% get_variables("wash"))
})

test_that("x correct indicator set", {
  expect_true("MUAC" %in% get_variables("anthro"))
})

test_that("x correct indicator set", {
  expect_true("oedema" %in% get_variables("oedema"))
})

test_that("x correct indicator set", {
  expect_true("screened" %in% get_variables("screening"))
})

test_that("x correct indicator set", {
  expect_true("poorVA" %in% get_variables("visual"))
})

test_that("x correct indicator set", {
  expect_true("NFRI" %in% get_variables("misc"))
})

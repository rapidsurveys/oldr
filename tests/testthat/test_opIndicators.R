library(ramOP)
context("Create Older People Indicators")

x <- createOP(testSVY)

test_that("x is a data.frame", {
  expect_is(x, "data.frame")
})

test_that("x has 192 variables", {
  expect_equal(ncol(x), 138)
})

test_that("names(x) is names(indicators.ALL)", {
  expect_equal(names(x)[1], names(indicators.ALL)[1])
  expect_equal(names(x)[10], names(indicators.ALL)[10])
  expect_equal(names(x)[50], names(indicators.ALL)[50])
  expect_equal(names(x)[100], names(indicators.ALL)[100])
  expect_equal(names(x)[130], names(indicators.ALL)[130])
  expect_equal(names(x)[138], names(indicators.ALL)[138])
})

test_that("class of x vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class), lapply(indicators.ALL, class))
})

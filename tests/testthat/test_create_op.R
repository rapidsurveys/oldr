library(oldr)
context("Create Older People Indicators")

x <- create_op_all(testSVY)

test_that("x is a data.frame", {
  expect_is(x, "data.frame")
})

test_that("x has 138 variables", {
  expect_equal(ncol(x), 138)
})

x <- create_op_demo(testSVY)

test_that("x is a data.frame", {
  expect_is(x, "data.frame")
})

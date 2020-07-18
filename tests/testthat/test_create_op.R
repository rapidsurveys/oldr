library(oldr)
context("Create Older People Indicators")

x <- create_op_all(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})

test_that("x has 138 variables", {
  expect_equal(ncol(x), 138)
})

x <- create_op_demo(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_adl(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_dementia(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_disability(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_food(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_health(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_hunger(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_income(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_mental(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_oedema(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_screening(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_visual(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_wash(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})


x <- create_op_misc(testSVY)

test_that("x is a tbl", {
  expect_is(x, "tbl")
})

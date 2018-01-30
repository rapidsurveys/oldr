library(ramOP)
context("Tests for charts")

test <- chartAge(x = indicators.ALL, filename = "TEST")
test

test_that("output chart is present", {
  expect_true(file.exists("TEST.AgeBySex.png"))
})

test_that("is integer", {
  expect_is(test, "integer")
})


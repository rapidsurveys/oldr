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

test <- chartMUAC(x = indicators.ALL, filename = "TEST")
test

test_that("output chart is present", {
  expect_true(file.exists("TEST.MUAC.png"))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartMF(x = indicators.ALL, filename = "TEST")
test

test_that("output chart is present", {
  expect_true(file.exists("TEST.MF.png"))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartDDS(x = indicators.ALL, filename = "TEST")
test

test_that("output chart is present", {
  expect_true(file.exists("TEST.DDS.png"))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartK6(x = indicators.ALL, filename = "TEST")
test

test_that("output chart is present", {
  expect_true(file.exists("TEST.K6.png"))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartADL(x = indicators.ALL, filename = "TEST")
test

test_that("output chart is present", {
  expect_true(file.exists("TEST.ADL.png"))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartWASH(x = indicators.ALL, filename = "TEST")
test

test_that("output chart is present", {
  expect_true(file.exists("TEST.WASH.png"))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartCSID(x = indicators.ALL, filename = "TEST")
test

test_that("output chart is present", {
  expect_true(file.exists("TEST.dementia.png"))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartWG(x = indicators.ALL, filename = "TEST")
test

test_that("output chart is present", {
  expect_true(file.exists("TEST.disability.png"))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartHHS(x = indicators.ALL, filename = "TEST")
test

test_that("output chart is present", {
  expect_true(file.exists("TEST.HHS.png"))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartIncome(x.male = indicators.MALES,
                    x.female = indicators.FEMALES,
                    filename = "TEST")
test

test_that("output chart is present", {
  expect_true(file.exists("TEST.Incomes.png"))
})

test_that("is integer", {
  expect_is(test, "integer")
})

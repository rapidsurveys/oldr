library(oldr)
context("Tests for charts")

test <- chartAge(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.AgeBySex.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartMUAC(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.MUAC.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartMF(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.MF.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartDDS(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.DDS.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartK6(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.K6.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartADL(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.ADL.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartWASH(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.WASH.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartCSID(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.dementia.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartWG(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.disability.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartHHS(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.HHS.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chartIncome(x.male = indicators.MALES,
                    x.female = indicators.FEMALES,
                    filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.Incomes.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

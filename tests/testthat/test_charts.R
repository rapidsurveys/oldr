library(oldr)
context("Tests for charts")

test <- chart_age(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.AgeBySex.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chart_muac(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.MUAC.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chart_mf(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.MF.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chart_dds(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.DDS.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chart_k6(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.K6.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chart_adl(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.ADL.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chart_wash(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.WASH.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chart_csid(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.dementia.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chart_wg(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.disability.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chart_hhs(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.HHS.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

test <- chart_income(x.male = indicators.MALES,
                     x.female = indicators.FEMALES,
                     filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.Incomes.png", sep = "/")))
})

test_that("is integer", {
  expect_is(test, "integer")
})

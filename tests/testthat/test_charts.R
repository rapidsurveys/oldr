test <- chart_op_age(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.AgeBySex.png", sep = "/")))
})

test_that("is integer", {
  expect_type(test, "integer")
})

test <- chart_op_muac(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.MUAC.png", sep = "/")))
})

test_that("is integer", {
  expect_type(test, "integer")
})

test_that("output shows on console", {
  expect_snapshot_output(
    chart_op_muac(x = indicators.ALL, save_chart = FALSE)
  )
})

test <- chart_op_mf(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.MF.png", sep = "/")))
})

test_that("is integer", {
  expect_type(test, "integer")
})

test <- chart_op_dds(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.DDS.png", sep = "/")))
})

test_that("is integer", {
  expect_type(test, "integer")
})

test <- chart_op_k6(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.K6.png", sep = "/")))
})

test_that("is integer", {
  expect_type(test, "integer")
})

test <- chart_op_adl(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.ADL.png", sep = "/")))
})

test_that("is integer", {
  expect_type(test, "integer")
})

test <- chart_op_wash(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.WASH.png", sep = "/")))
})

test_that("is integer", {
  expect_type(test, "integer")
})

test <- chart_op_csid(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.dementia.png", sep = "/")))
})

test_that("is integer", {
  expect_type(test, "integer")
})

test <- chart_op_wg(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.disability.png", sep = "/")))
})

test_that("is integer", {
  expect_type(test, "integer")
})

test <- chart_op_hhs(x = indicators.ALL, filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.HHS.png", sep = "/")))
})

test_that("is integer", {
  expect_type(test, "integer")
})

test <- chart_op_income(
  x = indicators.ALL,
  filename = paste(tempdir(), "TEST", sep = "/"))
test

test_that("output chart is present", {
  expect_true(file.exists(paste(tempdir(), "TEST.incomes.png", sep = "/")))
})

test_that("is integer", {
  expect_type(test, "integer")
})

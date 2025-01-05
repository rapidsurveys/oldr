
test <- estimate_op(x = indicators.ALL, w = testPSU, replicates = 19)

test_that("output has 139 rows", {
  expect_equal(nrow(test), 139)
})

test_that("output has 10 columns", {
  expect_equal(ncol(test), 13)
})


test <- estimate_op(x = indicators.ALL, w = testPSU, indicators = "demo", replicates = 19)

test_that("output has 19 rows", {
  expect_equal(nrow(test), 19)
})

test_that("output has 10 columns", {
  expect_equal(ncol(test), 13)
})


test <- estimate_op(x = indicators.ALL, w = testPSU, indicators = "anthro", replicates = 19)

test_that("output has 3 rows", {
  expect_equal(nrow(test), 3)
})

test_that("output has 10 columns", {
  expect_equal(ncol(test), 13)
})

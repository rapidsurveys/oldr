
test <- estimate_probit(x = indicators.ALL, w = testPSU, replicates = 19)

test_that("output has 3 rows", {
  expect_equal(nrow(test), 3)
})

test_that("output has 10 columns", {
  expect_equal(ncol(test), 10)
})

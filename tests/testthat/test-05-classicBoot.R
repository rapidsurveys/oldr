
test <- estimate_classic(x = indicators.ALL, w = testPSU, replicates = 19)

test_that("output has 136 rows", {
  expect_equal(nrow(test), 136)
})


test_that("output has 10 columns", {
  expect_equal(ncol(test), 10)
})

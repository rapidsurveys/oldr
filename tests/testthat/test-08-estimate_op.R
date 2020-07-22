
test <- estimate_op_all(x = indicators.ALL, w = testPSU, replicates = 19)

test_that("output has 139 rows", {
  expect_equal(nrow(test), 139)
})


test_that("output has 10 columns", {
  expect_equal(ncol(test), 13)
})

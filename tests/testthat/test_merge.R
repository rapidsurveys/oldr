x <- estimate_classic(x = create_op(testSVY),
                      w = testPSU,
                      replicates = 19)

y <- estimate_probit(x = create_op(testSVY),
                     w = testPSU,
                     replicates = 19)

z <- merge_op(x, y, prop2percent = TRUE)

test_that("z has 139 rows", {
  expect_equal(nrow(z), 139)
})

test_that("z has 13 columns", {
  expect_equal(ncol(z), 13)
})



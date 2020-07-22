
x <- probit_gam(x = indicators.ALL, params = "MUAC", threshold = 210)
y <- probit_gam(x = indicators.ALL, params = "MUAC", threshold = 210)

test_that("output is numeric", {
  expect_is(x, "numeric")
  expect_is(y, "numeric")
})

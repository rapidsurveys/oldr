
x <- probit_gam(x = indicators.ALL, params = "MUAC", threshold = 210)
y <- probit_gam(x = indicators.ALL, params = "MUAC", threshold = 210)

test_that("output is numeric", {
  expect_type(x, "double")
  expect_type(y, "double")
})

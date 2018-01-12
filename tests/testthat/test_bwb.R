library(ramOP)
context("Blocked weighted bootstrap")

boot <- bootBW(x = indicators.ALL,
               w = testPSU,
               statistic = bootClassic,
               params = "ADL01",
               outputColumns = "ADL01",
               replicates = 9)

test_that("boot is a data frame", {
  expect_is(boot, "data.frame")
})

test_that("boot vectors are numeric", {
  expect_is(boot[ , 1], "numeric")
})

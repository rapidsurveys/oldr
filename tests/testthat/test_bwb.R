library(ramOP)
context("Blocked weighted bootstrap")

test_that("boot is a data frame", {
  boot <- bootBW(x = indicators.ALL,
                 w = testPSU,
                 statistic = bootClassic,
                 params = "ADL01",
                 outputColumns = "ADL01",
                 replicates = 9)
  expect_is(boot, "data.frame")
})

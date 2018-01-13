library(ramOP)
context("Full Table")

xTable <- fullTable(x = sample(x = 5,
                               size = 100,
                               replace = TRUE),
                    values = 1:5)

test_that("xTable is numeric", {
  expect_is(xTable, "numeric")
})

test_that("xTable length is x", {
  expect_equal(length(xTable), 5)
})

test_that("xTable total is size", {
  expect_equal(sum(xTable), 100)
})

test_that("xTable names is values", {
  expect_match(names(xTable)[1], "1")
  expect_match(names(xTable)[2], "2")
  expect_match(names(xTable)[3], "3")
  expect_match(names(xTable)[4], "4")
  expect_match(names(xTable)[5], "5")
})

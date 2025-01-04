x <- create_op(testSVY)

test_that("x is a data.frame", {
  expect_s3_class(x, "data.frame")
})

x <- create_op(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})

test_that("x has 138 variables", {
  expect_equal(ncol(x), 138)
})

x <- create_op(testSVY, sex = "m")

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})

test_that("x has 138 variables", {
  expect_equal(ncol(x), 138)
})

x <- create_op(testSVY, sex = "f")

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})

test_that("x has 138 variables", {
  expect_equal(ncol(x), 138)
})

x <- create_op_demo(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_adl(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_dementia(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_disability(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_food(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_health(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_hunger(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_income(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_mental(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_oedema(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_screening(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_visual(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_wash(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})


x <- create_op_misc(testSVY)

test_that("x is a tbl", {
  expect_s3_class(x, "tbl")
})

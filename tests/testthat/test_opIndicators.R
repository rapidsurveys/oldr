x <- create_op(testSVY)

test_that("x is a data.frame", {
  expect_s3_class(x, "data.frame")
})

test_that("x has 192 variables", {
  expect_equal(ncol(x), 138)
})

test_that("names(x) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
})

test_that("class of x vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["wgP3"]], lapply(indicators.ALL, class)[["wgP3"]])
  expect_equal(lapply(x, class)[["MUAC"]], lapply(indicators.ALL, class)[["MUAC"]])
  expect_equal(lapply(x, class)[["M1"]], lapply(indicators.ALL, class)[["M1"]])
  expect_equal(lapply(x, class)[["HHS1"]], lapply(indicators.ALL, class)[["HHS1"]])
})

## Test gender
x <- create_op(testSVY, sex = "m")

test_that("x is a data.frame", {
  expect_s3_class(x, "data.frame")
})

test_that("x has 192 variables", {
  expect_equal(ncol(x), 138)
})

test_that("names(x) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
})

test_that("class of x vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["wgP3"]], lapply(indicators.ALL, class)[["wgP3"]])
  expect_equal(lapply(x, class)[["MUAC"]], lapply(indicators.ALL, class)[["MUAC"]])
  expect_equal(lapply(x, class)[["M1"]], lapply(indicators.ALL, class)[["M1"]])
  expect_equal(lapply(x, class)[["HHS1"]], lapply(indicators.ALL, class)[["HHS1"]])
})

## Demography
x <- create_op_demo(testSVY, sex = "m")
y <- create_op_demo(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 192 variables", {
  expect_equal(ncol(x), 20)
  expect_equal(ncol(y), 20)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["age"]], lapply(indicators.ALL, class)[["age"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["marital4"]], lapply(indicators.ALL, class)[["marital4"]])
  expect_equal(lapply(x, class)[["alone"]], lapply(indicators.ALL, class)[["alone"]])
  expect_equal(lapply(y, class)[["age"]], lapply(indicators.ALL, class)[["age"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["marital4"]], lapply(indicators.ALL, class)[["marital4"]])
  expect_equal(lapply(y, class)[["alone"]], lapply(indicators.ALL, class)[["alone"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## Diets
x <- create_op_food(testSVY, sex = "m")
y <- create_op_food(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 192 variables", {
  expect_equal(ncol(x), 31)
  expect_equal(ncol(y), 31)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["MF"]], lapply(indicators.ALL, class)[["MF"]])
  expect_equal(lapply(x, class)[["DDS"]], lapply(indicators.ALL, class)[["DDS"]])
  expect_equal(lapply(x, class)[["caRich"]], lapply(indicators.ALL, class)[["caRich"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["MF"]], lapply(indicators.ALL, class)[["MF"]])
  expect_equal(lapply(y, class)[["DDS"]], lapply(indicators.ALL, class)[["DDS"]])
  expect_equal(lapply(y, class)[["caRich"]], lapply(indicators.ALL, class)[["caRich"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## HHS
x <- create_op_hunger(testSVY, sex = "m")
y <- create_op_hunger(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 192 variables", {
  expect_equal(ncol(x), 6)
  expect_equal(ncol(y), 6)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["HHS1"]], lapply(indicators.ALL, class)[["HHS1"]])
  expect_equal(lapply(x, class)[["HHS2"]], lapply(indicators.ALL, class)[["HHS2"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["HHS1"]], lapply(indicators.ALL, class)[["HHS1"]])
  expect_equal(lapply(y, class)[["HHS2"]], lapply(indicators.ALL, class)[["HHS2"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})

## ADL
x <- create_op_adl(testSVY, sex = "m")
y <- create_op_adl(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 15 variables", {
  expect_equal(ncol(x), 15)
  expect_equal(ncol(y), 15)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["ADL01"]], lapply(indicators.ALL, class)[["ADL01"]])
  expect_equal(lapply(x, class)[["ADL06"]], lapply(indicators.ALL, class)[["ADL06"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["ADL01"]], lapply(indicators.ALL, class)[["ADL01"]])
  expect_equal(lapply(y, class)[["ADL06"]], lapply(indicators.ALL, class)[["ADL06"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## Disability
x <- create_op_disability(testSVY, sex = "m")
y <- create_op_disability(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 32 variables", {
  expect_equal(ncol(x), 32)
  expect_equal(ncol(y), 32)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["wgP1"]], lapply(indicators.ALL, class)[["wgP1"]])
  expect_equal(lapply(x, class)[["wgP3"]], lapply(indicators.ALL, class)[["wgP3"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["wgP1"]], lapply(indicators.ALL, class)[["wgP1"]])
  expect_equal(lapply(y, class)[["wgP3"]], lapply(indicators.ALL, class)[["wgP3"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## Mental health
x <- create_op_mental(testSVY, sex = "m")
y <- create_op_mental(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 5 variables", {
  expect_equal(ncol(x), 5)
  expect_equal(ncol(y), 5)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["K6"]], lapply(indicators.ALL, class)[["K6"]])
  expect_equal(lapply(x, class)[["K6Case"]], lapply(indicators.ALL, class)[["K6Case"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["K6"]], lapply(indicators.ALL, class)[["K6"]])
  expect_equal(lapply(y, class)[["K6Case"]], lapply(indicators.ALL, class)[["K6Case"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## Dementia
x <- create_op_dementia(testSVY, sex = "m")
y <- create_op_dementia(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 4 variables", {
  expect_equal(ncol(x), 4)
  expect_equal(ncol(y), 4)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["sex2"]], lapply(indicators.ALL, class)[["sex2"]])
  expect_equal(lapply(x, class)[["DS"]], lapply(indicators.ALL, class)[["DS"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["sex2"]], lapply(indicators.ALL, class)[["sex2"]])
  expect_equal(lapply(y, class)[["DS"]], lapply(indicators.ALL, class)[["DS"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## Health
x <- create_op_health(testSVY, sex = "m")
y <- create_op_health(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 25 variables", {
  expect_equal(ncol(x), 25)
  expect_equal(ncol(y), 25)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["H1"]], lapply(indicators.ALL, class)[["H1"]])
  expect_equal(lapply(x, class)[["H69"]], lapply(indicators.ALL, class)[["H69"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["H1"]], lapply(indicators.ALL, class)[["H1"]])
  expect_equal(lapply(y, class)[["H69"]], lapply(indicators.ALL, class)[["H69"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## Income
x <- create_op_income(testSVY, sex = "m")
y <- create_op_income(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 13 variables", {
  expect_equal(ncol(x), 13)
  expect_equal(ncol(y), 13)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["M1"]], lapply(indicators.ALL, class)[["M1"]])
  expect_equal(lapply(x, class)[["M2I"]], lapply(indicators.ALL, class)[["M2I"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["M1"]], lapply(indicators.ALL, class)[["M1"]])
  expect_equal(lapply(y, class)[["M2I"]], lapply(indicators.ALL, class)[["M2I"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## WASH
x <- create_op_wash(testSVY, sex = "m")
y <- create_op_wash(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 7 variables", {
  expect_equal(ncol(x), 7)
  expect_equal(ncol(y), 7)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["W1"]], lapply(indicators.ALL, class)[["W1"]])
  expect_equal(lapply(x, class)[["W4"]], lapply(indicators.ALL, class)[["W4"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["W1"]], lapply(indicators.ALL, class)[["W1"]])
  expect_equal(lapply(y, class)[["W4"]], lapply(indicators.ALL, class)[["W4"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## Anthro
x <- create_op_anthro(testSVY, sex = "m")
y <- create_op_anthro(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 4 variables", {
  expect_equal(ncol(x), 4)
  expect_equal(ncol(y), 4)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["sex2"]], lapply(indicators.ALL, class)[["sex2"]])
  expect_equal(lapply(x, class)[["MUAC"]], lapply(indicators.ALL, class)[["MUAC"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["sex2"]], lapply(indicators.ALL, class)[["sex2"]])
  expect_equal(lapply(y, class)[["MUAC"]], lapply(indicators.ALL, class)[["MUAC"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## Oedema
x <- create_op_oedema(testSVY, sex = "m")
y <- create_op_oedema(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 4 variables", {
  expect_equal(ncol(x), 4)
  expect_equal(ncol(y), 4)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["sex2"]], lapply(indicators.ALL, class)[["sex2"]])
  expect_equal(lapply(x, class)[["oedema"]], lapply(indicators.ALL, class)[["oedema"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["sex2"]], lapply(indicators.ALL, class)[["sex2"]])
  expect_equal(lapply(y, class)[["oedema"]], lapply(indicators.ALL, class)[["oedema"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## Screening
x <- create_op_screening(testSVY, sex = "m")
y <- create_op_screening(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 4 variables", {
  expect_equal(ncol(x), 4)
  expect_equal(ncol(y), 4)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["sex2"]], lapply(indicators.ALL, class)[["sex2"]])
  expect_equal(lapply(x, class)[["screened"]], lapply(indicators.ALL, class)[["screened"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["sex2"]], lapply(indicators.ALL, class)[["sex2"]])
  expect_equal(lapply(y, class)[["screened"]], lapply(indicators.ALL, class)[["screened"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## Visual acuity
x <- create_op_visual(testSVY, sex = "m")
y <- create_op_visual(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 4 variables", {
  expect_equal(ncol(x), 4)
  expect_equal(ncol(y), 4)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["sex2"]], lapply(indicators.ALL, class)[["sex2"]])
  expect_equal(lapply(x, class)[["poorVA"]], lapply(indicators.ALL, class)[["poorVA"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["sex2"]], lapply(indicators.ALL, class)[["sex2"]])
  expect_equal(lapply(y, class)[["poorVA"]], lapply(indicators.ALL, class)[["poorVA"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})


## Miscellaneous
x <- create_op_misc(testSVY, sex = "m")
y <- create_op_misc(testSVY, sex = "f")

test_that("x and y are data.frame", {
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})

test_that("x and y have 6 variables", {
  expect_equal(ncol(x), 6)
  expect_equal(ncol(y), 6)
})

test_that("names(x) and names(y) is names(indicators.ALL)", {
  expect_true(all(names(x) %in% names(indicators.ALL)))
  expect_true(all(names(y) %in% names(indicators.ALL)))
})

test_that("class of x and y vectors are class indicators.ALL vectors", {
  expect_equal(lapply(x, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(x, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(x, class)[["chew"]], lapply(indicators.ALL, class)[["chew"]])
  expect_equal(lapply(x, class)[["food"]], lapply(indicators.ALL, class)[["food"]])
  expect_equal(lapply(y, class)[["psu"]], lapply(indicators.ALL, class)[["psu"]])
  expect_equal(lapply(y, class)[["sex1"]], lapply(indicators.ALL, class)[["sex1"]])
  expect_equal(lapply(y, class)[["chew"]], lapply(indicators.ALL, class)[["chew"]])
  expect_equal(lapply(y, class)[["food"]], lapply(indicators.ALL, class)[["food"]])
})

test_that("sex is correct", {
  expect_true(all(x$sex1 == 1))
  expect_true(all(x$sex2 == 0))
  expect_true(all(y$sex1 == 0))
  expect_true(all(y$sex2 == 1))
})

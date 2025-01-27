
report_op_table(
  estimate_op(x = indicators.ALL, w = testPSU, replicates = 19),
  filename = paste(tempdir(), "TEST", sep = "/")
)

test_that("output file exists", {
  expect_true(file.exists(paste(tempdir(), "TEST.report.csv", sep = "/")))
})


test_that("output file exists", {
  skip_on_cran()
  report_op_html(
    estimates = estimate_op(
      x = indicators.ALL, w = testPSU, replicates = 19), 
      svy = testSVY, filename = paste(tempdir(), "htmlReport", sep = "/"
    )
  )
  expect_true(file.exists(paste(tempdir(), "htmlReport.html", sep = "/")))
  expect_true(file.exists(paste(tempdir(), "htmlReport.Rmd", sep = "/")))
})


test_that("output file exists", {
  skip_on_cran()
  report_op_docx(
    estimates = estimate_op(x = indicators.ALL, w = testPSU, replicates = 19),
    svy = testSVY, filename = paste(tempdir(), "wordReport", sep = "/")
  )
  expect_true(file.exists(paste(tempdir(), "wordReport.docx", sep = "/")))
  expect_true(file.exists(paste(tempdir(), "wordReport.Rmd", sep = "/")))
})


test_that("output file exists", {
  skip_on_cran()
  report_op_odt(
    estimates = estimate_op(
      x = indicators.ALL, w = testPSU, replicates = 19),
      svy = testSVY, filename = paste(tempdir(), "odtReport", sep = "/"
    )
  )
  expect_true(file.exists(paste(tempdir(), "odtReport.odt", sep = "/")))
  expect_true(file.exists(paste(tempdir(), "odtReport.Rmd", sep = "/")))
})


test_that("output file exists", {
  skip_on_cran()
  report_op_pdf(
    estimates = estimate_op(
      x = indicators.ALL, w = testPSU, replicates = 19),
      svy = testSVY, filename = paste(tempdir(), "pdfReport", sep = "/"
    )
  )
  expect_true(file.exists(paste(tempdir(), "pdfReport.pdf", sep = "/")))
  expect_true(file.exists(paste(tempdir(), "pdfReport.Rmd", sep = "/")))
})
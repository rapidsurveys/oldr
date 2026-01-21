# Package index

## Create indicators

- [`create_op()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_demo()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_food()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_hunger()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_adl()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_disability()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_mental()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_dementia()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_health()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_income()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_wash()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_anthro()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_oedema()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_screening()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_visual()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  [`create_op_misc()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  : Create older people indicators dataset from survey data collected
  using the standard RAM-OP questionnaire.

## Estimate indicators

- [`estimate_classic()`](https://rapidsurveys.io/oldr/dev/reference/estimate_classic.md)
  : Apply bootstrap to RAM-OP indicators using a classical estimator.
- [`estimate_op()`](https://rapidsurveys.io/oldr/dev/reference/estimate_op.md)
  : Estimate all standard RAM-OP indicators
- [`estimate_probit()`](https://rapidsurveys.io/oldr/dev/reference/estimate_probit.md)
  : Apply bootstrap to RAM-OP indicators using a PROBIT estimator.

## Create charts

- [`chart_op_age()`](https://rapidsurveys.io/oldr/dev/reference/chart_op.md)
  [`chart_op_muac()`](https://rapidsurveys.io/oldr/dev/reference/chart_op.md)
  [`chart_op_mf()`](https://rapidsurveys.io/oldr/dev/reference/chart_op.md)
  [`chart_op_dds()`](https://rapidsurveys.io/oldr/dev/reference/chart_op.md)
  [`chart_op_k6()`](https://rapidsurveys.io/oldr/dev/reference/chart_op.md)
  [`chart_op_adl()`](https://rapidsurveys.io/oldr/dev/reference/chart_op.md)
  [`chart_op_wash()`](https://rapidsurveys.io/oldr/dev/reference/chart_op.md)
  [`chart_op_csid()`](https://rapidsurveys.io/oldr/dev/reference/chart_op.md)
  [`chart_op_wg()`](https://rapidsurveys.io/oldr/dev/reference/chart_op.md)
  [`chart_op_hhs()`](https://rapidsurveys.io/oldr/dev/reference/chart_op.md)
  [`chart_op_income()`](https://rapidsurveys.io/oldr/dev/reference/chart_op.md)
  : Plot RAM-OP indicators
- [`pyramid_plot()`](https://rapidsurveys.io/oldr/dev/reference/pyramid_plot.md)
  : Function to create a pyramid plot

## Create report

- [`report_op_html()`](https://rapidsurveys.io/oldr/dev/reference/report_op_html.md)
  : Create an HTML report document containing RAM-OP survey results
- [`report_op_docx()`](https://rapidsurveys.io/oldr/dev/reference/report_op_docx.md)
  : Create a DOCX report document containing RAM-OP survey results
- [`report_op_odt()`](https://rapidsurveys.io/oldr/dev/reference/report_op_odt.md)
  : Create a ODT report document containing RAM-OP survey results
- [`report_op_pdf()`](https://rapidsurveys.io/oldr/dev/reference/report_op_pdf.md)
  : Create a PDF report document containing RAM-OP survey results
- [`report_op_table()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_demo()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_food()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_hunger()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_disability()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_adl()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_mental()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_dementia()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_health()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_oedema()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_anthro()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_screen()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_visual()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_income()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_wash()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  [`report_op_misc()`](https://rapidsurveys.io/oldr/dev/reference/report_op.md)
  : Create table and report chunk of RAM-OP results

## Utility/support functions

- [`probit_gam()`](https://rapidsurveys.io/oldr/dev/reference/op_probit.md)
  [`probit_sam()`](https://rapidsurveys.io/oldr/dev/reference/op_probit.md)
  : PROBIT statistics function for bootstrap estimation of older people
  GAM
- [`merge_op()`](https://rapidsurveys.io/oldr/dev/reference/merge_op.md)
  : Concatenate classic and PROBIT estimates into a single data.frame

## Datasets

- [`testSVY`](https://rapidsurveys.io/oldr/dev/reference/testSVY.md) :
  RAM-OP Survey Dataset
- [`testPSU`](https://rapidsurveys.io/oldr/dev/reference/testPSU.md) :
  RAM-OP Population Dataset
- [`indicators.ALL`](https://rapidsurveys.io/oldr/dev/reference/indicators.ALL.md)
  : RAM-OP Indicators Dataset - ALL
- [`indicators.MALES`](https://rapidsurveys.io/oldr/dev/reference/indicators.MALES.md)
  : RAM-OP Indicators Dataset - MALES
- [`indicators.FEMALES`](https://rapidsurveys.io/oldr/dev/reference/indicators.FEMALES.md)
  : RAM-OP Indicators Dataset - FEMALES

################################################################################
#
#
# This is a Shiny web application to support the implementation Rapid Assessment
# Method for Older People (RAM-OP) surveys.
#
# This is the code for the user interface (UI) of the Shiny web application.
#
#
################################################################################


################################################################################
#
# UI for web application
#
################################################################################
#
# Define UI for application
#
ui <- dashboardPage(
  skin = "red",
  #
  # Header
  #
  dashboardHeader(
    title = "RAM-OP",
    titleWidth = 300),
  #
  # Sidebar
  #
  dashboardSidebar(
    width = 300,
    sidebarSearchForm(
      textId = "searchText",
      buttonId = "searchButton"
    ),
    #
    # Sidebar menu
    #
    sidebarMenu(
      id = "tabs",
      menuItem(text = "Design",
               tabName = "design",
               icon = icon(name = "pencil",
                           lib = "font-awesome",
                           class = "fa-lg")),
      menuItem(text = "Collect",
               tabName = "collect",
               icon = icon(name = "tablet",
                           lib = "font-awesome",
                           class = "fa-lg")),
      menuItem(text = "Process",
               tabName = "process",
               icon = icon(name = "database",
                           lib = "font-awesome",
                           class = "fa-lg")),
      menuItem(text = "Analyse",
               tabName = "analyse",
               icon = icon(name = "line-chart",
                           lib = "font-awesome",
                           class = "fa-lg")),
      menuItem(text = "Report",
               tabName = "report",
               icon = icon(name = "file-text",
                           lib = "font-awesome",
                           class = "fa-lg"))
    )
  ),
  #
  # Body
  #
  dashboardBody(
    #
    # Specify a custom.css
    #
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    #
    # Adjust width of modal
    #
    tags$head(
      tags$style(".modal-dialog{ width:1000px}")
    ),
    #
    # Body outputs for every menu item on sidebar
    #
    tabItems(
      #
      # Body output when 'design' menu is selected
      #
      tabItem(tabName = "design",
        fluidRow(
          conditionalPanel(condition = "input.design == 'stage1a'",
            box(title = "Stage 1 map-based sampling parameters",
              solidHeader = TRUE,
              status = "danger",
              width = 4,

              selectInput(inputId = "mapSamplingLevel0",
                          label = "Select country",
                          choices = c("Select country" = "", countries),
                          selected = NULL),
              conditionalPanel(condition = "input.mapSamplingLevel0 != ''",
                div(style="display: inline-block;vertical-align:middle;",
                  selectInput(inputId = "mapSamplingLevel1",
                              label = "Select region/province",
                              width = "250px",
                              choices = c("Select region/province" = "")
                  )
                ),
                div(style="display: inline-block;vertical-align:middle;",
                  actionLink(inputId = "regionSelectInfo",
                             label = "",
                             icon = icon(name = "info-circle",
                                         lib = "font-awesome")
                  )
                )
              ),
              conditionalPanel(condition = "input.mapSamplingLevel1 != ''",
                div(style="display: inline-block;vertical-align:middle;",
                  selectInput(inputId = "mapSamplingLevel2",
                              label = "Select district/locality",
                              width = "250px",
                              choices = c("Select district/locality" = "")
                  )
                ),
                div(style="display: inline-block;vertical-align:middle;",
                  actionLink(inputId = "districtSelectInfo",
                             label = "",
                             icon = icon(name = "info-circle",
                                         lib = "font-awesome")
                  )
                )
              ),
              conditionalPanel(condition = "input.mapSamplingLevel0 != ''",
                fileInput(inputId = "settlementsData1",
                          label = "Upload settlements/village locations dataset",
                          accept = c("text/csv",
                                     "text/comma-separated-values,text/plain",
                                     ".csv")
                )
              ),
              conditionalPanel(condition = "output.fileUploaded1",
                selectInput(inputId = "longitude",
                            label = "Select longitude variable",
                            selected = "",
                            choices = c("Select longitude variable" = "")
                ),
                selectInput(inputId = "latitude",
                            label = "Select latitude variable",
                            selected = "",
                            choices = c("Select latitude variable" = "")
                ),
                checkboxInput(inputId = "advanceSamplingOptions",
                              label = "Advance sampling options",
                              value = FALSE),
                conditionalPanel(condition = "input.advanceSamplingOptions",
                  hr(),
                  radioButtons(inputId = "gridType",
                               label = "Type of sampling grid",
                               selected = "csas",
                               inline = TRUE,
                               choices = c("CSAS" = "csas", "S3M" = "s3m")
                  ),
                  sliderInput(inputId = "gridNumber",
                              label = "Number of clusters/sampling points",
                              min = 16,
                              max = 30,
                              value = 16,
                              step = 1
                  ),
                  sliderInput(inputId = "bufferMap",
                              label = "Buffer (kms)",
                              min = 0,
                              max = 20,
                              value = 5,
                              step = 1
                  ),
                  hr()
                ),
                actionButton(inputId = "mapSamplingPlot",
                             label = "Sample",
                             icon = icon(name = "th",
                                         lib = "font-awesome")
                ),
                downloadButton(outputId = "samplingListDownload1",
                               label = "Download",
                               icon = icon(name = "download",
                                           lib = "font-awesome")
                )
              )
            )
          ),
          conditionalPanel(condition = "input.design == 'stage1b'",
            box(title = "Stage 1 list-based sampling parameters",
              solidHeader = TRUE,
              status = "danger",
              width = 4,
              shinyjs::useShinyjs(),
              fileInput(inputId = "settlementsData2",
                        label = "Upload settlements/village dataset",
                        accept = c("text/csv",
                                   "text/comma-separated-values,text/plain",
                                   ".csv")
              ),
              selectInput(inputId = "sortVariable",
                          label = "Sort village data by",
                          choices = c("Select variable to sort list" = ""),
                          selected = ""),
              br(),
              conditionalPanel(condition = "input.sortVariable",
                actionButton(inputId = "mapSamplingList",
                             label = "Sample",
                             icon = icon(name = "th",
                                         lib = "font-awesome")
                ),
                downloadButton(outputId = "samplingListDownload2",
                               label = "Download",
                               icon = icon(name = "download",
                                           lib = "font-awesome")
                )
              )
            )
          ),
          conditionalPanel(condition = "input.design == 'stage2'",
            box(title = "Stage 2 sampling",
              solidHeader = TRUE,
              status = "danger",
              width = 4,
              uiOutput("stage2SamplingSummary")
            )
          ),
          tabBox(selected = "stage1a",
            id = "design",
            title = "Design",
            width = 8,
            side = "right",
            tabPanel(title = "Stage 2", value = "stage2",
              uiOutput("stage2SamplingDescription")
            ),
            tabPanel(title = "Stage 1 list-based", value = "stage1b",
              DT::dataTableOutput("settlementsTable2"),
              fluidRow(
                conditionalPanel(condition = "input.mapSamplingList > 0",
                  hr(),
                  box(title = "Stage 1 sample list",
                    solidHeader = TRUE,
                    status = "danger",
                    width = 12,
                    DT::dataTableOutput("mapSamplingTable2")
                  )
                )
              )
            ),
            tabPanel(title = "Stage 1 Map-based", value = "stage1a",
              leafletOutput("mapSampling", height = 500),
              fluidRow(
                conditionalPanel(condition = "input.mapSamplingPlotCountry > 0 | input.mapSamplingPlotCounty > 0 | input.mapSamplingPlotDistrict > 0",
                  box(title = "Stage 1 sample list",
                      solidHeader = TRUE,
                      status = "danger",
                      width = 12,
                      DT::dataTableOutput("mapSamplingTable1")
                  )
                )
              )
            )
          )
        )
      ),
      #
      # Body output when 'collect' menu is selected
      #
      tabItem(tabName = "collect",
        fluidRow(
          tabBox(selected = "questionnaire",
            title = "Collect",
            width = 12,
            side = "right",
            tabPanel(title = "Open Data Kit",
              value = "odk",
              h4("Digital data collection using Open Data Kit"),
              uiOutput("collectOdk")
            ),
            tabPanel(title = "EpiData",
              value = "epidata",
              h4("EpiData"),
              uiOutput("collectEpiData")
            ),
            tabPanel(title = "Questionnaire",
              value = "questionnaire",
              h4("The RAM-OP Questionnaire"),
              uiOutput("questionnaireOP")
            )
          )
        )
      ),
      #
      # Body output when 'process' menu is selected
      #
      tabItem(tabName = "process",
        fluidRow(
          conditionalPanel(condition = "input.process == 'processData'",
            box(title = "Indicators",
              solidHeader = TRUE,
              status = "danger",
              width = 4,
              uiOutput("indicatorsDescription"),
              hr(),
              checkboxGroupInput(inputId = "inputIndicators",
                                 label = "Select indicators to process",
                                 choices = c("Demography and situation" = "demo",
                                             "Food intake" = "food",
                                             "Severe food insecurity" = "hunger",
                                             "Disability" = "disability",
                                             "Activities of daily living" = "adl",
                                             "Mental health and well-being" = "mental",
                                             "Dementia" = "dementia",
                                             "Health and health-seeking behaviour" = "health",
                                             "Sources of income" = "income",
                                             "Water, sanitation, and hygiene" = "wash",
                                             "Anthropometry" = "anthro",
                                             "Oedema prevalence" = "oedema",
                                             "Screening coverage" = "screening",
                                             "Visual impairment" = "visual",
                                             "Miscellaneous" = "misc"),
                                 selected = c("demo", "food", "hunger",
                                              "disability", "adl", "mental",
                                              "dementia", "health", "income",
                                              "wash", "anthro", "oedema", "screening",
                                              "visual", "misc")
              ),
              hr(),
              actionButton(inputId = "inputProcessAction",
                           label = "Process",
                           icon = icon(name = "database",
                                       lib = "font-awesome")
              ),
              downloadButton(outputId = "downloadIndicatorData",
                             label = "Download",
                             icon = icon(name = "download",
                                         lib = "font-awesome")
              )
            )
          ),
          conditionalPanel(condition = "input.process == 'surveyData'",
            box(title = "Input Coverage Data",
              solidHeader = TRUE,
              status = "danger",
              width = 4,
              uiOutput("surveyDataDescription"),
              hr(),
              fileInput(inputId = "inputDataSurvey",
                        label = "Upload survey dataset",
                        buttonLabel = "Upload",
                        accept = c("text/csv",
                                   "text/comma-separated-values,text/plain",
                                   ".csv"))
            )
          ),
          conditionalPanel(condition = "input.process == 'psuData'",
            box(title = "PSU Dataset",
              solidHeader = TRUE,
              status = "danger",
              width = 4,
              uiOutput("psuDataDescription"),
              hr(),
              fileInput(inputId = "inputDataPSU",
                        buttonLabel = "Upload",
                        label = "Upload PSU dataset",
                        accept = c("text/csv",
                                   "text/comma-separated-values,text/plain",
                                   ".csv"))
            )
          ),
          tabBox(title = "Process",
            id = "process",
            selected = "psuData",
            side = "right",
            width = 8,
            tabPanel(title = "Process Indicators", value = "processData",
              DT::dataTableOutput("indicatorsDataTable")
            ),
            tabPanel(title = "Survey Dataset", value = "surveyData",
              #uiOutput("surveyDataDescription"),
              #br(),
              #hr(),
              #br(),
              DT::dataTableOutput("surveyDataTable")
            ),
            tabPanel(title = "PSU Dataset", value = "psuData",
              #uiOutput("psuDataDescription"),
              #br(),
              #hr(),
              #br(),
              DT::dataTableOutput("psuDataTable")
            )
          )
        )
      ),
      #
      # Body output when 'analyse' menu is selected
      #
      tabItem(tabName = "analyse",
        fluidRow(
          box(title = "Analysis Parameters", solidHeader = TRUE,
            status = "danger", width = 4,
            checkboxGroupInput(inputId = "analyseIndicators",
                               label = "Select indicators to analyse",
                               choices = c("Demography and situation" = "demo",
                                           "Food intake" = "food",
                                           "Severe food insecurity" = "hunger",
                                           "Disability" = "disability",
                                           "Activities of daily living" = "adl",
                                           "Mental health and well-being" = "mental",
                                           "Dementia" = "dementia",
                                           "Health and health-seeking behaviour" = "health",
                                           "Sources of income" = "income",
                                           "Water, sanitation, and hygiene" = "wash",
                                           "Anthropometry" = "anthro",
                                           "Oedema prevalence" = "oedema",
                                           "Screening coverage" = "screening",
                                           "Visual impairment" = "visual",
                                           "Miscellaneous" = "misc"),
                               selected = c("demo", "food", "hunger",
                                            "disability", "adl", "mental",
                                            "dementia", "health", "income",
                                            "wash", "anthro", "oedema",
                                            "screening", "visual", "misc")
            ),
            br(),
            numericInput(inputId = "replicates",
                         label = "No. of bootstrap replicates",
                         value = 399,
                         min = 399,
                         step = 100),
            br(),
            actionButton(inputId = "analysisAction",
                         label = "Analyse",
                         icon = icon(name = "line-chart",
                                     lib = "font-awesome")
            ),
            downloadButton(outputId = "analysisDownload",
                           label = "Download",
                           icon = icon(name = "download",
                                       lib = "font-awesome")
            )
          ),
          tabBox(title = "",
            id = "analyse",
            selected = "survey",
            width = 8,
            side = "right",
            tabPanel(title = "Misc",
              value = "misc",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Problems chewing food (self-report)",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "chewPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewChewTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorChew",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Anyone in household receiving food ration",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "foodPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewFoodTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorFood",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Received non-food relief items in the past month",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "nfriPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewNFRITable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorNFRI",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "Visual",
              value = "visual",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Poorn visual acuity",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "visualPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewVisualTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorVisual",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "Screening",
              value = "screening",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Anthropometric screening coverage",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "screenPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewScreenTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorScreen",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "Oedema",
              value = "oedema",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Nutritional oedema prevalence",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "oedemaPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewOedemaTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorOedema",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "Anthropometry",
              value = "anthro",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Mean mid-upper arm circumference (mm)",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "meanMUACPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewMeanMUACTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorMeanMUAC",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Mid-upper arm circumference (MUAC) distribution",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "histMUACPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupHistMUAC",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex")
                      )
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Acute undernutrition prevalence",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "muacPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewMUACTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupMUAC",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorMUAC",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "WASH",
              value = "wash",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Water, sanitation and hygiene services access",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "washPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewWASHTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupWASH",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorWASH",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "Income",
              value = "income",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Has personal income",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "incomePlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewIncomeTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorIncome",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Sources of income",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "incomeSourcePlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewIncomeSourceTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupIncomeSource",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorIncomeSource",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "Health",
              value = "health",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Health-seeking behaviour for a long-term illness",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "healthPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewHealthTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupHealth",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorHealth",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Reasons for not taking medication for long-term illness requiring regular medication",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "reasonsPlot1"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewReasonsTable1",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupReasons1",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorReasons1",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Health-seeking behaviour for a recent illness",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "recentPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewRecentTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupRecent",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorRecent",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Reasons for not accessing care for recent illness",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "reasonsPlot2"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewReasonsTable2",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupReasons2",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorReasons2",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "Dementia",
              value = "dementia",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Probable dementia by brief CSID screen",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "dsPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewDSTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorDS",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "Mental",
              value = "mental",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Kessler-6 psychological distress score",
                    status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "kesslerPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewKesslerTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorKessler",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Kessler-6 psychological distress score distribution",
                    status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "kesslerHist"),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupKessler",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex")
                      )
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Kessler-6 psychological distress score boxplot",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "kesslerBoxplot")
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Severe psychological distress",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "severeDistressPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewDistressTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorDistress",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "ADL",
              value = "adl",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Activities of daily living", status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "adlPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewADLTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupADL",
                                  label = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorADL",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Katz ADL score", status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput("adlScorePlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewADLScoreTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorADLscore",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Activities of daily living classification",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput("adlClassPlot"),
                    actionButton(inputId = "viewADLClassTable",
                                 label = "View Data Table",
                                 icon = icon(name = "eye",
                                             lib = "font-awesome")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Katz ADL score histogram", status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "adlHistPlot"),
                    div(style="display: inline-block;vertical-align:middle",
                      selectInput(inputId = "groupADLhist",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex")
                      )
                    )
                  )
                )
              )
            ),
            tabPanel(title = "Disability",
                     value = "disability",
                     h4("Disability")),
            tabPanel(title = "Hunger",
              value = "hunger",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Household hunger scale", status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "hhsPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewHHSTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupHHS",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorHHS",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "Diet",
              value = "food",
              br(),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Meal Frequency", status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "mealPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewMealTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorMeal",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Consumption per food group", status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "fgPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewFGTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupFG",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorFG",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Mean Dietary Diversity Score", status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "ddsPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewDDSTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorDDS",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Dietary Diversity Score Distriubtion - Histogram",
                    status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "ddsHistPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupDDS",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex")
                      )
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Dietary Diversity Score Distribution - Boxplot",
                    status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "ddsBoxPlot")
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Consumption of protein-rich foods",
                    status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "proteinPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewProteinTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                                lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupProtein",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorProtein",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Consumption of vitamin A-rich foods",
                    status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "vitAPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewVitATable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupVitA",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorVitA",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Consumption of vitamin B-rich foods",
                    status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "vitBPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewVitBTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupVitB",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorVitB",
                                    label = "Confidence interval",
                                    value = FALSE,
                                    width = "200px")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Consumption of foods rich in other vitamins and minerals",
                    status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "otherVitPlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewOtherVitTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      selectInput(inputId = "groupOtherVit",
                                  label = "",
                                  selected = "",
                                  width = "200px",
                                  choices = c("Stratify by" = "",
                                              "No stratification" = "no",
                                              "Sex" = "sex",
                                              "Indicator" = "indicator")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                      checkboxInput(inputId = "errorOtherVit",
                                  label = "Confidence interval",
                                  value = FALSE,
                                  width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "Demography",
              value = "demo",
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Age Structure by Sex", status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "agePlot"),
                    actionButton(inputId = "viewAgeTable",
                    label = "View Data Table",
                    icon = icon(name = "eye",
                                lib = "font-awesome")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Marital Status", status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "maritalPlot"),
                    actionButton(inputId = "viewMaritalTable",
                                 label = "View Data Table",
                                 icon = icon(name = "eye",
                                             lib = "font-awesome")
                    )
                  )
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Respondents living alone", status = "danger",
                    solidHeader = TRUE, width = 12,
                    plotOutput(outputId = "alonePlot"),
                    div(style="display: inline-block;vertical-align:middle;",
                      actionButton(inputId = "viewAloneTable",
                                   label = "View Data Table",
                                   icon = icon(name = "eye",
                                               lib = "font-awesome")
                      )
                    ),
                    div(style="display: inline-block;vertical-align:middle;",
                        checkboxInput(inputId = "errorAlone",
                                      label = "Confidence interval",
                                      value = FALSE,
                                      width = "200px")
                    )
                  )
                )
              )
            ),
            tabPanel(title = "Respondents", value = "survey",
              fluidRow(
                conditionalPanel(condition = "input.analysisAction > 0",
                  box(title = "Survey Respondents",
                    status = "danger",
                    solidHeader = TRUE,
                    width = 12,
                    plotOutput(outputId = "surveyPlot"),
                    actionButton(inputId = "viewSurveyTable",
                                 label = "View Data Table",
                                 icon = icon(name = "eye",
                                             lib = "font-awesome")
                    )
                  )
                )
              )
            )
          )
        )
      ),
      #
      # Body output when 'report' menu is selected
      #
      tabItem(tabName = "report",
        fluidRow(
          box(title = "Report type",
            solidHeader = TRUE,
            status = "info",
            width = 4,
            height = "135px",
            checkboxGroupInput(inputId = "reportType",
                               label = "Select report type to generate",
                               inline = TRUE,
                               choices = c("HTML" = "html",
                                           "PDF" = "pdf"),
                               selected = c("html", "pdf")
            )
          ),
          box(title = "Report directory",
            solidHeader = TRUE,
            status = "warning",
            width = 4,
            height = "135px",
            textInput(inputId = "reportDir",
              label = "Enter directory to save report",
              value = "")
          ),
          box(title = "Report",
            solidHeader = TRUE,
            status = "success",
            width = 4,
            height = "135px",
            p("Click on button to generate RAM-OP report"),
            actionButton(inputId = "reportGenerate",
                         label = "Generate report",
                         icon = icon(name = "file-text",
                                     lib = "font-awesome")
            )
          )
        )
      )
    )
  )
)

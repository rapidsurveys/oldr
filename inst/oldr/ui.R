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
              shinyjs::useShinyjs(),
              selectInput(inputId = "mapSamplingLevel0",
                          label = "Select country",
                          choices = c("Select country" = "", countries),
                          selected = NULL),
              conditionalPanel(condition = "input.mapSamplingLevel0 != ''",
                selectInput(inputId = "mapSamplingLevel1",
                            label = "Select region/province",
                            choices = c("Select region/province" = ""))
              ),
              conditionalPanel(condition = "input.mapSamplingLevel1 != ''",
                               selectInput(inputId = "mapSamplingLevel2",
                                           label = "Select district/locality",
                                           choices = c("Select district/locality" = ""))
              ),
              conditionalPanel(condition = "input.mapSamplingLevel0 != ''",
                fileInput(inputId = "settlementsData1",
                          label = "Upload settlements/village locations dataset",
                          accept = c("text/csv",
                                     "text/comma-separated-values,text/plain",
                                     ".csv"))
              ),
              conditionalPanel(condition = "input.mapSamplingLevel0 != ''",
                hr(),
                h5("Spatial sample settings"),
                selectInput(inputId = "mapSamplingSpec",
                            label = "Specify spatial grid parameter to use",
                            choices = c("Grid area" = "area",
                                        "Number of grids" = "n",
                                        "Max distance to sampling point" = "d"),
                            selected = "area"),
                conditionalPanel(condition = "input.mapSamplingSpec == 'area'",
                  numericInput(inputId = "mapSamplingGridArea",
                               label = "Set grid area size (in sq kms)",
                               value = 100, min = 5, max = 500, step = 5)
                ),
                conditionalPanel(condition = "input.mapSamplingSpec == 'n'",
                  numericInput(inputId = "mapSamplingGridNumber",
                               label = "Set grid number",
                               value = 20, min = 16, max = 30, step = 1)
                ),
                conditionalPanel(condition = "input.mapSamplingSpec == 'd'",
                  numericInput(inputId = "mapSamplingGridDist",
                               label = "Set max distance to sampling point (in kms)",
                               value = 10, min = 5, max = 30, step = 1)
                ),
                numericInput(inputId = "mapSamplingSettlementsNumber",
                             label = "No. of settlements per sampling point",
                             value = 1, min = 1, max = 10, step = 1),
                br(),
                conditionalPanel(condition = "input.mapSamplingLevel0 != '' & input.settlementsData1 != null",
                  actionButton(inputId = "mapSamplingPlot",
                               label = "Sample",
                               icon = icon(name = "th",
                               lib = "font-awesome",
                               class = "fa-lg")
                  ),
                  downloadButton(outputId = "samplingListDownload1",
                                 label = "Download",
                                 icon = icon(name = "download",
                                 lib = "font-awesome",
                                 class = "fa-lg")
                  )
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
            box(title = "Stage 2 sampling parameters",
                solidHeader = TRUE,
                status = "danger",
                width = 4,
                shinyjs::useShinyjs()
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
          box(title = "Analyse",
            solidHeader = FALSE,
            status = "danger",
            width = 8,
            DT::dataTableOutput("resultsTable")
          )
        )
      ),
      #
      # Body output when 'report' menu is selected
      #
      tabItem(tabName = "report",
        fluidRow(
          tabBox(title = "",
            id = "report",
            selected = "survey",
            side = "right",
            width = 12,
            tabPanel(title = "Misc",
              value = "misc",
              h4("Miscellaneous Indicators")),
            tabPanel(title = "Visual",
              value = "visual",
              h4("Visual Impairment")),
            tabPanel(title = "Screening",
              value = "screening",
              h4("Screening Coverage")),
            tabPanel(title = "Oedema",
              value = "oedema",
              h4("Oedema Prevalence")),
            tabPanel(title = "Anthropometry",
              value = "anthro",
              h4("Anthropometry")),
            tabPanel(title = "WASH",
              value = "wash",
              h4("Water, Sanitation and Hygiene")),
            tabPanel(title = "Income",
              value = "income",
              h4("Sources of Income")),
            tabPanel(title = "Health",
              value = "health",
              h4("Health and Health-Seeking Behaviour")),
            tabPanel(title = "Dementia",
              value = "dementia",
              h4("Dementia")),
            tabPanel(title = "Mental",
              value = "mental",
              h4("Mental Health")),
            tabPanel(title = "ADL",
              value = "adl",
              h4("Activities of Daily Living")),
            tabPanel(title = "Disability",
              value = "disability",
              h4("Disability")),
            tabPanel(title = "Hunger",
              value = "hunger",
              h4("Severe Food Insecurity")),
            tabPanel(title = "Diet",
              value = "food",
              br(),
              fluidRow(
                box(title = "Meal Frequency", status = "danger",
                  solidHeader = TRUE, width = 6,
                  plotOutput(outputId = "mealPlot"),
                  actionButton(inputId = "viewMealTable",
                               label = "View Data Table",
                               icon = icon(name = "eye",
                                           lib = "font-awesome")
                  )
                )
              ),
              fluidRow(
                box(title = "Consumption per food group", status = "danger",
                  solidHeader = TRUE, width = 12,
                  plotOutput(outputId = "fgPlot"),
                  actionButton(inputId = "viewFGTable",
                               label = "View Data Table",
                               icon = icon(name = "eye",
                                           lib = "font-awesome")
                  )
                )
              )
            ),
            tabPanel(title = "Demography",
              value = "demo",
              br(),
              fluidRow(
                box(title = "Age Structure by Sex", status = "danger",
                  solidHeader = TRUE, width = 6,
                  plotOutput(outputId = "agePlot"),
                  actionButton(inputId = "viewAgeTable",
                               label = "View Data Table",
                               icon = icon(name = "eye",
                                           lib = "font-awesome")
                  )
                ),
                box(title = "Marital Status", status = "danger",
                  solidHeader = TRUE, width = 6,
                  plotOutput(outputId = "maritalPlot"),
                  actionButton(inputId = "viewMaritalTable",
                               label = "View Data Table",
                               icon = icon(name = "eye",
                                           lib = "font-awesome")
                  )
                )
              ),
              fluidRow(
                box(title = "Respondents living alone", status = "danger",
                  solidHeader = TRUE, width = 6,
                  plotOutput(outputId = "alonePlot"),
                  actionButton(inputId = "viewAloneTable",
                               label = "View Data Table",
                               icon = icon(name = "eye",
                                           lib = "font-awesome")
                  )
                )
              )
            ),
            tabPanel(title = "Respondents",
              value = "survey",
              br(),
              fluidRow(
                box(title = "Survey Respondents", status = "danger",
                  solidHeader = TRUE,
                  width = 6,
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
    )
  )
)

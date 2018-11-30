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
    # Body outputs for every menu item on sidebar
    #
    tabItems(
      #
      # Body output when 'design' menu is selected
      #
      tabItem(tabName = "design",
        fluidRow(
          conditionalPanel(condition = "input.design == 'stage1a'",
            box(title = "Stage 1 sampling parameters",
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
                               label = "",
                               icon = icon(name = "th",
                               lib = "font-awesome",
                               class = "fa-lg")
                  ),
                  actionButton(inputId = "mapSamplingPlotReset",
                               label = "",
                               icon = icon(name = "refresh",
                               lib = "font-awesome",
                               class = "fa-lg")
                  ),
                  downloadButton(outputId = "samplingListDownload",
                                 label = "",
                                 icon = icon(name = "download",
                                 lib = "font-awesome",
                                 class = "fa-lg")
                  )
                )
              )
            )
          ),
          conditionalPanel(condition = "input.design == 'stage1b'",
            box(title = "Stage 2 sampling parameters",
              solidHeader = TRUE,
              status = "danger",
              width = 4,
              shinyjs::useShinyjs(),
              fileInput(inputId = "settlementsData2",
                        label = "Upload settlements/village dataset",
                        accept = c("text/csv",
                                   "text/comma-separated-values,text/plain",
                                   ".csv")
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
              fluidRow(
                box(title = "Stage 2 Sampling",
                    solidHeader = FALSE,
                    status = "danger",
                    width = 12
                )
              )
            ),
            tabPanel(title = "Stage 1 list-based", value = "stage1b",
              fluidRow(
                box(title = "Stage 1 list-based sampling",
                    solidHeader = FALSE,
                    status = "danger",
                    width = 12)
              )
            ),
            tabPanel(title = "Stage 1 Map-based", value = "stage1a",
              fluidRow(
                box(title = "Stage 1 map-based sampling",
                    solidHeader = FALSE,
                    status = "danger",
                    width = 12,
                  leafletOutput("mapSampling", height = 500)
                )
              ),
              fluidRow(
                conditionalPanel(condition = "input.mapSamplingPlotCountry > 0 | input.mapSamplingPlotCounty > 0 | input.mapSamplingPlotDistrict > 0",
                  box(title = "Stage 1 sample list",
                      solidHeader = TRUE,
                      status = "danger",
                      width = 12,
                      DT::dataTableOutput("mapSamplingTable")
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
        tabBox(selected = "papi",
               title = "Collect",
               width = 12,
               side = "right",
          tabPanel(title = "Open Data Kit",
                   value = "odk",
            h4("Digital data collection using Open Data Kit"),
            uiOutput("collectOdk")
          ),
          tabPanel(title = "Pen and paper",
                   value = "papi",
            h4("Pen and Paper Interviews"),
            uiOutput("collectPapi")
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
              checkboxGroupInput(inputId = "inputIndicators",
                                 label = "Which indicators are to process?",
                                 choices = c("IMAM coverage",
                                             "Vitamin A supplementation coverage",
                                             "FeFol supplementation coverage",
                                             "Micronutrient powder supplementation coverage",
                                             "Infant and young child feeding counselling coverage"),
                                 selected = c("IMAM coverage",
                                              "Vitamin A supplementation coverage",
                                              "FeFol supplementation coverage",
                                              "Micronutrient powder supplementation coverage",
                                              "Infant and young child feeding counselling coverage")
              ),
              br(),
              actionButton(inputId = "inputProcessAction",
                           label = "Process",
                           icon = icon(name = "database",
                                       lib = "font-awesome",
                                       class = "fa-lg"))
            )
          ),
          conditionalPanel(condition = "input.process == 'checkData'",
            box(title = "Check data parameters",
                solidHeader = TRUE,
                status = "danger",
                width = 4)
          ),
          conditionalPanel(condition = "input.process == 'coverageData'",
            box(title = "Input Coverage Data",
                solidHeader = TRUE,
                status = "danger",
                width = 4,
              radioButtons(inputId = "inputDataType2",
                           label = "How will coverage data be inputted?",
                           choices = c("Upload data file" = "upload",
                                       "Get data from ODK server" = "odk")
              ),
              br(),
              conditionalPanel(condition = "input.inputDataType2 == 'upload'",
                fileInput(inputId = "inputDataRaw2",
                          label = "Upload raw coverage data to process",
                          accept = c("text/csv",
                                     "text/comma-separated-values,text/plain",
                                     ".csv"))
              ),
              conditionalPanel(condition = "input.inputDataType2 == 'odk'",
                radioButtons(inputId = "inputOdkData2",
                             label = "Pull data from ODK remote or local?",
                             choices = c(Remote = "remote", Local = "local")
                ),
                br(),
                conditionalPanel(condition = "input.inputOdkData2 == 'remote'",
                  textInput(inputId = "inputOdkUrl2",
                            label = "Remote URL",
                            placeholder = "https://odk.ona.io"),
                  textInput(inputId = "inputOdkUsername2",
                            label = "Username",
                            value = "cadnihead"),
                  textInput(inputId = "inputOdkPassword2",
                            label = "Password",
                            value = "kEv-hAB-Arb-6Cn"),
                  textInput(inputId = "inputOdkFormId2a",
                            label = "Form ID",
                            value = "liberiaCoverage")
                ),
                conditionalPanel(condition = "input.inputOdkData2 == 'local'",
                  textInput(inputId = "inputOdkDirectory2",
                            label = "Where is the local ODK directory located?",
                            value = getwd()),
                  textInput(inputId = "inputOdkFormId2b",
                            label = "Form ID",
                            value = "liberiaCoverage")
                ),
                conditionalPanel(condition = "input.inputOdkFormId2a != ' ' | input.inputOdkFormId2a != ' '",
                  actionButton(inputId = "inputDataAction2",
                               label = "Pull data",
                               icon = icon(name = "arrow-down",
                                           lib = "font-awesome",
                                           class = "fa-lg"))
                )
              )
            )
          ),
          conditionalPanel(condition = "input.process == 'villageData'",
            box(title = "Input Village Data",
                solidHeader = TRUE,
                status = "danger",
                width = 4,
              radioButtons(inputId = "inputDataType1",
                           label = "How will village data be inputted?",
                           choices = c("Upload data file" = "upload",
                                       "Get data from ODK server" = "odk")),
              br(),
              conditionalPanel(condition = "input.inputDataType1 == 'upload'",
                fileInput(inputId = "inputDataRaw1",
                          label = "Upload raw village data to process",
                          accept = c("text/csv",
                                     "text/comma-separated-values,text/plain",
                                     ".csv"))
              ),
              conditionalPanel(condition = "input.inputDataType1 == 'odk'",
                radioButtons(inputId = "inputOdkData1",
                             label = "Pull data from ODK remote or local?",
                             choices = c(Remote = "remote", Local = "local")),
                br(),
                conditionalPanel(condition = "input.inputOdkData1 == 'remote'",
                  textInput(inputId = "inputOdkUrl1",
                            label = "Remote URL",
                            placeholder = "https://ona.io/cadnihead"),
                  textInput(inputId = "inputOdkUsername1",
                            label = "Username",
                            value = "cadnihead"),
                  textInput(inputId = "inputOdkPassword1",
                            label = "Password",
                            value = "kEv-hAB-Arb-6Cn"),
                  textInput(inputId = "inputOdkFormId1a",
                            label = "Form ID",
                            value = "liberiaVillageForm")
                ),
                conditionalPanel(condition = "input.inputOdkData1 == 'local'",
                  textInput(inputId = "inputOdkDirectory1",
                            label = "Where is the local ODK directory located?",
                            value = getwd()),
                  textInput(inputId = "inputOdkFormId1b",
                            label = "Form ID",
                            value = "liberiaVillageForm")
                ),
                conditionalPanel(condition = "input.inputOdkFormId1a != ' ' | input.inputOdkFormId1b != ' '",
                  actionButton(inputId = "inputDataAction1",
                               label = "Pull data",
                               icon = icon(name = "arrow-down",
                                           lib = "font-awesome",
                                           class = "fa-lg"))
                )
              )
            )
          ),
          tabBox(title = "Process",
                 id = "process",
                 selected = "villageData",
                 side = "right",
                 width = 8,
            tabPanel(title = "Process Indicators", value = "processData",
              fluidRow()
            ),
            tabPanel(title = "Check Data",
                     value = "checkData",
              fluidRow()
            ),
            tabPanel(title = "Coverage Data", value = "coverageData",
              fluidRow(
                conditionalPanel(condition = "input.inputDataRaw2.length > 0",
                  box(title = NULL,
                      width = 12,
                      status = "danger",
                      DT::dataTableOutput("surveyDataTable")
                  )
                )
              )
            ),
            tabPanel(title = "Village Data", value = "villageData",
              fluidRow(
                conditionalPanel(condition = "input.inputDataRaw1.length > 0",
                  box(title = NULL, width = 12, status = "danger",
                      DT::dataTableOutput("villageDataTable")
                  )
                )
              )
            )
          )
        )
      ),
      #
      # Body output when 'analyse' menu is selected
      #
      tabItem(tabName = "analyse",
        box(title = "Analyse", solidHeader = FALSE, status = "danger", width = 12,
          fluidRow(
            box(title = "Analysis Parameters", solidHeader = TRUE,
                status = "danger", width = 4,
              checkboxGroupInput(inputId = "analysisIndicators",
                                 label = "Select indicators to analyse",
                                 choices = c("IMAM coverage",
                                             "Vitamin A supplementation coverage",
                                             "FeFol supplementation coverage",
                                             "Micronutrient powder supplementation coverage",
                                             "Infant and young child feeding counselling coverage"),
                                 selected = c("IMAM coverage",
                                              "Vitamin A supplementation coverage",
                                              "FeFol supplementation coverage",
                                              "Micronutrient powder supplementation coverage",
                                              "Infant and young child feeding counselling coverage")
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
                                       lib = "font-awesome",
                                      class = "fa-lg"))
            )
          )
        )
      ),
      #
      # Body output when 'report' menu is selected
      #
      tabItem(tabName = "report",
        box(title = "Report", solidHeader = FALSE, status = "danger", width = 12)
      )
    )
  )
)

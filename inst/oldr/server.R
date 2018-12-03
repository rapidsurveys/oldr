################################################################################
#
#
# This is a Shiny web application to support the implementation Rapid Assessment
# Method for Older People (RAM-OP) surveys.
#
# This code is for the server logic function of the Shiny web aplication.
#
#
################################################################################


################################################################################
#
# Server logic for web application
#
################################################################################
#
# Define server logic for application
#
server <- function(input, output, session) {
  ##############################################################################
  #
  # Create reactive objects
  #
  ##############################################################################
  #
  # Create area map objects - level 0
  #
  mapCountry <- reactive({
    if(input$mapSamplingLevel0 != "") {
      gadmr::get_map(format = "gpkg",
                     country = input$mapSamplingLevel0,
                     layer = 1)
    }
  })
  #
  # Create area map objects - level 1
  #
  mapRegion <- reactive({
    if(input$mapSamplingLevel0 != "") {
      regionMap <- gadmr::get_map(format = "gpkg",
                                  country = input$mapSamplingLevel0,
                                  layer = 2)
    }
  })
  #
  # Create area map objects - level 1
  #
  selectedRegion <- reactive({
    if(input$mapSamplingLevel1 != "") {
      selectedRegion <- mapRegion()[mapRegion()@data$NAME_1 == input$mapSamplingLevel1, ]
    }
  })
  #
  # Create area map objects - level 2
  #
  mapDistrict <- reactive({
    if(input$mapSamplingLevel0 != "") {
      districtMap <- gadmr::get_map(format = "gpkg",
                                    country = input$mapSamplingLevel0,
                                    layer = 3)
    }
  })
  #
  # Create area map objects - level 1
  #
  selectedDistrict <- reactive({
    if(input$mapSamplingLevel2 != "") {
      selectedDistrict <- mapDistrict()[mapDistrict()@data$NAME_2 == input$mapSamplingLevel2, ]
    }
  })
  #
  # Create choices - regions
  #
  choicesRegion <- reactive({
    as.character(req(mapRegion())@data$NAME_1)
  })
  #
  # Create choices - district
  #
  choicesDistrict <- reactive({
    as.character(req(mapDistrict())@data$NAME_2)
  })
  ##############################################################################
  #
  # Update UI
  #
  ##############################################################################
  #
  # Update region selection
  #
  observeEvent(input$mapSamplingLevel0 != "", {
    updateSelectInput(session,
                      inputId = "mapSamplingLevel1",
                      label = "Select region/province",
                      choices = c("Select region/province" = "",
                                  choicesRegion()),
                      selected = "")
  })
  #
  # Update district selection
  #
  observeEvent(input$mapSamplingLevel1 != "", {
    updateSelectInput(session,
                      inputId = "mapSamplingLevel2",
                      label = "Select district/locality",
                      choices = c("Select district/locality" = "",
                                  choicesDistrict()),
                      selected = "")
  })
  #
  ##############################################################################
  #
  # Spatial sampling
  #
  ##############################################################################
  #
  # Base map
  #
  output$mapSampling <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
      setView(lng = 0, lat = 0, zoom = 1)
  })
  #
  # Country borders
  #
  observeEvent(mapCountry(), {
    leafletProxy("mapSampling") %>%
      clearShapes() %>%
      clearMarkers() %>%
      clearControls() %>%
      fitBounds(lng1 = bbox(mapCountry())[1,1],
                lat1 = bbox(mapCountry())[2,1],
                lng2 = bbox(mapCountry())[1,2],
                lat2 = bbox(mapCountry())[2,2]) %>%
      addPolygons(data = mapCountry(),
                  color = "yellow",
                  weight = 6,
                  fill = FALSE)
  })
  #
  # Level 1 borders
  #
  observeEvent(selectedRegion(), {
    leafletProxy("mapSampling") %>%
      clearShapes() %>%
      clearMarkers() %>%
      clearControls() %>%
      fitBounds(lng1 = bbox(selectedRegion())[1,1],
                lat1 = bbox(selectedRegion())[2,1],
                lng2 = bbox(selectedRegion())[1,2],
                lat2 = bbox(selectedRegion())[2,2]) %>%
      addPolygons(data = selectedRegion(),
                  color = "yellow",
                  weight = 6,
                  fill = FALSE)
  })
  #
  # Level 2 borders
  #
  observeEvent(selectedDistrict(), {
    leafletProxy("mapSampling") %>%
      clearShapes() %>%
      clearMarkers() %>%
      clearControls() %>%
      fitBounds(lng1 = bbox(selectedDistrict())[1,1],
                lat1 = bbox(selectedDistrict())[2,1],
                lng2 = bbox(selectedDistrict())[1,2],
                lat2 = bbox(selectedDistrict())[2,2]) %>%
      addPolygons(data = selectedDistrict(),
                  color = "yellow",
                  weight = 6,
                  fill = FALSE)
  })
  #
  # Input - village location data
  #
  settlements1 <- reactive({
    inputFile <- input$settlementsData1
    if(is.null(inputFile)) {
      return(NULL)
    }
    read.csv(file = inputFile$datapath, header = TRUE, sep = ",")
  })
  #
  # Input - village data
  #
  settlements2 <- reactive({
    inputFile <- input$settlementsData2
    if(is.null(inputFile)) {
      return(NULL)
    }
    read.csv(file = inputFile$datapath, header = TRUE, sep = ",")
  })
  #
  #
  #
  output$settlementsTable2 <- DT::renderDataTable(
    expr = settlements2(),
    options = list(scrollX = TRUE, pageLength = 20)
  )
  #
  # Select sorting variable
  #
  observeEvent(input$settlementsData2, {
    updateSelectInput(session,
                      inputId = "sortVariable",
                      label = "Sort village data by",
                      choices = c("Select variable to sort list" = "",
                                  names(settlements2())),
                      selected = "")
  })
  #
  # Sampling using list
  #
  observeEvent(input$mapSamplingList, {
    samplingInterval <- floor(nrow(settlements2()) / 16)
    randomStart <- sample(x = 1:samplingInterval, size = 1)
    selectRows <- seq(from = randomStart, to = nrow(settlements2()), by = samplingInterval)
    #
    #
    #
    mapSamplingSettlements <- settlements2()[order(settlements2()[ , input$sortVariable]), ][selectRows, ]
    #
    #
    #
    output$samplingListDownload2 <- downloadHandler(
      filename = function() {
        "samplingList.csv"
      },
      content = function(file) {
        write.csv(mapSamplingSettlements, file, row.names = FALSE)
      }
    )
    #
    # Output data table
    #
    output$mapSamplingTable2 <- DT::renderDataTable(
      expr = mapSamplingSettlements,
      options = list(scrollX = TRUE, pageLength = 20)
    )
  })
  #
  # Plot country sampling grid
  #
  observeEvent(input$mapSamplingPlot, {
    if(input$mapSamplingLevel0 != "" & input$mapSamplingSpec == "area") {
      mapSamplingPoint <- create_sp_grid(x = mapCountry(),
                                         area = input$mapSamplingGridArea,
                                         country = input$mapSamplingLevel0)
    }
    if(input$mapSamplingLevel0 != "" & input$mapSamplingSpec == "n") {
      mapSamplingPoint <- create_sp_grid(x = mapCountry(),
                                         n = input$mapSamplingGridNumber,
                                         country = input$mapSamplingLevel0,
                                         buffer = 2,
                                         n.factor = 5,
                                         fixed = TRUE)
    }
    if(input$mapSamplingLevel0 != "" & input$mapSamplingSpec == "d") {
      mapSamplingPoint <- create_sp_grid(x = mapCountry(),
                                         d = input$mapSamplingGridDist,
                                         country = input$mapSamplingLevel0,
                                         buffer = 2)
    }
    #
    # Convert to hexagonal SpatialPolygons
    #
    mapSamplingGrid <- HexPoints2SpatialPolygons(hex = mapSamplingPoint)
    mapSamplingSettlements <- get_nearest_point(data = settlements1(),
                                                data.x = "COORD_X",
                                                data.y = "COORD_Y",
                                                query = mapSamplingPoint,
                                                n = input$mapSamplingSettlementsNumber)
    #
    #
    #
    output$samplingListDownload <- downloadHandler(
      filename = function() {
        "samplingList.csv"
      },
      content = function(file) {
        write.csv(mapSamplingSettlements, file, row.names = FALSE)
      }
    )
    #
    # Output data table
    #
    output$mapSamplingTable1 <- DT::renderDataTable(
      expr = mapSamplingSettlements,
      options = list(scrollX = TRUE, pageLength = 20)
    )
  })
  #
  ##############################################################################
  #
  # Collect
  #
  ##############################################################################
  #
  # The RAM-OP Questionnaire
  #
  output$questionnaireOP <- renderUI({
    HTML("
      <p>The entire RAM-OP questionnaire is presented here. This questionnaire
         is composed of many tested and validated components. The order of the
         questions and the format of the questionnaire have been tested in
         several settings (Chad, Dadaab Camps, South Sudan, Ethiopia, and
         Tanzania) over a period of three years. It is strongly recommended
         that you do not change the questionnaire, other than translating it
         into a language other than English and necessary localisation (i.e.
         adapting the questions to meet the language, cultural, and other
         requirements of a specific target population in order to ensure that
         the words, names, terms, and concepts used are culturally appropriate
         and understandable to them), unless you are very sure of what you are
         doing. Modifying the questionnaire may have one or more of the
         following consequences:</p>
      &nbsp;
      <ul>
        <li><strong>Modifying the order of the questions or adding
            questions: </strong>The links with the data entry, data checking,
            and data analysis software will be broken. You will have to modify
            the software to accommodate your changes.</li>
        <li><strong>Modifying the variable names: </strong>The links with the
            data entry, data checking, and data analysis software will be
            broken. You will have to modify the software to accommodate your
            changes.</li>
        <li><strong>Modifying content or the phrasing of questions: </strong>
            All questions have been tested and are formulated for accuracy and
            reliability (precision). Modifying them may lead to loss of acuracy
            (bias) and precision.</li>
      </ul>
      &nbsp;
      <p>When translating the questionnaire you should check if validated
         question sets for each indicator module are already available in your
         local language. This is likely to be the case for the food intake,
         severe food insecurity, activities of daily living, mental health and
         well-being, dementia, water / sanitation / hygiene, and visual
         impairment indicator modules. There may also be local language training
         modules and guidelines available for these modules.</p>

      <p>Localisation is recommended for:</p>
      &nbsp;
      <ul>
      <li><strong>Food groups: </strong>Remove inappropriate foodstuffs and
          give examples of local foodstuffs.</li>
      <li><strong>Income sources: </strong>Review income types and income
          categories.</li>
      </ul>
      &nbsp;
      <p>The question numbers used on the questionnaire are the names of
         variables used in the RAM-OP data entry, data checking, and data
         analysis software. Leaving these as they are will be helpful if you
         intend to use the RAM-OP data-entry and data-analysis software.</p>

      <p>The questionnaire can be downloaded (in ODT and PDF format) from
         <a href='http://www.brixtonhealth.com/qesRAMOP.zip' target='_blank'>http://www.brixtonhealth.com/qesRAMOP.zip</a>
    ")
  })
  #
  # EpiData
  #
  output$collectEpiData <- renderUI({
    HTML("
      <p><strong><a href='http://www.epidata.dk' target='_blank'>EpiData Entry</a></strong> is used
         for simple or programmed data entry and data documentation. Entry
         handles simple forms or related systems optimised documentation and
         error detection features, e.g. double entry verification, list of ID
         numbers in several files, codebook overview of data, date added to
         backup and encryption procedures.</p>
      &nbsp;
      <h5>Download EpiData</h5>
      <p><strong><a href='http://www.epidata.dk' target='_blank'>EpiData Entry</a></strong> can be
         downloaded from <a href='http://www.epidata.dk/php/downloadc.php?file=setup_epidata.exe'>here</a>.</p>

      <p>EpiData software installation can be as simple as copying the program files.
         For example, it can be run from a USB pin (memory stick) and is small (<2.5mb).</p>
      &nbsp;
      <h5>Download RAM-OP EpiData forms</h5>
      <p>The RAM-OP EpiData forms can be accessed in both English and French:</p>
      &nbsp;
      <ul>
        <li><a href='https://www.dropbox.com/s/2kudlxjqcqn8wph/RAMOP%20data%20entry%20files%20%28English%29.zip?dl=0'>English</a></li>
        <li><a href='https://www.dropbox.com/s/c1ox1m8zb7ebjml/RAMOP%20data%20entry%20files%20%28French%29.zip?dl=0'>French</a></li>
      </ul>
    ")
  })
  #
  # Open Data Kit
  #
  output$collectOdk <- renderUI({
    HTML("
      <p><strong>RAM-OP</strong> can be implemented using the
         <a target='_blank' href='https://opendatakit.org'><strong>Open Data Kit</strong></a>
         digital data collection system. The study instrument has been encoded
         into the electronic data entry system platform.</p>

      <p>The <strong>XLSForm</strong> and <strong>XForm</strong> formats for use
         in digital data collection and instructions on how to use them can be
         obtained <a target='_blank' href='https://github.com/rapidsurveys/ramOPodk'><strong>here</strong></a>.</p>
    ")
  })
  #
  ##############################################################################
  #
  # Process
  #
  ##############################################################################
  #
  # PSU dataset
  #
  psuDataset <- reactive({
    inputFile <- input$inputDataPSU
    if(is.null(inputFile)) {
      return(NULL)
    }
    read.csv(file = inputFile$datapath, header = TRUE, sep = ",")
  })
  #
  #
  #
  output$psuDataDescription <- renderUI({
    HTML("
      <p>This is a short and narrow file with one record per primary sampling
         unit (PSU) and just two variables:</p>
      &nbsp;
      <ul>
        <li><strong>psu: </strong>The PSU identifier. This <strong>must</strong>
            use the same coding system used to identify PSUs that is used in the
            main RAM-OP dataset.</li>
        <li><strong>pop: </strong>The population of the PSU.</li>
      </ul>
    ")
  })
  #
  # Output psu dataset table
  #
  output$psuDataTable<- DT::renderDataTable(
    expr = psuDataset(),
    options = list(scrollX = TRUE, pageLength = 20)
  )
  #
  # Survey dataset
  #
  surveyDataset <- reactive({
    inputFile <- input$inputDataSurvey
    if(is.null(inputFile)) {
      return(NULL)
    }
    read.csv(file = inputFile$datapath, header = TRUE, sep = ",")
  })
  #
  #
  #
  output$surveyDataDescription <- renderUI({
    HTML("
      <p>This is the data collected by the survey questionnaire.</p>
    ")
  })
  #
  # Output survey dataset table
  #
  output$surveyDataTable<- DT::renderDataTable(
    expr = surveyDataset(),
    options = list(scrollX = TRUE, pageLength = 20)
  )
  #
  # Proces data description
  #
  output$indicatorsDescription <- renderUI({
    HTML("
      <p>RAM-OP surveys collect and report on data for a broad range of
         indicators relevant to older people.</p>

      <p>These indicators cover the following dimensions: demography and situation,
         food intake, severe food insecurity, disability, activities of daily living,
         mental health and well-being, dementia, health and health-seeking behaviour,
         sources of income, water, sanitation, and hygiene, anthropometry and
         screening coverage, and visual impairment.</p>

      <p>Data for a small group of miscellaneous indicators are also collected
         and reported.</p>

      <p>The RAM-OP indicator set has been designed on a modular basis. Each
         module is a set of indicators relating to a single dimension from the
         list given above and is collected using a dedicated set of questions
         and measurements. This means that the RAM-OP questionnaire also
         consists of a set of modules.</p>
    ")
  })
  #
  # Process data
  #
  observeEvent(input$inputProcessAction, {
    indicators.ALL <- reactive({
      isolate(create_op_all(svy = req(surveyDataset()),
                            indicators = input$inputIndicators))
    })
    #
    #
    #
    output$indicatorsDataTable <- DT::renderDataTable(
      expr = indicators.ALL(),
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    #
    #
    output$downloadIndicatorData <- downloadHandler(
      filename = function() {
        "indicators.ALL.csv"
      },
      content = function(file) {
        write.csv(indicators.ALL(), file, row.names = FALSE)
      }
    )
  })
  #
  ##############################################################################
  #
  # Analyse
  #
  ##############################################################################
  #
  observeEvent(input$analysisAction, {
    ##
    indicatorsDF <- reactive({
      isolate(create_op_all(svy = req(surveyDataset()),
                            indicators = input$analyseIndicators))
    })
    ##
    classicEstimates <- reactive({
      isolate(estimateClassic(x = indicatorsDF(), w = req(psuDataset()),
                              indicators = input$analyseIndicators,
                              params = get_variables(indicators = input$analyseIndicators),
                              replicates = input$replicates))
    })
    ##
    probitEstimates <- reactive({
      ##
      NULL
      ##
      if("anthro" %in% input$analyseIndicators) {
        isolate(estimateProbit(x = indicatorsDF(), w = req(psuDataset()),
                               replicates = input$replicates))
      }
    })
    ##
    results <- reactive({
      isolate(mergeEstimates(x = classicEstimates(), y = probitEstimates()))
    })
    ##
    prettyResults <- reactive({
      data.frame(results()[ , c("GROUP", "INDICATOR", "LABEL", "TYPE")],
                 round(results()[ , !names(results()) %in% c("GROUP", "INDICATOR", "LABEL", "TYPE")],
                       digits = 2))
    })
    ##
    output$resultsTable <- DT::renderDataTable(
      expr = results(),
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    #
    #
    output$analysisDownload <- downloadHandler(
      filename = function() {
        "results.ALL.csv"
      },
      content = function(file) {
        write.csv(results(), file)
      }
    )
    #
    # Survey respondents results plot - ALL
    #
    output$surveyPlot <- renderPlot({
      x <- results()[results()$INDICATOR %in% c("resp1", "resp2", "resp3", "resp4"), ]
      y <- gather(x, key = "SET", value = "EST", EST.ALL, EST.MALES, EST.FEMALES)
      ggplot(data = y, aes(x = SET, y = EST, fill = INDICATOR)) +
        geom_col(width = 0.5) +
        labs(x = "", y = "Proportion") +
        scale_x_discrete(labels = c("All", "Males", "Females")) +
        scale_fill_manual(name = "Respondent",
                          values = brewer.pal(n = 4, name = "Pastel1"),
                          labels = c("Subject", "Family Carer", "Other Carer", "Other")) +
        themeSettings +
        theme(legend.position = "top")
    })
    #
    # Survey respondents results - ALL
    #
    output$surveyTable <- DT::renderDataTable(
      prettyResults()[results()$INDICATOR %in% c("resp1", "resp2", "resp3", "resp4"), c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Survey respondents results - MALES
    #
    output$surveyTableMales <- DT::renderDataTable(
      prettyResults()[results()$INDICATOR %in% c("resp1", "resp2", "resp3", "resp4"), c("INDICATOR", "LABEL", "TYPE", "EST.MALES", "LCL.MALES", "UCL.MALES")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Survey respondents results - FEMALES
    #
    output$surveyTableFemales <- DT::renderDataTable(
      prettyResults()[results()$INDICATOR %in% c("resp1", "resp2", "resp3", "resp4"), c("INDICATOR", "LABEL", "TYPE", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Demographic results
    #
    output$demoTable <- DT::renderDataTable(
      prettyResults()[results()$INDICATOR %in% get_variables(indicators = "demo") & !results()$INDICATOR %in% c("resp1", "resp2", "resp3", "resp4"), c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    #
    #
    observeEvent(input$viewAgeTable, {
      showModal(
        modalDialog(
          DT::dataTableOutput("demoTable"), easyClose = TRUE
        )
      )
    })
    #
    # Demographic results - age
    #
    output$ageTable <- DT::renderDataTable(
      prettyResults()[results()$INDICATOR %in% c("age", "ageGrp1", "ageGrp2", "ageGrp3", "ageGrp4"), c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Demographic results - age for Males
    #
    output$ageTableMales <- DT::renderDataTable(
      prettyResults()[results()$INDICATOR %in% c("age", "ageGrp1", "ageGrp2", "ageGrp3", "ageGrp4"), c("LABEL", "TYPE", "EST.MALES", "LCL.MALES", "UCL.MALES")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Demographic results - age for Males
    #
    output$ageTableFemales <- DT::renderDataTable(
      prettyResults()[results()$INDICATOR %in% c("age", "ageGrp1", "ageGrp2", "ageGrp3", "ageGrp4"), c("LABEL", "TYPE", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Demographic results - age plots
    #
    output$agePlot <- renderPlot({
      x <- create_op_all(surveyDataset())
      sexText <- ifelse(x$sex1 == 1, "Male", "Female")
      ageGroup <- bbw::recode(x$age, "50:59='50:59'; 60:69='60:69'; 70:79='70:79'; 80:89='80:89'; 90:hi='90+'; else=NA")

      pyramid.plot(x = ageGroup,
                   g = sexText,
                   main = "",
                   xlab = "     Male    /    Female",
                   ylab = "Age Groups")
    })
    #
    # Food intake results
    #
    output$foodTable <- DT::renderDataTable(
      prettyResults()[results()$INDICATOR %in% get_variables(indicators = "food"), ],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
  })
  #
  ##############################################################################
  #
  # Report
  #
  ##############################################################################
  #
}

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

      progress <- Progress$new()
      on.exit(progress$close())
      progress$set(message = paste("Retrieving map of ", list_countries$country[list_countries$iso3code == input$mapSamplingLevel0], sep = ""), value = 0.7)

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
    mapSamplingPoint <- create_sp_grid(x = mapCountry(),
                                       n = 16,
                                       country = input$mapSamplingLevel0,
                                       buffer = 2,
                                       n.factor = 5,
                                       fixed = TRUE)
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
  # Stage 2 sampling
  #
  ##############################################################################
  #
  #
  #
  output$stage2SamplingSummary <- renderUI({
    HTML("
      <p>The second stage within-community sample uses a method called
         <em>map-segment-sample</em>. This method takes the within-community
         sample from all parts of a sampled community.</p>
    ")
  })
  #
  #
  #
  output$stage2SamplingDescription <- renderUI({
    HTML("
         <p>The second stage (within-community) sample uses a
            <em>map-segment-sample</em> approach:</p>

            <ul>
              <li><strong>Map:</strong> Make a rough map of the community to be
                  sampled. It is helpful to think of communities as being made
                  of ribbons (i.e. lines of dwellings located along roads,
                  tracks, or rivers) and clusters of dwellings.

                  <br/>

                  <p>Here is an example of a ribbon of dwellings:</p>

              <img <img src='https://ram.validmeasures.org/ramOPmanual/figures/stage2sample1.png' width = '400px'>

                  &nbsp;

                  <p>Here is an example of a cluster of dwellings:</p>

              <img <img src='https://ram.validmeasures.org/ramOPmanual/figures/stage2sample2.png' width = '400px'>

              <li><strong>Segment:</strong> Divide the community into ribbon and cluster segments \
                  defined by the physical layout of the community being sampled.</li>

              <li><strong>Sample:</strong> Ribbons and clusters are sampled in different ways:

                <p><strong>Ribbons</strong> are sampled using systematic sampling.</p>
                <p><strong>Clusters</strong> are sampled using a random walk method.</p>

                <strong>Note:</strong> If a small community is selected that is
                likely to have fewer than the required number of eligible persons
                then all eligible persons in that community are sampled by moving
                door-to-door.</li>
            </ul>
         ")
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

      progress <- Progress$new()
      on.exit(progress$close())
      progress$set(message = "Bootstrapping with classical estimator", value = 0.7)

      isolate(estimateClassic(x = indicatorsDF(), w = req(psuDataset()),
                              indicators = input$analyseIndicators,
                              params = get_variables(indicators = input$analyseIndicators),
                              replicates = input$replicates))
    })
    ##
    probitEstimates <- reactive({

      progress <- Progress$new()
      on.exit(progress$close())
      progress$set(message = "Bootstrapping with probit estimator", value = 0.7)

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
      x <- data.frame(results()[ , c("GROUP", "INDICATOR", "LABEL", "TYPE")],
                      round(results()[ , !names(results()) %in% c("GROUP", "INDICATOR", "LABEL", "TYPE")],
                            digits = 2))
    })
    ##
    prettyResultsLong <- reactive({

      temp <- subset(prettyResults(), select = c(-LCL.ALL, -LCL.MALES, -LCL.FEMALES, -UCL.ALL, -UCL.MALES, -UCL.FEMALES))
      x <- gather(temp, key = "SET", value = "EST", EST.ALL, EST.MALES, EST.FEMALES)

      temp <- subset(prettyResults(), select = c(-EST.ALL, -EST.MALES, -EST.FEMALES, -UCL.ALL, -UCL.MALES, -UCL.FEMALES))
      y <- gather(temp, key = "SET", value = "LCL", LCL.ALL, LCL.MALES, LCL.FEMALES)

      temp <- subset(prettyResults(), select = c(-LCL.ALL, -LCL.MALES, -LCL.FEMALES, -EST.ALL, -EST.MALES, -EST.FEMALES))
      z <- gather(temp, key = "SET", value = "UCL", UCL.ALL, UCL.MALES, UCL.FEMALES)

      xyz <- data.frame(x, "LCL" = y[ , "LCL"], "UCL" = z[ , "UCL"])
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
        write.csv(results(), file, row.names = FALSE)
      }
    )
    #
    # Survey respondents results plot - ALL
    #
    output$surveyPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("resp1", "resp2", "resp3", "resp4"), ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                 ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      ggplot(data = x, aes(x = SET, y = EST, fill = INDICATOR)) +
        geom_col(width = 0.7) +
        labs(x = "", y = "Proportion") +
        scale_x_discrete(labels = c("All", "Males", "Females")) +
        scale_fill_manual(name = "Respondent",
                          values = brewer.pal(n = 4, name = "Pastel1"),
                          labels = c("Subject", "Family Carer", "Other Carer", "Other")) +
        theme_ram +
        theme(legend.position = "top")
    })
    #
    # Survey respondents results - ALL
    #
    output$surveyTable <- DT::renderDataTable(
      #prettyResults()[prettyResults()$INDICATOR %in% c("resp1", "resp2", "resp3", "resp4"), c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("resp1", "resp2", "resp3", "resp4"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Survey table modal
    #
    observeEvent(input$viewSurveyTable, {
      showModal(
        modalDialog(
          title = "Survey Respondents",
          DT::dataTableOutput("surveyTable"), easyClose = TRUE
        )
      )
    })
    #
    # Demographic results
    #
    output$demoTable <- DT::renderDataTable(
      #prettyResults()[prettyResults()$INDICATOR %in% get_variables(indicators = "demo") & !prettyResults()$INDICATOR %in% c("resp1", "resp2", "resp3", "resp4"), c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% get_variables(indicators = "demo") & !prettyResults()$INDICATOR %in% c("resp1", "resp2", "resp3", "resp4"), c("LABEL", "TYPE", "SET", "ESTL", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Demographic results - age
    #
    output$ageTable <- DT::renderDataTable(
      #prettyResults()[prettyResults()$INDICATOR %in% c("age", "ageGrp1", "ageGrp2", "ageGrp3", "ageGrp4"), c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("age", "ageGrp1", "ageGrp2", "ageGrp3", "ageGrp4"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Age table modal
    #
    observeEvent(input$viewAgeTable, {
      showModal(
        modalDialog(
          title = "Survey respondents age",
          DT::dataTableOutput("ageTable"), easyClose = TRUE
        )
      )
    })
    #
    # Demographic results - age plots
    #
    output$agePlot <- renderPlot({
      x <- indicatorsDF() #create_op_all(surveyDataset())
      sexText <- ifelse(x$sex1 == 1, "Male", "Female")
      ageGroup <- bbw::recode(x$age, "50:59='50:59'; 60:69='60:69'; 70:79='70:79'; 80:89='80:89'; 90:hi='90+'; else=NA")

      pyramid.plot(x = ageGroup,
                   g = sexText,
                   main = "",
                   xlab = "                    Male    /    Female",
                   ylab = "Age Groups")
    })
    #
    # Marital results plot - ALL
    #
    output$maritalPlot <- renderPlot({
      x <- results()[results()$INDICATOR %in% c("marital1", "marital2", "marital3", "marital4", "marital5", "marital6"), ]
      y <- gather(x, key = "SET", value = "EST", EST.ALL, EST.MALES, EST.FEMALES)
      ggplot(data = y, aes(x = SET, y = EST, fill = INDICATOR)) +
        geom_col(width = 0.7) +
        labs(x = "", y = "Proportion") +
        scale_x_discrete(labels = c("All", "Males", "Females")) +
        scale_fill_manual(name = "Marital Status",
                          values = brewer.pal(n = 6, name = "Pastel1"),
                          labels = c("Single", "Married", "Living together", "Divorced", "Widowed", "Other")) +
        theme_ram +
        theme(legend.position = "top")
    })
    #
    # Demographic results - marital status
    #
    output$maritalTable <- DT::renderDataTable(
      #prettyResults()[prettyResults()$INDICATOR %in% c("age", "marital1", "marital2", "marital3", "marital4", "marital5", "marital6"), c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("age", "marital1", "marital2", "marital3", "marital4", "marital5", "marital6"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 7)
    )
    #
    # Marital table modal
    #
    observeEvent(input$viewMaritalTable, {
      showModal(
        modalDialog(
          title = "Marital Status",
          DT::dataTableOutput("maritalTable"), easyClose = TRUE
        )
      )
    })
    #
    # Alone results plot - ALL
    #
    output$alonePlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR == "alone", ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                 ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(data = x, aes(x = SET, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray50") +
        labs(x = "", y = "Proportion") +
        scale_x_discrete(labels = c("All", "Males", "Females")) +
        scale_y_continuous(limits = c(0, 1), breaks = seq(from = 0, to = 1, by = 0.2))

      if(input$errorAlone) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70") +
          theme_ram
      }

      chartPlot + theme_ram
    })
    #
    # Demographic results - living alone
    #
    output$aloneTable <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR == "alone", c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 10)
    )
    #
    # alone table modal
    #
    observeEvent(input$viewAloneTable, {
      showModal(
        modalDialog(
          title = "Respondents living alone",
          DT::dataTableOutput("aloneTable"), easyClose = TRUE
        )
      )
    })
    #
    # Meal frequency results plot - ALL
    #
    output$mealPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR == "MF", ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                 ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(data = x, aes(x = SET, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray50") +
        labs(x = "", y = "Mean No. of Meals per Day") +
        scale_x_discrete(labels = c("All", "Males", "Females")) +
        scale_y_continuous(limits = c(0, 3), breaks = seq(from = 0, to = 3, by = 0.5))

      if(input$errorMeal) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot + theme_ram
    })
    #
    # Food intake results
    #
    output$mealTable <- DT::renderDataTable(
      #prettyResults()[prettyResults()$INDICATOR == "MF", c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      prettyResultsLong()[prettyResultsLong()$INDICATOR == "MF", c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # food intake table modal
    #
    observeEvent(input$viewMealTable, {
      showModal(
        modalDialog(
          title = "Meal frequency",
          DT::dataTableOutput("mealTable"), easyClose = TRUE
        )
      )
    })
    #
    # food group consumption results plot - ALL
    #
    output$fgPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("FG01", "FG02", "FG03", "FG04", "FG05", "FG06", "FG07", "FG08", "FG09", "FG10", "FG11"), ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2)) +
        theme_ram

      if(input$groupFG == "sex") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ SET) +
          theme_ram +
          theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
      }

      if(input$groupFG == "indicator") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = SET, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ INDICATOR) +
          theme_ram
      }

      if(input$groupFG == "no") {
        chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          theme_ram
      }

      if(input$errorFG) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot
    })
    #
    # Food group consumption results
    #
    output$fgTable <- DT::renderDataTable(
      #prettyResults()[prettyResults()$INDICATOR %in% c("FG01", "FG02", "FG03", "FG04", "FG05", "FG06", "FG07", "FG08", "FG09", "FG10", "FG11"), c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("FG01", "FG02", "FG03", "FG04", "FG05", "FG06", "FG07", "FG08", "FG09", "FG10", "FG11"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 11)
    )
    #
    # food intake table modal
    #
    observeEvent(input$viewFGTable, {
      showModal(
        modalDialog(
          title = "Food groups consumption",
          DT::dataTableOutput("fgTable"), easyClose = TRUE
        )
      )
    })
    #
    # DDS results plot - ALL
    #
    output$ddsPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR == "DDS", ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                 ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(data = x, aes(x = SET, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray50") +
        labs(x = "", y = "Mean Dietary Diversity Score") +
        scale_x_discrete(labels = c("All", "Males", "Females")) +
        scale_y_continuous(limits = c(0, 11), breaks = seq(from = 0, to = 11, by = 1))

      if(input$errorDDS) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot + theme_ram
    })
    #
    # DDS results
    #
    output$ddsTable <- DT::renderDataTable(
      #prettyResults()[prettyResults()$INDICATOR == "DDS", c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      prettyResultsLong()[prettyResultsLong()$INDICATOR == "DDS", c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # DDS table modal
    #
    observeEvent(input$viewDDSTable, {
      showModal(
        modalDialog(
          title = "Mean Dietary Diversity Score",
          DT::dataTableOutput("ddsTable"), easyClose = TRUE
        )
      )
    })
    #
    # Raw DDS score histogram plot
    #
    output$ddsHistPlot <- renderPlot({
      x <- indicatorsDF()[ , c("sex1", "DDS")]

      x$sex1 <- ifelse(x$sex1 == 1, "Males", "Females")
      x$sex1 <- factor(x$sex1, levels = c("Males", "Females"))

      chartPlot <- ggplot(data = x, aes(x = DDS)) +
        geom_bar(width = 0.7, fill = "white", colour = "gray50") +
        labs(x = "Dietary Diversity Score", y = "Frequency") +
        scale_x_continuous(limits = c(0, 11), breaks = seq(from = 0, to = 11, by = 1))

      if(input$groupDDS == "sex") {
        chartPlot <- ggplot(data = x, aes(x = DDS)) +
          geom_bar(width = 0.7, fill = "white", colour = "gray50") +
          labs(x = "Dietary Diversity Score", y = "Frequency") +
          scale_x_discrete(limits = 0:11,
                           breaks = seq(from = 0, to = 11, by = 1)) +
          facet_wrap( ~ sex1)
      }

      chartPlot +
        theme_ram
    })
    #
    # Raw DDS boxplots
    #
    output$ddsBoxPlot <- renderPlot({
      x <- indicatorsDF()[ , c("sex1", "DDS")]
      x$sex1 <- ifelse(x$sex1 == 1, "Males", "Females")
      x$sex1 <- factor(x$sex1, levels = c("Males", "Females"))
      ggplot(data = x, aes(y = DDS, x = sex1)) +
        geom_boxplot(notch = TRUE, width = 0.3, colour = "gray70", size = 1) +
        labs(x = "", y = "Dietary Diversity Score") +
        scale_y_continuous(limits = c(0, 11), breaks = seq(from = 0, to = 11, by = 1)) +
        theme_ram
    })
    #
    # Protein results
    #
    output$proteinTable <- DT::renderDataTable(
      #prettyResults()[prettyResults()$INDICATOR == "DDS", c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("proteinRich", "pProtein", "aProtein"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Protein table modal
    #
    observeEvent(input$viewProteinTable, {
      showModal(
        modalDialog(
          title = "Consumption of foods rich in protein",
          DT::dataTableOutput("proteinTable"), easyClose = TRUE
        )
      )
    })
    #
    # Protein plot
    #
    output$proteinPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("proteinRich", "pProtein", "aProtein"), ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                 ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      x$INDICATOR <- ifelse(x$INDICATOR == "pProtein", "Plant\nsources\nof protein",
                       ifelse(x$INDICATOR == "aProtein", "Animal\nsources\nof protein", "Protein-rich\nfoods\nconsumption"))

      x$INDICATOR <- factor(x$INDICATOR, levels = c("Animal\nsources\nof protein",
                                                    "Plant\nsources\nof protein",
                                                    "Protein-rich\nfoods\nconsumption"))

      chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1), breaks = seq(from = 0, to = 1, by = 0.2))

      if(input$groupProtein == "sex") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1), breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ SET)
      }

      if(input$groupProtein == "indicator") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = SET, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1), breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ INDICATOR)
      }

      if(input$errorProtein) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot + theme_ram
    })
    #
    # Vitamin A results
    #
    output$vitATable <- DT::renderDataTable(
      #prettyResults()[prettyResults()$INDICATOR == "DDS", c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("pVitA", "aVitA", "xVitA"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Vitamin A table modal
    #
    observeEvent(input$viewVitATable, {
      showModal(
        modalDialog(
          title = "Consumption of foods rich in vitamin A",
          DT::dataTableOutput("vitATable"), easyClose = TRUE
        )
      )
    })
    #
    # Vitamin A plot
    #
    output$vitAPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("pVitA", "aVitA", "xVitA"), ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                 ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      x$INDICATOR <- ifelse(x$INDICATOR == "pVitA", "Plant\nsources of\nvitamin A",
                            ifelse(x$INDICATOR == "aVitA", "Animal\nsources of\nvitamin A", "Vitamin A-rich\nfoods\nconsumption"))

      x$INDICATOR <- factor(x$INDICATOR, levels = c("Animal\nsources of\nvitamin A",
                                                    "Plant\nsources of\nvitamin A",
                                                    "Vitamin A-rich\nfoods\nconsumption"))

      chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1), breaks = seq(from = 0, to = 1, by = 0.2))

      if(input$groupVitA == "sex") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1), breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ SET)
      }

      if(input$groupVitA == "indicator") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = SET, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1), breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ INDICATOR)
      }

      if(input$errorVitA) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot + theme_ram
    })
    #
    # Vitamin B results
    #
    output$vitBTable <- DT::renderDataTable(
      #prettyResults()[prettyResults()$INDICATOR == "DDS", c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("vitB1", "vitB2", "vitB3", "vitB6", "vitB12", "vitBcomplex"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Vitamin B table modal
    #
    observeEvent(input$viewVitBTable, {
      showModal(
        modalDialog(
          title = "Consumption of foods rich in vitamin B",
          DT::dataTableOutput("vitBTable"), easyClose = TRUE
        )
      )
    })
    #
    # Vitamin B plot
    #
    output$vitBPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("vitB1", "vitB2", "vitB3", "vitB6", "vitB12", "vitBcomplex"), ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                 ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      x$INDICATOR <- ifelse(x$INDICATOR == "vitB1", "B1",
                       ifelse(x$INDICATOR == "vitB2", "B2",
                         ifelse(x$INDICATOR == "vitB3", "B3",
                           ifelse(x$INDICATOR == "vitB6", "B6",
                             ifelse(x$INDICATOR == "vitB12", "B12", "B complex")))))

      x$INDICATOR <- factor(x$INDICATOR, levels = c("B1",
                                                    "B2",
                                                    "B3",
                                                    "B6",
                                                    "B12",
                                                    "B complex"))

      chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1), breaks = seq(from = 0, to = 1, by = 0.2))

      if(input$groupVitB == "sex") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ SET)
      }

      if(input$groupVitB == "indicator") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = SET, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ INDICATOR)
      }

      if(input$errorVitB) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot +
        theme_ram
    })
    #
    # Other vitamin and minerals results
    #
    output$otherVitTable <- DT::renderDataTable(
      #prettyResults()[prettyResults()$INDICATOR == "DDS", c("LABEL", "TYPE", "EST.ALL", "LCL.ALL", "UCL.ALL", "EST.MALES", "LCL.MALES", "UCL.MALES", "EST.FEMALES", "LCL.FEMALES", "UCL.FEMALES")],
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("ironRich", "caRich", "znRich"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Other vitamin and minerals table modal
    #
    observeEvent(input$viewOtherVitTable, {
      showModal(
        modalDialog(
          title = "Consumption of foods rich in iron, calcium and zinc",
          DT::dataTableOutput("otherVitTable"), easyClose = TRUE
        )
      )
    })
    #
    # Vitamin B plot
    #
    output$otherVitPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("ironRich", "caRich", "znRich"), ]

      x$INDICATOR <- ifelse(x$INDICATOR == "ironRich", "Iron-rich\nfoods\nconsumption",
                            ifelse(x$INDICATOR == "caRich", "Calcium-rich\nfoods\nconsumption", "Zinc-rich\nfoods\nconsumption"))

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                 ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2))

      if(input$groupOtherVit == "sex") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ SET)
      }

      if(input$groupOtherVit == "indicator") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = SET, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ INDICATOR)
      }

      if(input$groupOtherVit == "no") {
        chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2))
      }

      if(input$errorOtherVit) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot + theme_ram
    })
    #
    # Household hunger scale
    #
    output$hhsTable <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("HHS1", "HHS2", "HHS3"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Household hunger scale modal
    #
    observeEvent(input$viewHHSTable, {
      showModal(
        modalDialog(
          title = "Household Hunger Scale",
          DT::dataTableOutput("hhsTable"), easyClose = TRUE
        )
      )
    })
    #
    # HHS plot
    #
    output$hhsPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("HHS1", "HHS2", "HHS3"), ]

      x$INDICATOR <- ifelse(x$INDICATOR == "HHS1", "No or little\nhunger",
                        ifelse(x$INDICATOR == "HHS2", "Moderate\nhunger", "Severe\nhunger"))

      x$INDICATOR <- factor(x$INDICATOR, levels = c("No or little\nhunger",
                                                    "Moderate\nhunger",
                                                    "Severe\nhunger"))

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2))

      if(input$groupHHS == "sex") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ SET)
      }

      if(input$groupHHS == "indicator") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = SET, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ INDICATOR)
      }

      if(input$errorHHS) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot +
        theme_ram
    })
    #
    # Actvities of daily living table
    #
    output$adlTable <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("ADL01", "ADL02", "ADL03", "ADL04", "ADL05", "ADL06"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Activities of daily living modal
    #
    observeEvent(input$viewADLTable, {
      showModal(
        modalDialog(
          title = "Activities of daily living",
          DT::dataTableOutput("adlTable"), easyClose = TRUE
        )
      )
    })
    #
    # Activities of daily living plot
    #
    output$adlPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("ADL01", "ADL02", "ADL03", "ADL04", "ADL05", "ADL06"), ]

      x$INDICATOR <- ifelse(x$INDICATOR == "ADL01", "Bathing",
                       ifelse(x$INDICATOR == "ADL02", "Dressing",
                         ifelse(x$INDICATOR == "ADL03", "Toileting",
                           ifelse(x$INDICATOR == "ADL04", "Transferring",
                             ifelse(x$INDICATOR == "ADL05", "Continence", "Feeding")))))

      x$INDICATOR <- factor(x$INDICATOR, levels = c("Bathing",
                                                    "Dressing",
                                                    "Toileting",
                                                    "Transferring",
                                                    "Continence",
                                                    "Feeding"))

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2)) +
        theme_ram

      if(input$groupADL == "sex") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ SET) +
          theme_ram +
          theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
      }

      if(input$groupADL == "indicator") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = SET, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ INDICATOR) +
          theme_ram
      }

      if(input$errorADL) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot
    })
    #
    # ADL score
    #
    output$adlScoreTable <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR == "scoreADL", c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Activities of daily living score modal
    #
    observeEvent(input$viewADLScoreTable, {
      showModal(
        modalDialog(
          title = "Katz ADL Score",
          DT::dataTableOutput("adlScoreTable"), easyClose = TRUE
        )
      )
    })
    #
    # ADL score plot
    #
    output$adlScorePlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR == "scoreADL", ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                 ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x, aes(x = SET, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Meanl ADL Score") +
        scale_y_continuous(limits = c(0, 6),
                           breaks = seq(from = 0, to = 6, by = 1))

      if(input$errorADLscore) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot +
        theme_ram
    })
    #
    # ADL Classification table
    #
    output$adlClassTable <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("classADL1", "classADL2", "classADL3"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # ADL Classification modal
    #
    observeEvent(input$viewADLClassTable, {
      showModal(
        modalDialog(
          title = "Activities of daily living classification",
          DT::dataTableOutput("adlClassTable"), easyClose = TRUE
        )
      )
    })
    #
    # Activities of daily living classification plot
    #
    output$adlClassPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("classADL1", "classADL2", "classADL3"), ]

      x$INDICATOR <- ifelse(x$INDICATOR == "classADL1", "Independent",
                            ifelse(x$INDICATOR == "classADL2", "Partial\ndependency","Severe\ndependency"))

      x$INDICATOR <- factor(x$INDICATOR, levels = c("Independent",
                                                    "Partial\ndependency",
                                                    "Severe\ndependency"))

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x, aes(x = SET, y = EST, fill = INDICATOR)) +
        geom_col(width = 0.7) +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2))

      chartPlot +
        theme_ram
    })
    #
    # ADL histogram
    #
    output$adlHistPlot <- renderPlot({
      x <- indicatorsDF()

      x$sex1 <- ifelse(x$sex1 == 1, "Males", "Females")

      x$sex1 <- factor(x$sex1, levels = c("Males", "Females"))

      chartPlot <- ggplot(data = x, aes(x = scoreADL)) +
        geom_bar(width = 0.7, fill = "white", colour = "gray70") +
        scale_y_continuous(breaks = seq(from = 0, to = max(table(x$scoreADL)), by = 20)) +
        scale_x_continuous(breaks = seq(from = 0, to = 6, by = 1)) +
        labs(x = "ADL Score", y = "Frequency")

      if(input$groupADLhist == "sex") {
        chartPlot <- chartPlot + facet_wrap( ~ sex1)
      }

      chartPlot +
        theme_ram
    })
    #
    # Kessler 6 table
    #
    output$kesslerTable <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR == "K6", c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Kessler 6 modal
    #
    observeEvent(input$viewKesslerTable, {
      showModal(
        modalDialog(
          title = "Kessler-6 psychological distress score",
          DT::dataTableOutput("kesslerTable"), easyClose = TRUE
        )
      )
    })
    #
    # Kessler 6 plot
    #
    output$kesslerPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR == "K6", ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x, aes(x = SET, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Mean Kessler-6 score") +
        scale_y_continuous(limits = c(0, 24),
                           breaks = seq(from = 0, to = 24, by = 2))

      if(input$errorKessler) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot +
        theme_ram
    })
    #
    # Kessler 6 histogram
    #
    output$kesslerHist <- renderPlot({
      x <- indicatorsDF()

      x$sex1 <- ifelse(x$sex1 == 1, "Males", "Females")

      x$sex1 <- factor(x$sex1, levels = c("Males", "Females"))

      chartPlot <- ggplot(data = x, aes(x = K6)) +
        geom_bar(width = 0.7, fill = "white", colour = "gray70") +
        scale_x_discrete(limits = 0:24,
                         breaks = seq(from = 0, to = 24, by = 2)) +
        labs(x = "Kessler-6 Pyschological Distress Score", y = "Frequency") +
        theme_ram

      if(input$groupKessler == "sex") {
        chartPlot <- ggplot(data = x, aes(x = K6)) +
          geom_bar(width = 0.7, fill = "white", colour = "gray70") +
          scale_x_discrete(limits = 0:24,
                           breaks = seq(from = 0, to = 24, by = 2)) +
          labs(x = "Kessler-6 Pyschological Distress Score", y = "Frequency") +
          facet_wrap( ~ sex1) +
          theme_ram
      }

      chartPlot
    })
    #
    #
    #
    output$kesslerBoxplot<- renderPlot({
      x <- indicatorsDF()

      x$sex1 <- ifelse(x$sex1 == 1, "Males", "Females")

      x$sex1 <- factor(x$sex1, levels = c("Males", "Females"))

      chartPlot <- ggplot(data = x, aes(x = sex1, y = K6)) +
        geom_boxplot(notch = TRUE, width = 0.3, colour = "gray70", size = 1) +
        labs(x = "", y = "Kessler-6 Pyschological Distress Score") +
        scale_y_continuous(limits = c(0, 24), breaks = seq(from = 0, to = 24, by = 2)) +
        theme_ram

      chartPlot
    })
    #
    # Severe psychological distress
    #
    output$severeDistressPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR == "K6Case", ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x, aes(x = SET, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2))

      if(input$errorDistress) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot +
        theme_ram
    })
    #
    # Dementia table
    #
    output$dsTable <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR == "DS", c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Dementia modal
    #
    observeEvent(input$viewDSTable, {
      showModal(
        modalDialog(
          title = "Probable dementia by brief CSID screen",
          DT::dataTableOutput("dsTable"), easyClose = TRUE
        )
      )
    })
    #
    # Dementia plot
    #
    output$dsPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR == "DS", ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x, aes(x = SET, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2))

      if(input$errorDS) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot +
        theme_ram
    })
    #
    # Health-seeking for long-term illness table
    #
    output$healthTable <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("H1", "H2"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Health-seeking for long-termm illness modal
    #
    observeEvent(input$viewHealthTable, {
      showModal(
        modalDialog(
          title = "Health-seeking behaviour for a long-term illness",
          DT::dataTableOutput("healthTable"), easyClose = TRUE
        )
      )
    })
    #
    # Health-seeking for long-term illness plot
    #
    output$healthPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("H1", "H2"), ]

      x$INDICATOR <- ifelse(x$INDICATOR == "H1", "Long term disease\nrequiring regular medication", "Takes medication for\nlong term disease\nrequiring regular medication")

      x$INDICATOR <- factor(x$INDICATOR, levels = c("Long term disease\nrequiring regular medication",
                                                    "Takes medication for\nlong term disease\nrequiring regular medication"))

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2)) +
        theme_ram

      if(input$groupHealth == "sex") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ SET) +
          theme_ram
      }

      if(input$groupHealth == "indicator") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = SET, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ INDICATOR) +
          theme_ram
      }

      if(input$errorHealth) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot
    })
    #
    # Reasons for not taking medication for long-term illness
    #
    output$reasonsTable1 <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("H31", "H32", "H33", "H34", "H35", "H36", "H37", "H38", "H39"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 30)
    )
    #
    # Reasons for not taking medication for long-term illness modal
    #
    observeEvent(input$viewReasonsTable1, {
      showModal(
        modalDialog(
          title = "Reasons for not taking medication for long-term illness requiring regular medication",
          DT::dataTableOutput("reasonsTable1"), easyClose = TRUE
        )
      )
    })
    #
    # Reasons for not taking medication plot
    #
    output$reasonsPlot1 <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("H31", "H32", "H33", "H34", "H35", "H36", "H37", "H38", "H39"), ]

      x$INDICATOR <- ifelse(x$INDICATOR == "H31", "No drugs available",
                       ifelse(x$INDICATOR == "H32", "Too expensive / no money",
                         ifelse(x$INDICATOR == "H33", "Too old to look for care",
                           ifelse(x$INDICATOR == "H34", "Use of traditional medicine",
                              ifelse(x$INDICATOR == "H35", "Drugs don't help",
                                ifelse(x$INDICATOR == "H36", "No one to help me",
                                  ifelse(x$INDICATOR == "H37", "No need",
                                    ifelse(x$INDICATOR == "H38", "Other", "No reason given"))))))))

      x$INDICATOR <- factor(x$INDICATOR, levels = c("No drugs available",
                                                    "Too expensive / no money",
                                                    "Too old to look for care",
                                                    "Use of traditional medicine",
                                                    "Drugs don't help",
                                                    "No one to help me",
                                                    "No need",
                                                    "Other",
                                                    "No reason given"))

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2)) +
        coord_flip() +
        theme_ram

      if(input$groupReasons1 == "sex") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          coord_flip() +
          facet_wrap( ~ SET) +
          theme_ram
      }

      if(input$groupReasons1 == "indicator") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = SET, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          coord_flip() +
          facet_wrap( ~ INDICATOR) +
          theme_ram
      }

      if(input$errorReasons1) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot
    })
    #
    # Health-seeking for recent illness illness table
    #
    output$recentTable <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("H4", "H5"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Health-seeking for recent illness modal
    #
    observeEvent(input$viewRecentTable, {
      showModal(
        modalDialog(
          title = "Health-seeking behaviour for a recent illness",
          DT::dataTableOutput("recentTable"), easyClose = TRUE
        )
      )
    })
    #
    # Health-seeking for recent illness plot
    #
    output$recentPlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("H4", "H5"), ]

      x$INDICATOR <- ifelse(x$INDICATOR == "H4", "Illness in\nthe previous\n2 weeks)", "Accessed care\nfor\nrecent illness")

      x$INDICATOR <- factor(x$INDICATOR, levels = c("Illness in\nthe previous\n2 weeks)", "Accessed care\nfor\nrecent illness"))

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2)) +
        theme_ram

      if(input$groupRecent == "sex") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ SET) +
          theme_ram
      }

      if(input$groupRecent == "indicator") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = SET, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          facet_wrap( ~ INDICATOR) +
          theme_ram
      }

      if(input$errorRecent) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot
    })
    #
    # Reasons for not accessing care for recent illness
    #
    output$reasonsTable2 <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("H61", "H62", "H63", "H64", "H65", "H66", "H67", "H68", "H69"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 30)
    )
    #
    # Reasons for not taking medication for long-term illness modal
    #
    observeEvent(input$viewReasonsTable2, {
      showModal(
        modalDialog(
          title = "Reasons for not accessing care for recent illness",
          DT::dataTableOutput("reasonsTable2"), easyClose = TRUE
        )
      )
    })
    #
    # Reasons for not taking medication plot
    #
    output$reasonsPlot2 <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("H61", "H62", "H63", "H64", "H65", "H66", "H67", "H68", "H69"), ]

      x$INDICATOR <- ifelse(x$INDICATOR == "H61", "No drugs available",
                       ifelse(x$INDICATOR == "H62", "Too expensive / no money",
                         ifelse(x$INDICATOR == "H63", "Too old to look for care",
                           ifelse(x$INDICATOR == "H64", "Use of traditional medicine",
                             ifelse(x$INDICATOR == "H65", "Drugs don't help",
                               ifelse(x$INDICATOR == "H66", "No one to help me",
                                 ifelse(x$INDICATOR == "H67", "No need",
                                   ifelse(x$INDICATOR == "H68", "Other", "No reason given"))))))))

      x$INDICATOR <- factor(x$INDICATOR, levels = c("No drugs available",
                                                    "Too expensive / no money",
                                                    "Too old to look for care",
                                                    "Use of traditional medicine",
                                                    "Drugs don't help",
                                                    "No one to help me",
                                                    "No need",
                                                    "Other",
                                                    "No reason given"))

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2)) +
        coord_flip() +
        theme_ram

      if(input$groupReasons2 == "sex") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          coord_flip() +
          facet_wrap( ~ SET) +
          theme_ram
      }

      if(input$groupReasons2 == "indicator") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = SET, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          coord_flip() +
          facet_wrap( ~ INDICATOR) +
          theme_ram
      }

      if(input$errorReasons2) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot
    })
    #
    # Has income table
    #
    output$incomeTable <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR == "M1", c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 20)
    )
    #
    # Has income modal
    #
    observeEvent(input$viewIncomeTable, {
      showModal(
        modalDialog(
          title = "Has q personal income",
          DT::dataTableOutput("incomeTable"), easyClose = TRUE
        )
      )
    })
    #
    # Income plot
    #
    output$incomePlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR == "M1", ]

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x, aes(x = SET, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2))

      if(input$errorIncome) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot +
        theme_ram
    })
    #
    # Sources of income table
    #
    output$incomeSourceTable <- DT::renderDataTable(
      prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("M2A", "M2B", "M2C", "M2D", "M2E", "M2F", "M2G", "M2H", "M2I"), c("LABEL", "TYPE", "SET", "EST", "LCL", "UCL")],
      rownames = FALSE,
      options = list(scrollX = TRUE, pageLength = 30)
    )
    #
    # Sources of income modal
    #
    observeEvent(input$viewIncomeSourceTable, {
      showModal(
        modalDialog(
          title = "Source of income",
          DT::dataTableOutput("incomeSourceTable"), easyClose = TRUE
        )
      )
    })
    #
    # Sources of income plot
    #
    output$incomeSourcePlot <- renderPlot({
      x <- prettyResultsLong()[prettyResultsLong()$INDICATOR %in% c("M2A", "M2B", "M2C", "M2D", "M2E", "M2F", "M2G", "M2H", "M2I"), ]

      x$INDICATOR <- ifelse(x$INDICATOR == "M2A", "Agriculture / fishing / livestock",
                       ifelse(x$INDICATOR == "M2B", "Wages / salary",
                         ifelse(x$INDICATOR == "M2C", "Sale of charcoal / bricks / etc.",
                           ifelse(x$INDICATOR == "M2D", "Trading (e.g. market or shop)",
                             ifelse(x$INDICATOR == "M2E", "Investments",
                               ifelse(x$INDICATOR == "M2F", "Spending savings\nor sales of assets",
                                 ifelse(x$INDICATOR == "M2G", "Charity",
                                   ifelse(x$INDICATOR == "M2H", "Cash transfer,\nsocial security\nor welfare", "Other source(s) of income"))))))))

      x$INDICATOR <- factor(x$INDICATOR, levels = c("Agriculture / fishing / livestock",
                                                    "Wages / salary",
                                                    "Sale of charcoal / bricks / etc.",
                                                    "Trading (e.g. market or shop)",
                                                    "Investments",
                                                    "Spending savings\nor sales of assets",
                                                    "Charity",
                                                    "Cash transfer,\nsocial security\nor welfare",
                                                    "Other source(s) of income"))

      x$SET <- ifelse(x$SET == "EST.ALL", "All",
                      ifelse(x$SET == "EST.MALES", "Males", "Females"))

      x$SET <- factor(x$SET, levels = c("All", "Males", "Females"))

      chartPlot <- ggplot(x[x$SET == "All", ], aes(x = INDICATOR, y = EST)) +
        geom_col(width = 0.7, fill = "white", colour = "gray70") +
        labs(x = "", y = "Proportion") +
        scale_y_continuous(limits = c(0, 1),
                           breaks = seq(from = 0, to = 1, by = 0.2)) +
        coord_flip() +
        theme_ram

      if(input$groupIncomeSource == "sex") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = INDICATOR, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          coord_flip() +
          facet_wrap( ~ SET) +
          theme_ram
      }

      if(input$groupIncomeSource == "indicator") {
        chartPlot <- ggplot(x[x$SET != "All", ], aes(x = SET, y = EST)) +
          geom_col(width = 0.7, fill = "white", colour = "gray70") +
          labs(x = "", y = "Proportion") +
          scale_y_continuous(limits = c(0, 1),
                             breaks = seq(from = 0, to = 1, by = 0.2)) +
          coord_flip() +
          facet_wrap( ~ INDICATOR) +
          theme_ram
      }

      if(input$errorIncomeSource) {
        chartPlot <- chartPlot +
          geom_errorbar(aes(ymin = LCL, ymax = UCL), width = 0.1, colour = "gray70")
      }

      chartPlot
    })
  })
  #
  ##############################################################################
  #
  # Report
  #
  ##############################################################################
  #
}

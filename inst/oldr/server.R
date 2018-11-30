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
}

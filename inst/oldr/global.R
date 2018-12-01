################################################################################
#
#
#
# This is a Shiny web application to support the implementation of health and
# nutrition coverage surveys in Liberia.
#
# This code is for the global R requirements of the Shiny web application.
#
#
################################################################################


################################################################################
#
# Set-up
#
################################################################################
#
# Load libraries
#
if(!require(shiny)) install.packages("shiny")
if(!require(shinydashboard)) install.packages("shinydashboard")
if(!require(devtools)) install.packages("devtools")
if(!require(magrittr)) install.packages("magrittr")
if(!require(bbw)) install.packages("bbw")
if(!require(shinyjs)) install.packages("shinyjs")
if(!require(maptools)) install.package("maptools")
if(!require(rgdal)) install.packages("rgdal")
if(!require(rgeos)) install.packages("rgeos")
if(!require(raster)) install.packages("raster")
if(!require(leaflet)) install.packages("leaflet")
if(!require(ggmap)) install.packages("ggmap")
if(!require(DT)) install.packages("DT")

if(!require(oldr)) install_github("rapidsurveys/oldr")
if(!require(spatialsampler)) install_github("validmeasures/spatialsampler")
if(!require(odkr)) install_github("validmeasures/odkr")
if(!require(sampsizer)) install_github("validmeasures/sampsizer")
if(!require(gadmr)) install_github("SpatialWorks/gadmr")


countries <- as.list(list_countries$iso3code)
names(countries) <- list_countries$country

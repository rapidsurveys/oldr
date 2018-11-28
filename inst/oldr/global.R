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

if(!require(liberia)) install_github("validmeasures/liberia")
if(!require(spatialsampler)) install_github("validmeasures/spatialsampler")
if(!require(odkr)) install_github("validmeasures/odkr")
if(!require(zscorer)) install_github("nutriverse/zscorer")
if(!require(sampsizer)) install_github("validmeasures/sampsizer")



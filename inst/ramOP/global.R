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
if(!require(tidyr)) install.packages("tidyr")
if(!require(ggplot2)) install.packages("ggplot2")
if(!require(RColorBrewer)) install.packages("RColorBrewer")
if(!require(shinyWidgets)) install.packages("shinyWidgets")

if(!require(oldr)) install_github("rapidsurveys/oldr")
if(!require(spatialsampler)) install_github("validmeasures/spatialsampler")
if(!require(odkr)) install_github("validmeasures/odkr")
if(!require(sampsizer)) install_github("validmeasures/sampsizer")
if(!require(gadmr)) install_github("SpatialWorks/gadmr")


countries <- as.list(list_countries$iso3code)
names(countries) <- list_countries$country


theme_ram <- theme_bw() +
  theme(panel.border = element_rect(colour = "gray70",
                                    size = 0.5),
        panel.grid.major = element_line(linetype = 1,
                                        size = 0.2,
                                        colour = "gray90"),
        panel.grid.minor = element_line(linetype = 0),
        strip.background = element_rect(colour = "gray70",
                                        fill = "gray70"),
        strip.text = element_text(colour = "white", size = 12),
        legend.key = element_rect(linetype = 0),
        axis.title = element_text(size = 12),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.ticks = element_line(colour = "gray70", size = 0.5))

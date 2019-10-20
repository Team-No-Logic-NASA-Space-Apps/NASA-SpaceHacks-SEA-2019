# designedR
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#load libraries
library(shiny)
library(leaflet)
library(dplyr)
library(leaflet.extras)

getwd()
list.files()
setwd("/home/toreshi/school/UW-TAC/Fall-19/NASA Hackathon/mapMergeV2")
list.files()

#dat <- read.csv("US_LosAngeles-LongBeach-SantaAna_SouthLongBeach-EDITED.MYD04.csv", heoder=T")

#data = read.csv("US_LosAngeles-LongBeach-SantaAna_SouthLongBeach.MOD04.csv", header=T)
dat = read.csv("US_LosAngeles-LongBeach-SantaAna_SouthLongBeach.MOD04.csv", header=T)

names(dat)
YYYY = dat$X2000
summary(YYYY)
MM = dat$X2
DD = dat$X24
latitude = dat$X.118.175
longitude = dat$X33.792
AOD1 = dat$X.1.000
AOD3 = dat$X0.216
STD3 = dat$X.1.000.1

#import data
data <- read.csv("query.csv")


#categorize earthquake depth
#data$depth_type <- ifelse(data$depth <= 70, "shallow", ifelse(data$depth <= 300 | data$depth >70, "intermediate", ifelse(data$depth > 300, "deep", "other")))


# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Air Pollution Data in Los Angeles, CA"),
    
    mainPanel( 
        #this will create a space for us to display our map
        leafletOutput(outputId = "mymap"), 
        #this allows me to put the checkmarks ontop of the map to allow people to view earthquake depth or overlay a heatmap
        absolutePanel(top = 60, left = 20
        )
    ))

test = data$mag

# Define server logic required to draw a histogram
server <- function(input, output) {#define the color pallate for the magnitidue of the earthquake
    #create the map
    output$mymap <- renderLeaflet({
        leaflet(data) %>% 
            setView(lng = -118, lat = 34, zoom = 6)  %>% #setting the view over ~ center of North America
            addTiles() %>% 
            #addCircles(data = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(mag)*25000, popup = ~as.character(mag), label = ~as.character(paste0("Magnitude: ", sep = " ", mag)),  fillOpacity = 0.5)
        #addCircles(dat = dat, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(test)*25000, popup = ~as.character(test), label = ~as.character(paste0("Magnitude: ", sep = " ", test)),  fillOpacity = 0.5)
        addCircles(data = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(test)*25000, popup = ~as.character(test), label = ~as.character(paste0("Magnitude: ", sep = " ", test)),  fillOpacity = 0.5)
        
        })
}

# Run the application 
shinyApp(ui, server)

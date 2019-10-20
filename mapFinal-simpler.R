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
setwd("/home/toreshi/school/UW-TAC/Fall-19/NASA Hackathon/earthquakeV24/earthquake")
list.files()

#import data
data <- read.csv("query.csv")


#categorize earthquake depth
data$depth_type <- ifelse(data$depth <= 70, "shallow", ifelse(data$depth <= 300 | data$depth >70, "intermediate", ifelse(data$depth > 300, "deep", "other")))


# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Air Pollution Data in Los Angeles, CA"),
    
    mainPanel( 
        #this will create a space for us to display our map
        leafletOutput(outputId = "mymap"), 
        #this allows me to put the checkmarks ontop of the map to allow people to view earthquake depth or overlay a heatmap
        absolutePanel(top = 60, left = 20, 
                      #checkboxInput("markers", "Depth", FALSE),
                      #checkboxInput("heat", "Heatmap", FALSE)
        )
        
    ))

# Define server logic required to draw a histogram
server <- function(input, output) {#define the color pallate for the magnitidue of the earthquake
    pal <- colorNumeric(
        palette = c('gold', 'orange', 'dark orange', 'orange red', 'red', 'dark red'),
        domain = data$mag)
    
    #define the color of for the depth of the earquakes
    pal2 <- colorFactor(
        palette = c('blue', 'yellow', 'red'),
        domain = data$depth_type
    )
    
    #create the map
    output$mymap <- renderLeaflet({
        leaflet(data) %>% 
            setView(lng = -99, lat = 45, zoom = 2)  %>% #setting the view over ~ center of North America
            addTiles() %>% 
            addCircles(data = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(mag)*25000, popup = ~as.character(mag), label = ~as.character(paste0("Magnitude: ", sep = " ", mag)), color = ~pal(mag), fillOpacity = 0.5)
    })

        
    
}

# Run the application 
shinyApp(ui, server)

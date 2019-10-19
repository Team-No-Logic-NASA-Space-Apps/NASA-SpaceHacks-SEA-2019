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

#import data
data <- read.csv("query.csv")

dat = read.csv("US_LosAngeles-LongBeach-SantaAna_SouthLongBeach.MOD04.csv", header=T)
names(dat)
YYYY = dat$X2000
summary(YYYY)
MM = dat$X2
DD = dat$X24
Latitude = dat$X.118.175
Longitude = dat$X33.792
AOD1 = dat$X.1.000
AOD3 = dat$X0.216
STD3 = dat$X.1.000.1



#categorize earthquake depth
data$depth_type <- ifelse(data$depth <= 70, "shallow", ifelse(data$depth <= 300 | data$depth >70, "intermediate", ifelse(data$depth > 300, "deep", "other")))

dataset = read.csv("query.csv",header=T)


# Define UI for application that draws a histogram
ui <- fluidPage(
    

    # Application title
    titlePanel("Air Pollution Data in Los Angeles, CA"),
    sidebarPanel(
        
        sliderInput('sampleSize', 'Year', min=2000, max=max(YYYY),
                    value=min(2000, nrow(dat)), step=1, round=0),
        
        selectInput('x', 'X', names(dataset)),
        selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
        selectInput('color', 'Color', c('None', names(dataset))),
        
        checkboxInput('jitter', 'Jitter'),
        checkboxInput('smooth', 'Smooth'),
        
        selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
        selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
    ),
    mainPanel( 
        #this will create a space for us to display our map
        leafletOutput(outputId = "mymap"), 
        #this allows me to put the checkmarks ontop of the map to allow people to view earthquake depth or overlay a heatmap
        absolutePanel(top = 60, left = 20, 
                      checkboxInput("markers", "Depth", FALSE),
                      checkboxInput("heat", "Heatmap", FALSE)
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
            setView(lng = -118, lat = 34, zoom = 6)  %>% #setting the view over ~ center of North America
            addTiles() %>% 
            addCircles(data = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(mag)*25000, popup = ~as.character(mag), label = ~as.character(paste0("Magnitude: ", sep = " ", mag)), color = ~pal(mag), fillOpacity = 0.5)
    })
    
    #next we use the observe function to make the checkboxes dynamic. If you leave this part out you will see that the checkboxes, when clicked on the first time, display our filters...But if you then uncheck them they stay on. So we need to tell the server to update the map when the checkboxes are unchecked.
    observe({
        proxy <- leafletProxy("mymap", data = data)
        proxy %>% clearMarkers()
        if (input$markers) {
            proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal2(depth_type), fillOpacity = 0.2,      label = ~as.character(paste0("Magnitude: ", sep = " ", mag))) %>%
                addLegend("bottomright", pal = pal2, values = data$depth_type,
                          title = "Depth Type",
                          opacity = 1)}
        else {
            proxy %>% clearMarkers() %>% clearControls()
        }
    })
    
    observe({
        proxy <- leafletProxy("mymap", data = data)
        proxy %>% clearMarkers()
        if (input$heat) {
            proxy %>%  addHeatmap(lng=~longitude, lat=~latitude, intensity = ~mag, blur =  10, max = 0.05, radius = 15) 
        }
        else{
            proxy %>% clearHeatmap()
        }
        
        
    })
    
}

# Run the application 
shinyApp(ui, server)

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
library(ggplot2)

getwd()
list.files()
setwd("/home/toreshi/school/UW-TAC/Fall-19/NASA Hackathon/mapMergeV2")
list.files()

#data <- read.csv("US_LosAngeles-LongBeach-SantaAna_SouthLongBeach-EDITED.MYD04.csv", header=T)

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
    sidebarPanel(
        
        plot(YYYY, AOD3)
        #hist(YYYY, AUD3)
        #hist(x[y==0], col="dodgerblue", breaks=5, ylim=c(0,0.04),
             #xlim=c(0,100), main=title0, xlab="Percentage", ylab="Rel. Freq.", prob=T)
        ),
    mainPanel( 
        #this will create a space for us to display our map
        leafletOutput(outputId = "mymap"), 
        #this allows me to put the checkmarks ontop of the map to allow people to view earthquake depth or overlay a heatmap
        absolutePanel(top = 60, left = 20
        #plot(YYYY, AOD3)
        
    )
    ))

test = data$mag

# Define server logic required to draw a histogram
server <- function(input, output) {#define the color pallate for the magnitidue of the earthquake
    p1 = qplot(YYYY, AOD3, data = dat,
               xlab = 'Car weight', ylab = 'Mileage')
    print(p1)
    #create the map
    output$mymap <- renderLeaflet({
        leaflet(dat) %>% 
            setView(lng = -118, lat = 34, zoom = 10)  %>% #setting the view over ~ center of North America
            #setView(lng = 0, lat = 0, zoom = 6)  %>% #setting the view over ~ center of North America
            
            addTiles() %>% 
            #addCircles(data = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(mag)*25000, popup = ~as.character(mag), label = ~as.character(paste0("Magnitude: ", sep = " ", mag)),  fillOpacity = 0.5)
        #addCircles(dat = dat, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(test)*25000, popup = ~as.character(test), label = ~as.character(paste0("Magnitude: ", sep = " ", test)),  fillOpacity = 0.5)
        #addCircles(data = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(test)*25000, popup = ~as.character(test), label = ~as.character(paste0("Magnitude: ", sep = " ", test)),  fillOpacity = 0.5)
        #addCircles(dat = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = 30000, popup = ~as.character(mag), label = ~as.character(paste0("Magnitude: ", sep = " ", mag)),  fillOpacity = 0.5)
        #addCircles(data = dat, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = 30000, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
        
            #addCircles(data = dat, lat = 0, lng = 0, weight = 1, radius = 100000, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
            #addCircles(data = dat,  lat = ~ longitude, lng = ~ latitude, weight = 1, radius = 100000, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
            addCircles(data = dat,  lat = ~ longitude, lng = ~ latitude, weight = 1, radius = ~sqrt(test)*100, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
            #addCircles(data = dat,  lat = ~ longitude, lng = ~ latitude, weight = 1, radius = ~sqrt(test)*100, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
            
        })
}

# Run the application 
shinyApp(ui, server)

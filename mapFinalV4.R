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

#datAir = read.csv("AirQualitySystem.csv", header=T)

names(dat)
#localTime_AIR = datAir$Time.Local
#parameterName_AIR = as.character(dat$Parameter.Name)
#latitude_AIR = datAir$Latitude
##longitude_AIR = datAir$Longitude
#measurement_AIR = datAir$Sample.Measurement


#for(i in seq(from=1, 10, by=1)) {
#print(paste("i is ", i))

#pollutionMeanArray[i] <- mean(AOD3[YYYY==(2000 + i) & MM >= 0 & MM < 12])
#pollutionMeanArray[i]
#pollutionMeanArray[i + 1] <- 1
#}


#categorize earthquake depth
#data$depth_type <- ifelse(data$depth <= 70, "shallow", ifelse(data$depth <= 300 | data$depth >70, "intermediate", ifelse(data$depth > 300, "deep", "other")))

############################################ POLLUTION #######################################################################
pDat <- read.csv("mapData.csv")
names(pDat)

# plot year, parameter, sample measurement
# Title: "Poulution of [Parameter.name]"
carbonMonoxideData <- NA
nitrogenDioxideData <- NA
ozoneData <- NA
sulfurDioxideData <- NA

#scatter.smooth(year, pollutionMeanArray)







###############################################################################################################################


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Air Pollution Data in Los Angeles, CA"),
  # sidebarPanel(
  
  #    plot(YYYY, AOD3)
  #hist(YYYY, AUD3)
  #hist(x[y==0], col="dodgerblue", breaks=5, ylim=c(0,0.04),
  #xlim=c(0,100), main=title0, xlab="Percentage", ylab="Rel. Freq.", prob=T)
  #   ),
  #mainPanel( 
    #this will create a space for us to display our map
   # fluidRow(
    #  splitLayout(cellWidths = c("33%", "33%", "33%"), leafletOutput(outputId = "mymap"), sidebarPanel (
    #    checkboxInput("markers", "Carbon Monoxide", TRUE),
    #    checkboxInput("markers", "Nitrogen Dioxide", FALSE),
    #    checkboxInput("markers", "Ozone", FALSE),
    #    checkboxInput("markers", "Sulfur Dioxide", FALSE)
        
        
     #   ), plotOutput("phonePlot")
                  
    #  )
    #) 
#  )
  
  mainPanel( 
    #this will create a space for us to display our map
    fluidRow(
      #splitLayout(cellWidths = c("50%", "50%"), leafletOutput(outputId = "mymap"), plotOutput("phonePlot")
      #splitLayout(cellWidths = c("33%", "33%", "33%"), leafletOutput(outputId = "mymap"), checkboxInput("markers", "Depth", FALSE), plotOutput("phonePlot")
      splitLayout(cellWidths = c("33%", "33%", "33%"), leafletOutput(outputId = "mymap"), sidebarPanel (
        checkboxInput("markers", "Carbon Monoxide", TRUE),
        checkboxInput("markers", "Nitrogen Dioxide", FALSE),
        checkboxInput("markers", "Ozone", FALSE),
        checkboxInput("markers", "Sulfur Dioxide", FALSE)
        
        
      ), plotOutput("phonePlot"))
    ) 
  )

)

test = data$mag

# Define server logic required to draw a histogram
server <- function(input, output) {#define the color pallate for the magnitidue of the earthquake
  set.seed(1234)
  #p1 = qplot(YYYY, AOD3, data = dat,
  #           xlab = 'Car weight', ylab = 'Mileage')
  #print(p1)
  #create the map
  output$mymap <- renderLeaflet({
    leaflet(dat) %>% 
      setView(lng = -118, lat = 34, zoom = 10)  %>% #setting the view over ~ center of North America
      #setView(lng = 0, lat = 0, zoom = 6)  %>% #setting the view over ~ center of North America
      
      addTiles() %>% 
      #  for(i in seq(from=1, to=10, by=1)) {
      #print(paste("i is ", i))
      
      #pollutionMeanArray[i] <- mean(AOD3[YYYY==(2000 + i) & MM >= 0 & MM < 12])
      #pollutionMeanArray[i]
      #pollutionMeanArray[i + 1] <- 1
      #addCircles(data = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(mag)*25000, popup = ~as.character(mag), label = ~as.character(paste0("Magnitude: ", sep = " ", mag)),  fillOpacity = 0.5)
      #addCircles(dat = dat, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(test)*25000, popup = ~as.character(test), label = ~as.character(paste0("Magnitude: ", sep = " ", test)),  fillOpacity = 0.5)
      #addCircles(data = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(test)*25000, popup = ~as.character(test), label = ~as.character(paste0("Magnitude: ", sep = " ", test)),  fillOpacity = 0.5)
      #addCircles(dat = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = 30000, popup = ~as.character(mag), label = ~as.character(paste0("Magnitude: ", sep = " ", mag)),  fillOpacity = 0.5)
      #addCircles(data = dat, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = 30000, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
    
    #addCircles(data = dat, lat = 0, lng = 0, weight = 1, radius = 100000, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
    #addCircles(data = dat,  lat = ~ longitude, lng = ~ latitude, weight = 1, radius = 100000, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
    #addCircles(data = dat,  lat = ~ longitude, lng = ~ latitude, weight = 1, radius = ~sqrt(test)*100, popup = ~as.character(AOD3), label = ~as.character(paste0("Chemical: ", sep = " ", AOD3)),  fillOpacity = 0.5)
    addCircles(data = dat,  lat = ~ longitude, lng = ~ latitude, weight = 1, radius = ~sqrt(test)*100, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
    #  addCircles(data = dat,  lat = ~ longitude_AIR, lng = ~ latitude_AIR, weight = 1, radius = ~sqrt(measurement_AIR + 15)*100, popup = ~as.character(measurement_AIR), label = ~as.character(paste0("Chemical: ", sep = " ", measurement_AIR)),  fillOpacity = 0.5)
    
    #}
    #pt1 <- reactive({
    #  barplot(carbonMonoxideData,names.arg=year,xlab="Local Time",ylab="pollution (ppm)",col="blue",
    #           main="Carbon Monoxide Pollution in LA",border="red")
  })
  
  output$mymap <- renderLeaflet({
    leaflet(dat) %>% 
      setView(lng = -118, lat = 34, zoom = 10)  %>% #setting the view over ~ center of North America
      #setView(lng = 0, lat = 0, zoom = 6)  %>% #setting the view over ~ center of North America
      
      addTiles() %>% 
      #  for(i in seq(from=1, to=10, by=1)) {
      #print(paste("i is ", i))
      
      #pollutionMeanArray[i] <- mean(AOD3[YYYY==(2000 + i) & MM >= 0 & MM < 12])
      #pollutionMeanArray[i]
      #pollutionMeanArray[i + 1] <- 1
      #addCircles(data = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(mag)*25000, popup = ~as.character(mag), label = ~as.character(paste0("Magnitude: ", sep = " ", mag)),  fillOpacity = 0.5)
      #addCircles(dat = dat, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(test)*25000, popup = ~as.character(test), label = ~as.character(paste0("Magnitude: ", sep = " ", test)),  fillOpacity = 0.5)
      #addCircles(data = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = ~sqrt(test)*25000, popup = ~as.character(test), label = ~as.character(paste0("Magnitude: ", sep = " ", test)),  fillOpacity = 0.5)
      #addCircles(dat = data, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = 30000, popup = ~as.character(mag), label = ~as.character(paste0("Magnitude: ", sep = " ", mag)),  fillOpacity = 0.5)
      #addCircles(data = dat, lat = ~ latitude, lng = ~ longitude, weight = 1, radius = 30000, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
    
    #addCircles(data = dat, lat = 0, lng = 0, weight = 1, radius = 100000, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
    #addCircles(data = dat,  lat = ~ longitude, lng = ~ latitude, weight = 1, radius = 100000, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
    #addCircles(data = dat,  lat = ~ longitude, lng = ~ latitude, weight = 1, radius = ~sqrt(test)*100, popup = ~as.character(AOD3), label = ~as.character(paste0("Chemical: ", sep = " ", AOD3)),  fillOpacity = 0.5)
    addCircles(data = dat,  lat = ~ longitude, lng = ~ latitude, weight = 1, radius = ~sqrt(test)*10000, popup = ~as.character(AOD3), label = ~as.character(paste0("Magnitude: ", sep = " ", AOD3)),  fillOpacity = 0.5)
    #  addCircles(data = dat,  lat = ~ longitude_AIR, lng = ~ latitude_AIR, weight = 1, radius = ~sqrt(measurement_AIR + 15)*100, popup = ~as.character(measurement_AIR), label = ~as.character(paste0("Chemical: ", sep = " ", measurement_AIR)),  fillOpacity = 0.5)
    
    #}
    #pt1 <- reactive({
    #  barplot(carbonMonoxideData,names.arg=year,xlab="Local Time",ylab="pollution (ppm)",col="blue",
    #           main="Carbon Monoxide Pollution in LA",border="red")
    
    
  })
  ############################################ POLLUTION PLOTTING CODE #######################################################################
  pDat <- read.csv("mapData.csv")
  names(pDat)
  
  # plot year, parameter, sample measurement
  # Title: "Poulution of [Parameter.name]"
  
  year = c("1/1/18: 0:00", "1/2/18: 0:00")
  carbonMonoxideData = c(0.5, 0.3)
  nitrogenDioxideData = c(11.9, 9.4)
  ozoneData = c(0.017, 0.021)
  sulfurDioxideData = c(0.2, 0.2)
  # Create the data for the chart
  #M <- c("Mar","Apr","May","Jun","Jul")
  
  # Give the chart file a name
  #png(file = "barchart_months_revenue.png")
  
  # Plot the bar chart 
  lifePlotC <- barplot(carbonMonoxideData,names.arg=year,xlab="Local Time",ylab="pollution (ppm)",col="blue",
                       main="Carbon Monoxide Pollution in LA",border="red")
  
  lifePlotNO2 <- barplot(nitrogenDioxideData,names.arg=year,xlab="Local Time",ylab="pollution (ppm)", ylim = c(0, 15), col="blue",
                        main="Nitrogen Dioxide Pollution in LA",border="red")
  
  #lifePlotO2 <- barplot(ozoneData,names.arg=year,xlab="Local Time",ylab="pollution (ppm)", ylim = c(0, 0.025), col="blue",
  #                      main="Ozone Pollution in LA",border="red")
  
  #lifePlotSO2 <- barplot(sulfurDioxideData,names.arg=year,xlab="Local Time",ylab="pollution (ppm)",col="blue", 
  #                       main="Sulfur Dioxide Pollution in LA",border="red")
  
  #barplot(lifePlotNO2)
  
  ########################################################################################################################################
  
  # Fill in the spot we created for a plot
  output$phonePlot <- renderPlot ({
    # Render a barplot
    barplot(carbonMonoxideData,names.arg=year,xlab="Local Time",ylab="pollution (ppm)",col="blue",
            main="Carbon Monoxide Pollution in LA",  ylim = c(0, 0.6), border="red")
    #barplot(lifePlotC)
    })
  
  output$phonePlot2 <- renderPlot({
    # Render a barplot
    barplot(nitrogenDioxideData,names.arg=year,xlab="Local Time",ylab="pollution (ppm)", ylim = c(0, 15), col="blue",
            main="Nitrogen Dioxide Pollution in LA",border="red")
    #barplot(lifePlotC)
  })
  
}

# Run the application 
shinyApp(ui, server)
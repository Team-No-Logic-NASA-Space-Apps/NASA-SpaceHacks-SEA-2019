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

plot(YYYY, mean(AOD3))

# group years, take an average.
## do by month

year = 2000:2019

# ar = c(YYYY[2000:2019])
ar = array(YYYY[2000:2019])

pollution2000 = mean(AOD3[YYYY==2000 & MM >= 0 & MM < 12])
pollution2001 = mean(AOD3[YYYY==2001 & MM >= 0 & MM < 12])
pollution2002 = mean(AOD3[YYYY==2002 & MM >= 0 & MM < 12])
pollution2003 = mean(AOD3[YYYY==2003 & MM >= 0 & MM < 12])
pollutionSeq2 = c(pollution2000, pollution2001, pollution2002, pollution2003)
plot(YYYY[2000:2003], pollutionSeq2, las = 1)


pollutionSeq = c(pollution2000, pollution2001)
plot(YYYY[2000:2001], pollutionSeq, las = 1, xlim=c(2000, 2001))
plot(YYYY[2000:2001], pollutionSeq, las = 1)

pollution2000


pollution2019Seq = AOD3[YYYY==2019 & MM >= 0 & MM < 12]
pollution2019Seq

pollution2019 = mean(AOD3[YYYY==2019 & MM >= 0 & MM < 12])
pollution2019

A <- array(1: 24, dim = c(3, 4, 2))


mat<-matrix(list(), nrow=20, ncol=12)


pollutionMean <- array(mean(AOD3[YYYY==2000:2019 & MM >= 0 & MM < 12]))
plot(year, )
mean(x[y==0])

for (i in c(1,5)){
  print(paste("The year is", year))
}

for(i in seq(from=10, to=20, by=1)) {
  print(paste("The year is", i))
  
}

a <- c(4, 6, 8) 
a[5] <- 9 
a

testAr <- c(NA)
testAr[5] <- 9 
testAr 

#pollutionMeanArray <- NA 
#pollutionMeanArray 
#pollutionMeanArray[5] <- 9 
#pollutionMeanArray 


pollutionMeanArray <- NA
pollutionMeanArray[1] <-  5
pollutionMeanArray

for(i in seq(from=0, to=19, by=1)) {
  print(paste("i is ", i))
  
  pollutionMeanArray[i + 1] <- mean(AOD3[YYYY==(2000 + i) & MM >= 0 & MM < 12])
  #pollutionMeanArray[i]
  #pollutionMeanArray[i + 1] <- 1
}
pollutionMeanArray
year = 2000:2019
#plot(year, pollutionMeanArray)
scatter.smooth(year, pollutionMeanArray)

relation <- lm(year~pollutionMeanArray)

result <-  predict(relation,50)
mean(AOD3[YYYY==(2000) & MM >= 0 & MM < 12])
mean(AOD3[YYYY==(2001) & MM >= 0 & MM < 12])




list.var<-list(vector.char, matrix.numeric, dataframe.var)

dataframe.var<-data.frame(cbind(School=1, ID=1:5, Test=c("math","read","math","geo","hist")))
dataframe.var


#data <- read.csv("US_LosAngeles-LongBeach-SantaAna_SouthLongBeach-EDITED.MYD04.csv", header=T)

#data = read.csv("US_LosAngeles-LongBeach-SantaAna_SouthLongBeach.MOD04.csv", header=T)
datAir = read.csv("AirQualitySystem.csv", header=T)

names(datAir)




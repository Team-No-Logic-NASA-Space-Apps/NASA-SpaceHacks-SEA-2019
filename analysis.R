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




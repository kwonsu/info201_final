library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)

source("./script/sujin.R")

marvel.data <- read.csv("data/marvel-wikia-data.csv")
dc.data <- read.csv("data/dc-wikia-data.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  output$circularPlot <- renderPlotly({
    char_selected <- input$char
    return(GenderCharacteristic(marvel.data,char_selected))
  })
})
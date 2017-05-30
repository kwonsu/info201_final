
library(plotly)
library(dplyr)

source("./script/sujin.R")

marvel.data <- read.csv("data/marvel-wikia-data.csv")
dc.data <- read.csv("data/dc-wikia-data.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  output$circular <- renderPlotly({
    char_selected <- input$char
    p <- GenderCharacteristic(marvel.data,char_selected)
    return(p)
  })
})
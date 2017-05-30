library(shiny)
library(plotly)
library(ggplot2)

source("./script/sujin.R")
# Define UI for random distribution application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Gender vs Characteristic"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("char", "Characteristic type:",
                   c("Good Character" = "Good",
                     "Bad Character" = "Bad",
                     "Neutral Character" = "Neutral")
      )
    ),
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Plot", plotOutput("circularPlot")), 
                  tabPanel("Summary", verbatimTextOutput("summary"))
      )
    )
  )
))


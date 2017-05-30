library(shiny)
library(plotly)

# Define UI for random distribution application 
fluidPage(
  
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
                  tabPanel("Plot", plotOutput("circular")), 
                  tabPanel("Summary", verbatimTextOutput("summary"))
      )
    )
  )
)

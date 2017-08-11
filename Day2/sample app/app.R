#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define UI for application
ui <- fluidPage(
  
  titlePanel("This is my title"),
  
  # Add some layout elements to the fluidPage 
  navlistPanel(
    tabPanel("Tab 1",
             h2("HTML elements"),
             p("This is a paragraph"),
             tags$ul(tags$li("Bullet 1")),
             checkboxInput("check1","True/False"),
             plotOutput("awesomePlot1"))
  )
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  # Use render* objects to process settings from widgets and change an output element 
  output$awesomePlot1 <- renderPlot({
    ggplot(mpg, aes(displ, hwy)) +  geom_point()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)


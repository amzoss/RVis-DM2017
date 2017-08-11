#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(shiny)

elnino <- read_csv("elnino.csv", na=c(".",NA), 
                   col_types = cols(Date = col_date(format="%y%m%d"))) %>% 
  type_convert()


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("El Niño Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        sliderInput("daterange", 
                    "Range of years", 
                    min = min(elnino$Year), 
                    max = max(elnino$Year), 
                    value = c(min(elnino$Year),max(elnino$Year)), 
                    step = 1)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
 output$distPlot <- renderPlot({
   ggplot(elnino) + 
     geom_histogram(aes(x=Date), binwidth = (input$daterange[2]-input$daterange[1])*10) + 
     scale_x_date(limits = c(as.Date(paste0("19",input$daterange[1],"-01-01")),
                             as.Date(paste0("19",input$daterange[2],"-01-01"))))
   })
}

# Run the application 
shinyApp(ui = ui, server = server)


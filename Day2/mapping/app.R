#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Projections Exercise"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         selectInput(
           "proj",
           label="Projection",
           choices=list("Mercator"="mercator",
                        "Sinusoidal"="sinusoidal",
                        "Azequalarea"="azequalarea"),
           selected=1
         )
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  county_map <- map_data("county","california")
  
  county_map <- county_map %>% group_by(subregion) %>% mutate(rand = runif(1))
  
   output$distPlot <- renderPlot({
     ggplot(county_map) + 
       geom_polygon(aes(x = long,
                        y = lat,
                        group=group,
                        fill=rand)) +
       coord_map(projection = input$proj)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)


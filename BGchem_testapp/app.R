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

#Load data from arctic data center
data_url<-"https://arcticdata.io/metacat/d1/mn/v2/object/urn%3Auuid%3A35ad7624-b159-4e29-a700-0c0770419941"
bg_chem <- read.csv(url(data_url, method = "libcurl"), stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Water biogeochemistry"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("depth",
                        "Depth range:",
                        min = 0,
                        max = 500,
                        value = c(1,60)),
            selectInput("Yaxis", 
                        "Y axis variable:",
                        choices=names(bg_chem), selected = names(bg_chem)[1])
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("Plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$Plot <- renderPlot({
        Yaxis<-sym(input$Yaxis)
        ggplot(bg_chem, aes(x=CTD_Depth, y=!!Yaxis))+
            geom_point(size=4, color="darkorchid4", alpha=0.5)+
            coord_cartesian(xlim = c(min(input$depth), max(input$depth)))+
            theme_bw()+
            theme(panel.grid=element_blank(), text = element_text(size=16))
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

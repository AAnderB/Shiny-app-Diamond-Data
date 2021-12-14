#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyWidgets)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    setBackgroundColor(
        color = c("grey", "black"),
        gradient = "linear",
        direction = "top"
    ),
    h1(id="big-heading", "Diamond Data Exploration-"),
    tags$style(HTML("#big-heading{color: green;}")),
    
    titlePanel(" Am I paying too much?"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h6("NOTE: The first 3 toggle switches control the left plot, the 4th controls both plots and the last controls only the right plot"),
                        tags$style(HTML("#big-heading{color: green;}")),
            sliderInput("xbins",
                        "Volume Range Selection",
                        min = 1,
                        max = 500,
                        value = c(78,500)),
            sliderInput("ybins",
                        "Price Range Selection",
                        min = 1,
                        max = 10000,
                        value = c(3103,9105)),
            sliderInput("alpha2",
                        "Transparency Control (Left Plot)",
                        min = 0,
                        max = .5,
                        value = .395),
            selectInput("Facet",
                        "Faceting variable",
                        choices = c("clarity","color","cut"),
                        selected = "clarity"),
            sliderInput("alpha1",
                        "Transparency Control (Right Plot)",
                        min = 0,
                        max = 1,
                        value = .02)
            ),
        
        # Show a plot of the generated distribution
        mainPanel(tabsetPanel(
            tabPanel("plots",
                     fluidRow(
                         splitLayout(cellWidths = c("50%", "50%"), plotOutput("distPlot"), plotOutput("distPlot2")))
                     )),
            tabPanel("Summary",  verbatimTextOutput("summary"))
        )
    )
    
))



    




#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
data<-diamonds

data<-data%>%mutate(volume= data$x*data$y*data$z)


data<-data%>%filter(data$volume<1000)
data<-data%>%mutate(volume1= volume*volume)

data$Carat_Category <- cut(data$carat, 
                           breaks=c(0, 1, 2, 3, Inf), 
                           labels=c("Small","Medium","Large","Extra-Large"))


library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x_limits <- input$xbins
        y_limits <- input$ybins
        facet<- input$Facet

        # draw the histogram with the specified number of bins
        y_breaks<-seq(0, 150000, by=1500)
        
        data%>%ggplot(aes(x=volume,y=price,color=Carat_Category,alpha=.5))+
            geom_point() + 
            scale_x_continuous(breaks = c(100,200,300,400,500), limits = c(x_limits)) +
            scale_y_continuous(breaks = y_breaks, limits = c(y_limits)) + 
            facet_grid(facet) + 
            theme_dark() + 
            ggtitle("Diamonds Cost by Volume",subtitle = paste("Faceted by",input$Facet)) +
            xlab("Volume in Milimeter") + ylab("Cost in USD")+
            theme(plot.background = element_rect(fill = "gray"),legend.background = element_rect(fill = "darkgray"))
        
        
    })
    output$distPlot2 <- renderPlot({
        data%>%ggplot(aes(x=Carat_Category,y=data$price))+geom_jitter(alpha=.05)+
            geom_half_boxplot(color="blue",alpha=.2,width=.5)+
            geom_half_violin(color="green",alpha=.5,side = "r") + 
            facet_wrap(input$Facet,ncol=2)+
            theme_dark() + 
            ggtitle("Diamonds Cost Distribution",subtitle = paste("by",input$Facet))+ 
            labs(caption = "carat categories: Small = carat<=1 & carat>0, Medium = carat<=2 & carat>1, \n Large = carat<=3 & carat>2, Extra-Large = carat>3") +
            xlab("Carat Size by Category") +
            ylab("Cost in USD")+
            theme(plot.background = element_rect(fill = "gray"))
        
        
    })


})



scale_color_brewer(palette = "Dark2")


scale_colour_gradient(
    low = "green",
    high = "orange",
    space = "Lab",
    na.value = "grey50",
    guide = "colourbar",
    aesthetics = "colour"
)


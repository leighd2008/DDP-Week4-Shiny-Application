#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(data.table)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   ds <- as.data.table(CO2)
   ds <- ds[, ':='(comb=paste(Type, "-", Treatment))]
   qbc <- ds[Type == "Quebec"]
   msp <- ds[Type == "Mississippi"]
   mspch <- msp[Treatment == "chilled"]
   mspnonch <- msp[!Treatment == "chilled"]
   qbcch <- qbc[Treatment == "chilled"]
   qbcnonch <- qbc[!Treatment == "chilled"]
   
# Fits for each location-treatment combination   
   mspchfit= lm(uptake~conc ,data=ds[comb == "Mississippi - chilled"])
   mspnonchfit= lm(uptake~poly(conc ,4) ,data=mspnonch)
   qbcchfit= lm(uptake~poly(conc ,4) ,data=qbcch)
   qbcnonchfit= lm(uptake~poly(conc ,5) ,data=qbcnonch)
   
  output$plot1 <- renderPlot({
    
    # Plot CO2 uptake versus CO2 concentration
     if(input$location == 3){
          g <- ggplot(ds, aes(x = conc, y = uptake, size = 2)) +
               theme_bw() + guides(size = FALSE) + geom_point(aes(color = comb))
          g <- g + geom_smooth(method = "lm", lwd = 2, se = FALSE,
               data = ds[comb == "Mississippi - chilled"],  color="salmon") +
               
               
               
               
               
               geom_smooth(aes(conc, uptake), method = "lm", 
                    ds[comb =="Mississippi - nonchilled"],lwd = 2, se = FALSE) + 
               geom_smooth(aes(conc, uptake), method = "lm", 
                    ds[comb == "Quebec - chilled"], lwd = 2, se = FALSE) +
               geom_smooth(aes(conc, uptake), method = "lm", 
                    ds[comb == "Quebec - nonchilled"], lwd = 2, se = FALSE)
          g
     }else{
          if(input$location == 2){
               g <- ggplot(msp, aes(x = conc, y = uptake, size = 2)) +
                    theme_bw() + guides(size = FALSE)
               g <- g + geom_point(aes(color = Treatment)) + 
                         geom_smooth(aes(conc, uptake), method = "lm", mspch,
                                     color = "turquoise3", lwd = 2, se = FALSE) +
                         geom_smooth(aes(conc, uptake), method = "lm", mspnonch,
                                     color = "salmon", lwd = 2, se = FALSE)
               g
          }else{
          if(input$location == 1){
               g <- ggplot(qbc, aes(x = conc, y = uptake, size = 2)) +
                    theme_bw() + guides(size = FALSE)
               g <- g + geom_point(aes(color = Treatment, 
                                     scale_color_manual(values = cbPallet))) + 
                         geom_smooth(aes(conc, uptake), method = "lm", qbcch,
                                     color = "turquoise3", lwd = 2, se = FALSE) +
                         geom_smooth(aes(conc, uptake), method = "lm", qbcnonch,
                                     color = "salmon", lwd = 2, se = FALSE)
               g
          }
          }
     }
     
  })
  
})




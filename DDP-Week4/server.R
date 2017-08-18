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
library(dplyr)

# Define server logic required to draw plot
shinyServer(function(input, output) {
     #Get data, create column combining location and treatment
   ds <- as.data.table(CO2)
   ds <- ds[, ':='(comb=paste(Type, "-", Treatment))]
   
   ## Create a 4 color mini palatte
   gg_color_hue <- function(n){
        hues = seq(15, 375, length = n + 1)
        hcl(h = hues, l = 65, c = 100)[1:n]
   }
   cols <- gg_color_hue(4)
   cols2 <- cols[3:4]
   
## Fits for each location-treatment combination were defined outside of the shiny
## app using polynomial regression  
   mspchfit= lm(uptake~conc ,data=ds[comb == "Mississippi - chilled"])
   mspnonchfit= lm(uptake~poly(conc ,4) ,data=ds[comb == "Mississippi - nonchilled"])
   qbcchfit= lm(uptake~poly(conc ,4) , data=ds[comb == "Quebec - chilled"])
   qbcnonchfit= lm(uptake~poly(conc ,5) , data=ds[comb == "Quebec - nonchilled"])
   
   model1pred <- reactive({
     CO2Input <- input$sliderCO2
     predict(mspchfit, newdata = data.frame(conc = CO2Input))
   })
   model2pred <- reactive({
     CO2Input <- input$sliderCO2
     predict(mspnonchfit, newdata = data.frame(conc = CO2Input))
   })
   model3pred <- reactive({
     CO2Input <- input$sliderCO2
     predict(qbcchfit, newdata = data.frame(conc = CO2Input))
   })
   model4pred <- reactive({
     CO2Input <- input$sliderCO2
     predict(qbcnonchfit, newdata = data.frame(conc = CO2Input))
   })
   
  output$plot1 <- renderPlot({
    
    # Plot CO2 uptake versus CO2 concentration
     if(input$location == 3){
          g <- ggplot(ds, aes(x = conc, y = uptake, color = comb, size =2)) +
               theme_bw() + guides(size = FALSE) + geom_point() 
               
          g <- g + 
               geom_smooth(method = "lm", formula = y ~ x, lwd = 2, 
                    se = FALSE, color = cols[1], 
                    data = filter(ds, comb == "Mississippi - chilled")) +
               geom_smooth(method = "lm", formula = y ~ poly(x, 4), lwd = 2, 
                    se = FALSE, color = cols[2],  
                    data = filter(ds, comb == "Mississippi - nonchilled")) +
               geom_smooth(method = "lm", formula = y ~ poly(x, 4), lwd = 2, 
                    se = FALSE, color = cols[3],  
                    data = filter(ds, comb == "Quebec - chilled")) +
               geom_smooth(method = "lm", formula = y ~ poly(x, 5), lwd = 2, 
                    se = FALSE, color = cols[4], 
                    data = filter(ds, comb == "Quebec - nonchilled"))
          g
     }else{
          if(input$location == 1){
               g <- ggplot(data = filter(ds, Type == "Mississippi"), 
                    aes(x = conc, y = uptake, color = comb, size =2)) + 
                    theme_bw() + guides(size = FALSE) + geom_point() 
               g <- g + 
                    geom_smooth(method = "lm", formula = y ~ x, lwd = 2, 
                         se = FALSE, color = cols[1],  
                         data = filter(ds, comb == "Mississippi - chilled")) +
                    geom_smooth(method = "lm", formula = y ~ poly(x, 4), 
                         lwd = 2, se = FALSE, color = cols[3],  
                         data = filter(ds, comb == "Mississippi - nonchilled"))
               g
          }else{
          if(input$location == 2){
               g <- ggplot(data = filter(ds, Type == "Quebec"), 
                    aes(x = conc, y = uptake, color = comb, size =2)) + 
                    theme_bw() + guides(size = FALSE) + geom_point() 
               g <- g + 
                    geom_smooth(method = "lm", formula = y ~ poly(x, 4), lwd = 2, 
                         se = FALSE, color = cols[1],  
                         data = filter(ds, comb == "Quebec - chilled")) +
                    geom_smooth(method = "lm", formula = y ~ poly(x, 5), 
                         lwd = 2, se = FALSE, color = cols[3],  
                         data = filter(ds, comb == "Quebec - nonchilled"))
               g
          }
          }
     }
     
  })
  output$pred1 <- renderText({
    model1pred()
  })
  output$pred2 <- renderText({
    model2pred()
  })
  output$pred3 <- renderText({
    model3pred()
  })
  output$pred4 <- renderText({
    model4pred()
  })
  
})




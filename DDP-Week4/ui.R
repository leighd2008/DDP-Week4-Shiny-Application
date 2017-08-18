#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that explores CO2 uptake data from plants.
shinyUI(fluidPage(
  
  # Application title
  titlePanel("CO2 Uptake by plants"),
  
  # Sidebar with radio buttons to choose location of plant(Quebec or Mississippi) 
  sidebarLayout(
    sidebarPanel(
      radioButtons("location", label = 
        h3("Choose to see the data from Quebec, Mississippi or Both together."),
        choices = list("Quebec"= 1, "Mississippi"= 2, "Both"= 3), selected = 3),
     h3("Lines"),
     helpText("The line represent the best polynomial regression fit for each 
               location - treatment combination. This will allow us to predict 
               an uptake value for a given ambient concentration of CO2 on the 
               Predict tab.")
     ),
    
     # Show a plot of the CO2 data.
    mainPanel(
         tabsetPanel(type = "tabs",
                     tabPanel("Exploratory Plots", br(), plotOutput("plot1")),
                     tabPanel("Predict", br(), textOutput("out2"))
         )
    )
    
  )
))

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
navbarPage("Carbon Dioxide Uptake in Grass Plants",
   tabPanel("Exploratory Plots",
      # Sidebar with radio buttons to choose location of plant(Quebec or Mississippi) 
      sidebarLayout(
         sidebarPanel(
            radioButtons("location", label = 
               h3("Choose to see the data from Mississippi, Quebec or Both together."),
                  choices = list("Mississippi"= 1,"Quebec"= 2,  "Both"= 3), selected = 3),
               h3("Lines"),
               helpText("The lines represent the best polynomial regression fit for each 
                  location - treatment combination. This will allow us to predict 
                  an uptake value for a given ambient concentration of CO2 on the 
                  Predict tab.")
         ),
         mainPanel(
            plotOutput("plot1")
         )
      )
   ),
   tabPanel("Predict",
      sidebarLayout(
        sidebarPanel(
          sliderInput("sliderCO2", "What ambient CO^2 concentration would you 
                            like to explore?", 0, 1000, value = 500)
                ),
        mainPanel(
          HTML(paste(tags$h3("Predicted CO ", tags$sup(2), " uptake for plants 
                  at the ambient CO^2 concentration specified using the slider."))),
          h4("Mississippi  plants that have been chilled:"),
          textOutput("pred1"),
          h4("Mississippi  plants that have not been chilled:"),
          textOutput("pred2"),
          h4("Quebec  plants that have been chilled:"),
          textOutput("pred3"),
          h4("Quebec  plants that have not been chilled:"),
          textOutput("pred4")
        )
   )
)
)

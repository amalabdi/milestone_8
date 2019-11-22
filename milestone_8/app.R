#
# # loading libraries

library(shiny)
library(markdown)
library(DT)
library(readxl)
library(tidyverse)

# loading data

data <- read_xlsx("data.xlsx")

# Creating a UI with a navbar 

ui <- navbarPage("Navigate",
                 
                 # Adding a tab for my about page
                 tabPanel("About",
                          textOutput("text")),
                 # Adding a tab to the navbar for my map
                 tabPanel("Rent-Burden Ohio Households",
                          plotOutput("graph2")),
                 
                 # Adding tab for second graph
                 tabPanel("Evictions",
                          plotOutput("graph1"))
)

# Creating a server to tell ui what to do

server <- function(input, output){
  
  # Using rendertext to write text for my About tab panel which I defined as text
  # in textOutput
  output$text <- renderText({"Welcome to my final project rough draft created for the fall 2019 iteration
    of Harvard Gov 1005: Data class! My name is Amal Abdi, and I am a senior at Harvard. This data is from 
    the American Community Survey and Princeton Eviction Lab. In this project, I am exploring evictions in Ohio."})
  
  # Using renderPlot to insert the graph for my Map tab panel which I defined in the ui
output$graph1 <- renderPlot({  
    data %>% 
    
    # Creating plot using data
        ggplot(aes(x = year, y = evictions)) +
          geom_point() +
            labs(xlab = "Year", ylab = "Number of Evictions", title = "Evictions in Ohio over Time",
            subtitle = "Data from Princeton Poverty Lab") +
            
            # Adding line to make it easier to read
            geom_smooth(method = "lm", se = FALSE)
})
output$graph2 <- renderPlot({  
  data %>% 
    
    # Creating second plot
    ggplot(aes(x = year, y = `rent-burden`)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    
    #Adding labels to make graph understandable and explain what rent-burdened means
    labs(title = "Percentage of households rent-burdened", subtitle = "rent-burdened = paying > 30% of
         income to rent")
})
}

# Run the application 
shinyApp(ui = ui, server = server)
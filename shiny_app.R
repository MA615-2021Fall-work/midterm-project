library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(readr)
library(shinyjs)
library(shinycssloaders)
library(treemapify)
source("ultimate data wrangle and clean.R")
source("visualization function midterm.R")




ui <- fluidPage(
    theme = shinytheme("cerulean"),
  # the navbarpage
    navbarPage("EDA for Strawberry",theme = shinytheme("lumen"),
               tabPanel("Location", fluid = TRUE,icon = icon("globe-americas"),
                        titlePanel("Geographical Location Information"),
                        sidebarLayout(
                          sidebarPanel(
                            titlePanel("State list"),
                            HTML("California<br/>Florida<br/>Oregon<br/>Washington")
                          ),
                          mainPanel(
                            plotOutput(outputId = "GeoplotFinder",click = "plot_click_1"),
                            verbatimTextOutput("info_1"),
                            helpText("Tip: Clicking the plot will show specific longitude and latitude.")
                            
                          )
                        )
                        
               ),
               
             # Add row choices
              tabPanel("Pesdicide usage", fluid = TRUE,icon = icon("chart-bar"),
                sidebarLayout(
                  sidebarPanel(
        # Select state
                    titlePanel(HTML("<h3>Desired Year")),
                    fluidRow(
            # Select year
                            checkboxGroupInput(inputId ="YearFinder",
                                               label = "MUST choose at least one year",
                                               choices  = c("2016",
                                                            "2018",
                                                            "2019"
                                                            )
                                                ),
                            helpText("Tip: If the plot is empty, this means that there is no avaiable data under this filter conditions.")
            
                                  )
                              ),
    # The major interactive plot
                  mainPanel(
                            plotOutput(outputId = "barplotFinder",click = "plot_click")
                            )
                          )
              ),
    
    # The plot of frequency
            tabPanel("Pesticide Toxicitylevelhuman Frequency", fluid = TRUE,
             sidebarLayout(
               sidebarPanel(
                 titlePanel("Pesticide Toxicitylevelhuman Frequency 2016 vs. 2018 vs. 2019"
                 ),
                 fluidRow(
                   # Select year
                   radioButtons(inputId ="LayerFinder",
                                label = "MUST choose one year",
                                choiceNames   = c("2016",
                                                   "2018",
                                                   "2019"
                                      ),
                                choiceValues = c("2016","2018","2019")
                   )
                 )
               ),
               mainPanel(
                 plotOutput(outputId = "LayerplotFinder")
               )
             )
    ),
    
    
    # The total pesticide plot
    
              tabPanel("Total Pesticide", fluid = TRUE,
                       sidebarLayout(
                         sidebarPanel(
                            titlePanel("Total Pesticide usage: 2016 vs. 2018 vs. 2019"
                                       )
                                        ),
                         mainPanel(
                           plotOutput(outputId = "YearplotFinder")
                         )
                       )
              ),
  
  # Add author information
  navbarMenu("More", icon = icon("info-circle"),
             tabPanel("About", fluid = TRUE,
                      column(6,
                             h4(p("About the Project")),
                             h5(p("How the human-harm pesticide usage differ as time passes in the major strawberries producing areas in the US.")),
                             br()
                      ),
                      column(6,
                             h4(p("About the Author")),
                             h5(p("Group member: Andrew Sisitzky,Chen Xu,Guangze Yu, Yuyang Li."))
                              )
                      )
              )

  )
)

  



server <- function(input, output,session) {
  # Recall the origianl dataset.
  chemicaltype_freq <- data.frame(chemicaltype_freq)
  eda_subset <- data.frame(eda_subset)
  
  # Render select Input
  
  datasetInput1 <- reactive({
    chemicaltype_freq %<>% filter(year %in% input$YearFinder)
  })
  
    output$barplotFinder <- renderPlot({
    chemicaltype_freq_function(datasetInput1())
    })
    
    output$YearplotFinder <- renderPlot({
    chemcialtype_freq_barchart_function(chemicaltype_freq)
    })
    
    output$LayerplotFinder <- renderPlot({
      if (input$LayerFinder == "2016") {
        human_toxicity_level_function(year1_toxicityhuman_freq) + ggtitle("Pesticide Toxicitylevelhuman Frequency 2016")
      } else if (input$LayerFinder == "2018"){
        human_toxicity_level_function(year2_toxicityhuman_freq) + ggtitle("Pesticide Toxicitylevelhuman Frequency 2018")
      } else {
        human_toxicity_level_function(year3_toxicityhuman_freq) + ggtitle("Pesticide Toxicitylevelhuman Frequency 2019")
      }
      
    })
    output$GeoplotFinder <- renderPlot({
    map_function(eda_subset)
    })
    
    output$info_1 <- renderText({
      paste0("Longitude=", input$plot_click_1$x, "\nLatitude=", input$plot_click_1$y)
    })
}


shinyApp(ui = ui, server = server)
library(shiny)
library(shinythemes)
library(dplyr)
library(readr)



ui <- fluidPage(
  # the navbarpage
  navbarPage("The relationship between stawberry and pesticides",theme = shinytheme("lumen"),
             # Add row choices
             tabPanel("Stawberry Summary", fluid = TRUE,icon = icon("chart-bar"),
    titlePanel("EDA for Strawberry"),
    sidebarLayout(
      sidebarPanel(
        # Select state
        titlePanel("Desired Year and state"),
        fluidRow(
            radioButtons(inputId ="StateFinder",
                          label = "Choose one state",
                          choices= list("CALIFORNIA",
                                       "FLORIDA",
                                       "OREGON",
                                       "WASHINGTON"
                                        )
                          ),
            # Select year
            radioButtons(inputId ="YearFinder",
                         label = "Choose one year",
                          choices  = list("2019",
                                          "2020",
                                          "2021"
                                          )
                         ),
            actionButton("draw", "Draw!")
  
                )
    ),
    # The major interactive plot
    mainPanel = textOutput("text2")
    )
  ),
  # Add author information
  navbarMenu("More", icon = icon("info-circle"),
             tabPanel("About", fluid = TRUE,
                      column(6,
                             h4(p("About the Project")),
                             h5(p("This project is about the relationship between strawberries and pesticides ")),
                             br()
                      ),
                      column(6,
                             h4(p("About the Author")),
                             h5(p("Group member: Andrew Sisitzky,Chen Xu,Guangze Yu, Yuyang Li."))
            )
    )
  )
))
  



server <- function(input, output,session) {

}


shinyApp(ui = ui, server = server)
library(shiny)
library(shinythemes)

# Define UI for application that plots random distributions 
shinyUI(fluidPage(
  titlePanel(title = "Box-office application"),
  sidebarLayout(
    sidebarPanel(("Choisir une annee"),
                 textInput("year","Entrer une annee",""),
                 actionButton("valider","Valider")),
    
    
    mainPanel(("Resultat"),textOutput("yearToFind"), plotOutput('graph'))
  ),
  
))
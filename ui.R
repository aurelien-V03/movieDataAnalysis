library(shiny)
library(shinythemes)

# Define UI for application that plots random distributions 
shinyUI(fluidPage(
  titlePanel(title = "Box-office application"),
  sidebarLayout(
    sidebarPanel(("ACP - 10 plus gros score au box-office"),
                 textInput("year","Entrer une annee",""),
                 actionButton("valider","Valider ACP"),
                 
                 
                 
                 actionButton("validerAFC", "Valider AFC")
                 ),

    
    mainPanel(("Resultat"),textOutput("yearToFind"), 
              plotOutput('graph'),
              plotOutput("grapVariableACP"),
              plotOutput("grapAFC")
              )
  ),
  
))
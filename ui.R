library(shiny)
library(shinythemes)

# Define UI for application that plots random distributions 
shinyUI(fluidPage(theme = shinytheme("cerulean"),
  titlePanel(title = "Box-office application"),
  navbarPage("Analyses",
             tabPanel("ACP",
                     
                      sidebarLayout(
                        sidebarPanel(
                          h4("ACP - 10 plus gros score au box-office"),
                          textInput("year","Entrer une annee (entre 1975-2014)",""),
                          br(),
                          actionButton("valider","Valider ACP"),
                        ),
                        mainPanel(
                          fluidRow(column(h2(textOutput("yearToFind")),width = 12)),
                          fluidRow(
                                column(plotOutput('graphIndividusACP'), width = 4),
                                column(plotOutput("grapVariableACP"),width = 4),
                                column(dataTableOutput("ACPtable"), width=4)
                                                    
                          )
                        )
                      )
                      ),
             tabPanel("AFC",
                      sidebarLayout(
                        sidebarPanel(
                          actionButton("lancerAFC","Lancer AFC")
                          
                        ),
                        mainPanel(
                            fluidRow(column(h2("Resultat AFC"), width = 12)),
                            fluidRow(column(dataTableOutput("AFCtable"),width = 12)),
                            
                            fluidRow(column(dataTableOutput("graphAFC"),width = 12))
                            
                            
                        )
                      ),
                      )
             ),
 
  
))
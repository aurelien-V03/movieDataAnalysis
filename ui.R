library(shiny)
library(shinythemes)

# Define UI for application that plots random distributions 
shinyUI(fluidPage(theme = shinytheme("cerulean"),
  titlePanel(title = "Box-office application"),
  navbarPage("Analyses",
             tabPanel("ACP",
                      sidebarLayout(
                        sidebarPanel(
                          h6("ACP - 10 plus gros score au box-office", style="text-align:center"),br(),
                          textInput("year","Entrer une annee (entre 1975-2014)",""),
                          br(),
                          sliderInput("nbDim",p("Nombre dimension utilisee",style="color:black;text-align:center"),
                                      value=1,
                                      min = 1 ,
                                      max = 10 ,
                                      step=1),
                          actionButton("valider","Valider ACP"),
                        ),
                        mainPanel(
                          fluidRow(column(h2(textOutput("yearToFind")),width = 12)),
                          fluidRow(
                                column(plotOutput('graphIndividusACP'), width = 6),
                                column(plotOutput("grapVariableACP"),width = 6),
                          ),
                          fluidRow(column(dataTableOutput("ACPtable"), width=12))
                        )
                      )
                      ),
             tabPanel("AFC",
                      sidebarLayout(
                        sidebarPanel(
                          actionButton("lancerAFC","Lancer AFC")
                          
                        ),
                        mainPanel(
                            fluidRow(column(h3("Resultat AFC",style="text-align:center"), width = 12)),
                            fluidRow(column(dataTableOutput("AFCtable"),width = 12)),
                            
                            fluidRow(column(dataTableOutput("graphAFC"),width = 12))
                            
                            
                      )
                    ),
                  ),
             tabPanel("Jeu de donnee",
                      fluidRow(column(width=2),
                               column(
                                 h4(p("Jeu de donnee 'blockbuster-top_ten_movies_per_year_DFE'",style="color:black;text-align:center")),
                                 width=8,style="background-color:lavender;border-radius: 10px")),
                      fluidRow(column(dataTableOutput("dataset") ,width=12))
                      )
             ),
))
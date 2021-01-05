library(shiny)
library(shinythemes)

# Define UI for application that plots random distributions 
shinyUI(fluidPage(theme = shinytheme("cerulean"),
  titlePanel(title = "Box-office application"),
  navbarPage("Analyses",
             tabPanel(icon("home"),
                      mainPanel(
                      fluidRow(
                        column(width = 6),
                        column(h2("Accueil"),width = 4)),
                      fluidRow(
                        column(width = 4),
                        column(p("Bienvenue sur l'application Box-office Application !",style="text-align:justify;color:black;background-color:lavender;padding:15px;border-radius:10px"),width = 8)),
                      fluidRow(
                        column(width=4),
                        column(p("Cette application a ete developpe par Aurelien Vallet et Akram derdaki dans le cadre du master miage. Ce site met a disposition differentes methodes d'analyses de donnees comme l'analyse en composantes
                                 principales (ACP) ou l'analyse factorielle des correspondances (AFC).",style="text-align:justify;color:black;background-color:lavender;padding:15px;border-radius:10px"),width = 8)
                      )
                      
                      )),
             tabPanel("ACP",
                      sidebarLayout(
                        sidebarPanel(
                          h4("ACP - 10 plus gros score au box-office", style="text-align:center"),br(),
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
                          br(),
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
                            fluidRow(column(plotOutput("graphAFCcol"),width = 6)),
                            br(),
                            fluidRow(column(dataTableOutput("AFCtable"),width = 12)),

                            
                      )
                    ),
                  ),
             tabPanel("Database",
                      br(),
                      fluidRow(column(width=2),
                               column(
                                 h4(p("Database 'blockbuster-top_ten_movies_per_year_DFE'",icon("database"),  style="color:black;text-align:center")),
                                 width=8,style="background-color:lavender;border-radius: 10px")),
                      br(),
                      fluidRow(column(p("ok"), dataTableOutput("dataset") ,width=12))
                      )
             ),
))
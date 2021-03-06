library(shiny)
library(shinythemes)

# Define UI for application that plots random distributions 
shinyUI(fluidPage(theme = shinytheme("cerulean"),
                  tags$head(
                    tags$style(
                      HTML(".shiny-notification {
                           position:fixed;
                           top: calc(50%);
                           left: calc(50%);}"))),
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
                                      min = 2 ,
                                      max = 10 ,
                                      step=1),
                          checkboxGroupInput("acpClumms",p("Variables de l'ACP",style="color:coral"),choices = c("worldwide_gross"=1,"length"=2,"imdb_rating"=3, "rt_audience_score" = 4, "audience_freshness" = 5),selected = c("Projected population"=1,"Thefts"=2,"Traffic accidents"=3,"Homicides"=4,"School deserters"=5,"Sports venues"=6,"Extortions"=7)),
                          actionButton("valider","Valider ACP"),
                        ),
                        mainPanel(
                          fluidRow(
                                column(plotOutput('graphIndividusACP'), width = 6),
                                column(plotOutput("grapVariableACP"),width = 6),
                          ),
                          br(),
                          fluidRow(column(h2(textOutput("ACPtableTile")),width=12)),  
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
             tabPanel("Base de donnee",
                      br(),
                      fluidRow(column(width=2),
                               column(
                                 h4(p("Database 'blockbuster-top_ten_movies_per_year_DFE'",icon("database"),  style="color:black;text-align:center")),
                                 width=8,style="background-color:lavender;border-radius: 10px")),
                      br(),
                      fluidRow(column( dataTableOutput("dataset") ,width=12))
                      )
             ),
))
library(shiny)
library(FactoMineR)
library(dplyr)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  
  # Importation des donnees au format CSV
  listMovies <- read.csv("blockbuster-top_ten_movies_per_year_DFE.csv")
  
  # display full dataset
  output$dataset <- renderDataTable(listMovies)
  
  # Evenement : utilisateur valide l'ACP
  observeEvent(input$valider,{
    

    lm10 <- listMovies %>% filter(year == input$year)
    lm10 <- lm10 %>% mutate(worldwide_gross = sub('.','',worldwide_gross))
    lm10 <- lm10 %>% mutate(worldwide_gross = stringr::str_replace_all(worldwide_gross,',',''))
    lm10 <- lm10 %>% mutate(worldwide_gross = as.numeric(worldwide_gross))
    lm10 <- lm10 %>% select(worldwide_gross, length, imdb_rating, title)
    
    #donnee de l'ACP
    output$ACPtable <- renderDataTable(lm10)
    
    pca <-  PCA(X = lm10, ncp = input$nbDim  , quali.sup = 4, scale.unit = TRUE, graph = FALSE)
    
    
    # Graphe des individus ACP
    output$graphIndividusACP <- renderPlot(
      plot(pca,title="Graphe des individus",choix="ind", axes = c(1,2))
      )
    # Graphe des variables ACP
    output$grapVariableACP <- renderPlot(
      plot(
        pca,title="Graphe des variables",choix = "var", axes=1:2
      )
    )
    output$yearToFind <- renderText(
      {paste("Resultat pour annee : ", input$year, "( ", input$nbDim  ," dimension )")
        
        })
    
  })

  # Evenement : utilisateur valide l'AFC
    observeEvent(input$lancerAFC,{
      lm <- listMovies %>% select(Genre_1, Genre_2, Genre_3, year)
      lm <- lm %>% filter(!is.na(year))
      lm <- lm %>% mutate(year_2 = case_when(year >= 1975 & year < 1985 ~ 4, year >= 1985 & year < 1995 ~ 3, year >= 1995 & year < 2005 ~ 2,  year >= 2005 & year < 2015 ~ 1))
      
      lm <- lm %>% mutate(SciFi = case_when(Genre_1 == 'Sci-Fi' | Genre_2 == 'Sci-Fi' | Genre_3 == 'Sci-Fi ' ~ 1 ))
      lm$SciFi[is.na(lm$SciFi)] <- 0
      lm <- lm %>% mutate(Family = case_when(Genre_1 == 'Family' | Genre_2 == 'Family' | Genre_3 == 'Family ' ~ 1))
      lm$Family[is.na(lm$Family)] <- 0
      lm <- lm %>% mutate(Fantasy = case_when(Genre_1 == 'Fantasy' | Genre_2 == 'Fantasy' | Genre_3 == 'Fantasy ' ~ 1))
      lm$Fantasy[is.na(lm$Fantasy)] <- 0
      
      lm <- lm %>% mutate(Thriller = case_when(Genre_1 == 'Thriller' | Genre_2 == 'Thriller' | Genre_3 == 'Thriller' ~ 1))
      lm$Thriller[is.na(lm$Thriller)] <- 0
      
      lm <- lm %>% mutate(Comedy = case_when(Genre_1 == 'Comedy' | Genre_2 == 'Comedy' | Genre_3 == 'Comedy' ~ 1))
      lm$Comedy[is.na(lm$Comedy)] <- 0
      
      lm <- lm %>% mutate(Adventure = case_when(Genre_1 == 'Adventure' | Genre_2 == 'Adventure' | Genre_3 == 'Adventure ' ~ 1))
      lm$Adventure[is.na(lm$Adventure)] <- 0
      
      lm <- lm %>% mutate(Animation = case_when(Genre_1 == 'Animation' | Genre_2 == 'Mystery' | Genre_3 == 'Animation' ~ 1))
      lm$Animation[is.na(lm$Animation)] <- 0
      
      lm <- lm %>% mutate(Crime = case_when(Genre_1 == 'Crime' | Genre_2 == 'Crime' | Genre_3 == 'Crime' ~ 1))
      lm$Crime[is.na(lm$Crime)] <- 0
      
      lm <- lm %>% mutate(Romance = case_when(Genre_1 == 'Romance' | Genre_2 == 'Mystery' | Genre_3 == 'Romance' ~ 1))
      lm$Romance[is.na(lm$Romance)] <- 0
      
      lm <- lm %>% mutate(Drama = case_when(Genre_1 == 'Drama' | Genre_2 == 'Drama' | Genre_3 == 'Drama' ~ 1))
      lm$Drama[is.na(lm$Drama)] <- 0
      
      lm <- lm %>% mutate(War = case_when(Genre_1 == 'War' | Genre_2 == 'War' | Genre_3 == 'War' ~ 1))
      lm$War[is.na(lm$War)] <- 0
      
      lm <- lm %>% mutate(History = case_when(Genre_1 == 'History' | Genre_2 == 'History' | Genre_3 == 'History' ~ 1))
      lm$History[is.na(lm$History)] <- 0
      
      
      lm <- lm %>% mutate(Music = case_when(Genre_1 == 'Music' | Genre_2 == 'Music' | Genre_3 == 'Music' ~ 1))
      lm$Music[is.na(lm$Music)] <- 0
      
      lm <- lm %>% mutate(Action = case_when(Genre_1 == 'Action' | Genre_2 == 'Action' | Genre_3 == 'Action' ~ 1))
      lm$Action[is.na(lm$Action)] <- 0
      
      
      lm <- lm %>% mutate(Western = case_when(Genre_1 == 'Western' | Genre_2 == 'Western' | Genre_3 == 'Western' ~ 1))
      lm$Western[is.na(lm$Western)] <- 0
      
      
      lm <- lm %>% mutate(Horror = case_when(Genre_1 == 'Horror' | Genre_2 == 'Horror' | Genre_3 == 'Horror' ~ 1))
      lm$Horror[is.na(lm$Horror)] <- 0
      
      
      lm <- lm %>% mutate(Sport = case_when(Genre_1 == 'Sport' | Genre_2 == 'Sport' | Genre_3 == 'Sport' ~ 1))
      lm$Sport[is.na(lm$Sport)] <- 0
      
      lm <- lm %>% mutate(Musical = case_when(Genre_1 == 'Musical' | Genre_2 == 'Musical' | Genre_3 == 'Musical' ~ 1)) 
      lm$Musical[is.na(lm$Musical)] <- 0
      
      
      lm <- lm %>% filter(year_2 >= 0) %>% group_by(year_2) %>% summarise(SciFi = sum(SciFi),Familiy = sum(Family), Fantasy = sum(Fantasy), Thriller = sum(Thriller), Comedy = sum(Comedy),adventure = sum(Adventure), Animation = sum(Animation), Crime = sum(Crime), Romance = sum(Romance), Drama = sum(Drama), War = sum(War), History = sum(History), Music = sum(Music), Action = sum(Action), Western = sum(Western), Horror = sum(Horror), Sport = sum(Sport), Musical = sum(Musical))
      output$AFCtable <- renderDataTable(lm)
      
      rs <- CA(lm)
      
      output$graphAFCcol <- renderPlot({
        #plot(rs, axes = c(1,2),choix ="CA")
        plot(rs,title = "AFC")
      }, 
      height = 480,
      width = 480)
      
    })
})



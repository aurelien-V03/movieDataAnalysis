library(shiny)
library(FactoMineR)
library(dplyr)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  
  # Importation des donnees au format CSV
  listMovies <- read.csv("blockbuster-top_ten_movies_per_year_DFE.csv")
  
  # donnees pour la rubrique "Base de donnee"
  output$dataset <- renderDataTable(listMovies)
  
  # Evenement : utilisateur valide l'ACP
  observeEvent(input$valider,{
     
    # Si on a au moins 2 variable selectionnee
    if(length(input$acpClumms) >=2)
    {
      # si la date est comrpise entre 1975 et 2014
      if(input$year >= 1975 & input$year <= 2014)
      {
        lm10 <- listMovies %>% filter(year == input$year)
        
        # transformation de la colonne worldwide_gross en donnee quantitative exploitable
        lm10 <- lm10 %>% mutate(worldwide_gross = sub('.','',worldwide_gross))
        lm10 <- lm10 %>% mutate(worldwide_gross = stringr::str_replace_all(worldwide_gross,',',''))
        lm10 <- lm10 %>% mutate(worldwide_gross = as.numeric(worldwide_gross))
        
        # selection des colonnes quantitatives disponibles pour l'ACP
        lm10 <- lm10 %>% select(worldwide_gross, length, imdb_rating, rt_audience_score, audience_freshness, title)
        
        
        # nombre de variables que l'on va prendre      
        nbVar <- 1
        # liste des index des variables
        index_variables <- c()
        # Pour chaque valeur cochee
        for (col in input$acpClumms) {
          index_variables <- c(index_variables,as.numeric(col))
          nbVar <- nbVar + 1
        }
        
        index_variables <- c(index_variables,6)
        
        # filtrage des colonnes selectionne
        lm10 <- lm10 %>% select(index_variables)
       
        #donnee de l'ACP
        output$ACPtable <- renderDataTable(lm10, options = list(pageLength = 10))
        
        # ACP
        pca <-  PCA(X = lm10, ncp = input$nbDim  , quali.sup = nbVar, scale.unit = TRUE, graph = FALSE)
        
        # Graphe des individus ACP
        output$graphIndividusACP <- renderPlot(
          plot(pca,title = "Graphe des individus" ,choix="ind", axes = c(1,2))
        )
        
        # Graphe des variables ACP
        output$grapVariableACP <- renderPlot(
          plot(
            pca,title="Graphe des variables",choix = "var", axes=1:2
          )
        )
        
        # titre de l'ACP a afficher
        output$ACPtableTile <- renderText(
          {paste("Resultat pour annee : ", input$year)
          })
      }
      else{
        showNotification("Attention la date doit etre comprise entre 1975 et 2014 !", type = "error")
      }
    }
    else{
      showNotification("Attention vous devez selectionner 2 variables au minimum !", type = "error")
    }
  })
  # Evenement : utilisateur valide l'AFC
    observeEvent(input$lancerAFC,{
      
      # Selection des genres pour chaque film
      lm <- listMovies %>% select(Genre_1, Genre_2, Genre_3, year)
      # Filtrage des annee valide
      lm <- lm %>% filter(!is.na(year))
      
      # ajout des intervalles de temps ( [1975:1984] = 4 [1985:1994] = 3 [1995:2004] = 2 [2005:2014] = 1)
      lm <- lm %>% mutate(year_2 = case_when(year >= 1975 & year < 1985 ~ 4, year >= 1985 & year < 1995 ~ 3, year >= 1995 & year < 2005 ~ 2,  year >= 2005 & year < 2015 ~ 1))
      
      #Ajout de 18 colonnes de genre pour chaque film (1 = possede ce genre / 0 = ne possede pas)
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
      
      # Group by par intervalle d'aneee et cumul de chaque genre
      lm <- lm %>% filter(year_2 >= 0) %>% group_by(year_2) %>% summarise(SciFi = sum(SciFi),Familiy = sum(Family), Fantasy = sum(Fantasy), Thriller = sum(Thriller), Comedy = sum(Comedy),adventure = sum(Adventure), Animation = sum(Animation), Crime = sum(Crime), Romance = sum(Romance), Drama = sum(Drama), War = sum(War), History = sum(History), Music = sum(Music), Action = sum(Action), Western = sum(Western), Horror = sum(Horror), Sport = sum(Sport), Musical = sum(Musical))
      
      # Dataset de l'AFC
      output$AFCtable <- renderDataTable(lm)
      
      # AFC
      rs <- CA(lm)
      
      # Graphe de l'AFC
      output$graphAFCcol <- renderPlot({
        plot(rs,title = "Analyse factorielle des correspondances AFC")
      }, 
      height = 480,
      width = 480)
    })
})



library(shiny)
library(FactoMineR)
library(dplyr)
# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  

 

  observeEvent(input$valider,{
    
    listMovies <- read.csv("C:/Users/Aurel/OneDrive/Bureau/ECOLE/PROGRAMMATION/movieDataAnalysis/blockbuster-top_ten_movies_per_year_DFE.csv")
    
    lm10 <- listMovies %>% filter(year == input$year)
    lm10 <- lm10 %>% mutate(worldwide_gross = sub('.','',worldwide_gross))
    lm10 <- lm10 %>% mutate(worldwide_gross = stringr::str_replace_all(worldwide_gross,',',''))
    lm10 <- lm10 %>% mutate(worldwide_gross = as.numeric(worldwide_gross))
    lm10 <- lm10 %>% select(worldwide_gross, length, imdb_rating)
    pca <-  PCA(X = lm10)
    
    
    output$graph <- renderPlot({
      par(mar = c(4, 4, 0, 0) + .1)
      plot(Dim.2 ~ Dim.1, pca$ind$coord)
    })
    
  })
  
    # on recupere l'annee quand l'utilisateur clique sur valider
    output$yearToFind <- renderText({

      input$valider
      # isolate = creer dependance vis a vis du bouton
      isolate(paste("Resultat pour annee : ", input$year))
      })
 
})



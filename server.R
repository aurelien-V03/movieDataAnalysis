library(shiny)
library(FactoMineR)
# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  
 
    # on recupere l'annee quand l'utilisateur clique sur valider
    output$yearToFind <- renderText({
      input$valider
      # isolate = creer dependance vis a vis du bouton
      isolate(paste("Resultat pour annee : ", input$year))})
 
})



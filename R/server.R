# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(ffanalytics)

# Define a server for the Shiny app
function(input, output) {
  
  
  my_scrape <- ffanalytics::scrape_data(src = c("ESPN"), 
                                        pos = c("QB"),
                                        season = NULL, # NULL grabs the current season
                                        week = NULL)
  
  my_scrape[["QB"]]
  
  
  my_scrape <- ffanalytics::scrape_data(src = c("ESPN"), 
                                        pos = c("DST"),
                                        season = NULL, # NULL grabs the current season
                                        week = NULL)
  
  my_scrape[[""]]
  
  
  # Fill in the spot we created for a plot
  output$dataPlot <- renderPlot({
    
    # Render a barplot
    barplot(WorldPhones[,input$region]*1000, 
            main=input$region,
            ylab="Number of Telephones",
            xlab="Year")
  })
}
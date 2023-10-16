# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(ffanalytics)
library(tidyverse)

# Define a server for the Shiny app
function(input, output) {

  
  weeks <- 1:ffanalytics:::get_scrape_week()
  
  teams_to_pull <- reactive(paste(gsub("@", "", subset(nflschedule::nflschedule2023, Team==input$defChoice)[,weeks+1]), weeks, sep="_"))
  
  results <- reactive(lapply(weeks, 
                             function(w){data.frame(ffanalytics::scrape_data(src = input$sourceChoice, 
                                                                    pos = input$positionChoice,
                                                                    season = NULL, # NULL grabs the current season
                                                                    week = w)[[input$positionChoice]],
                                           week = w)}
                    ))
  
  df <- reactive(do.call(dplyr::bind_rows, results()))
  
 
  
  # Fill in the spot we created for a plot
  output$dataPlot <- renderPlot({
    
    # Render a plot
    df() %>% 
      mutate(team = recode(team, "KCC"="KC", "JAC"="JAX"),
                        id = paste(team, week, sep="_")) %>%
      filter(id %in% teams_to_pull()) %>% 
      select(-id, -src_id, -data_src, -pos) %>%
      pivot_longer(cols=-c(player, team, week), names_to="stat_type", values_to="stat") %>%
      mutate(actvspred = ifelse(week < max(week), "Actual", "Predicted")) %>%
      ggplot(data=., aes(x=week, y=stat, color=actvspred)) + 
        geom_point() + 
        facet_grid(stat_type~., scales="free_y") + 
        scale_color_manual("", values=c("black", "#56B4E9")) +
        labs(x="Week", y="") + 
        theme_bw()
    
  })
}
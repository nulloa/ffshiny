# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(shinyWidgets)

# Use a fluid Bootstrap layout
fluidPage(    
  
  # Give the page a title
  titlePanel("Telephones by region"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      
      
      # This is the first widget that will choose the source
      pickerInput(
        inputId = "sourceChoice",
        label = "Projection Source", 
        choices = c("CBS", "ESPN", "FantasyPros", "FantasySharks", "FFToday", 
                    "FleaFlicker", "NumberFire", "FantasyFootballNerd", "NFL"),
        options = list(
          title = "Choose a source for projections")
      ),
      hr(),
      helpText("Choose the source from where the projections will be grabbed."),
      
      # This is the first widget that will choose the player position
      pickerInput(
        inputId = "positionChoice",
        label = "Player Position", 
        choices = c("QB", "RB", "WR", "TE", "DST"),
        options = list(
          title = "Choose a player position group")
      ),
      hr(),
      helpText("Choose the player group you want to graph.")
      
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("dataPlot")  
    )
    
  )
)
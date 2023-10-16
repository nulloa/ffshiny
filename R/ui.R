# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(shinyWidgets)
library(nflschedule)

# Use a fluid Bootstrap layout
fluidPage(    
  
  # Give the page a title
  titlePanel("Points Allowed by Defense"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      
      # This widget will choose the source
      pickerInput(
        inputId = "sourceChoice",
        label = "Projection Source", 
        choices = c("CBS", "ESPN", "FantasyPros", "FantasySharks", "FFToday", 
                    "FleaFlicker", "NumberFire", "FantasyFootballNerd", "NFL"),
        # selected="ESPN",
        options = list(
          title = "Choose a source")
      ),
      helpText("Choose the source from where the projections will be grabbed."),
      hr(),
      
      # This widget will choose the defense
      pickerInput(
        inputId = "defChoice",
        label = "Defense", 
        choices = nflschedule::nflteams,
        options = list(
          title = "Choose a team")
      ),
      helpText("Choose the source from where the projections will be grabbed."),
      hr(),
      
      # This widget will choose the player position
      pickerInput(
        inputId = "positionChoice",
        label = "Player Position", 
        choices = c("QB", "RB", "WR", "TE", "DST"),
        # selected="QB",
        options = list(
          title = "Choose a player position group")
      ),
      helpText("Choose the player group you want to graph.")
      
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("dataPlot")  
    )
    
  )
)
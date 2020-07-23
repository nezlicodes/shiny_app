library(shinydashboard)
# Create an empty header
header <- dashboardHeader(
  # Create a notification drop down menu
  dropdownMenu(type = "notifications",
               notificationItem(
                 text="The International Space Station is overhead!"
               ))
)
sidebar <- dashboardSidebar(  sidebarMenu(    menuItem("Data",             tabName = "data"    ),    menuItem("Dashboard",             tabName = "dashboard")  ))
body <- dashboardBody()

ui <- dashboardPage(header = header,
                    sidebar =sidebar,
                    body = dashboardBody()
)

server <- function(input, output) {}

shiny::shinyApp(ui, server)


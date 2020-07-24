library(shinydashboard)
# Create an empty header
header <- dashboardHeader(
  # Create a notification drop down menu
  dropdownMenu(type = "messages",
               messageItem(
                 from="Lily",
                 message="Finish this course!"
               ))
)
sidebar <- dashboardSidebar(  
  sidebarMenu(   
menuItem("Dashboard",       
         tabName = "dashboard"),  
menuItem("Data",tabName = "data"    )),
selectInput(
  inputId="molecule",
  label = "Molecule",
  choices = c("Acide valproique", "Carbamazepine")
))

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "dashboard",
      tabBox(
        title="Table title",
        tabPanel("Tab1", "Content for tab1"),
        tabPanel("Tab2", "content for Tab2")
      )
      )
  ),
  textOutput("molecule")
)


ui <- dashboardPage(header = header,
                    sidebar =sidebar,
                    body = body
)

server <- function(input, output) {
  output$molecule <- renderPrint({
    input$molecule
  })
}

shiny::shinyApp(ui, server)


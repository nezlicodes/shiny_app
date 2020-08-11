library(shiny)
library(ggplot2)
library(shinythemes)
library(plotly)
data = read.csv('IM.csv')

ui <- fluidPage(
  titlePanel("Baby Name Explorer"),
  theme = shinythemes::shinytheme("flatly"),
  sidebarLayout(
    sidebarPanel (
      textInput('name', 'Enter Name', 'David'),
      selectInput ('sex', 
              'Choose a sex',
                   selected = 'F',
                   choices = colnames(data)),
      sliderInput('bins', 'Chose a scale', min=0, max=1, value=1 )
    ),
    mainPanel(
  
      tabsetPanel(
        tabPanel('Sex',DT::DTOutput('sex')),
        tabPanel('Dosage',plotly::plotlyOutput('dosage'),    actionButton('hi', 'Help'))
        )
  )
))
server <- function(input, output, session) {
  output$dosage <- plotly::renderPlotly({
    ggplot(data=data, aes(x=as.numeric(dosage), fill='steelblue')) + geom_histogram(alpha=input$bins)
  })
  renderText(input$sex)
  #output$sex <- DT::renderDT(data)
  observeEvent(input$hi,
              { showModal(modalDialog('Well.... hi'))})
}
shinyApp(ui = ui, server = server)


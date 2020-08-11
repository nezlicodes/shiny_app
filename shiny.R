library(shiny)
library(ggplot2)
library(shinythemes)
library(plotly)
data = read.csv('IM.csv')

ui <- fluidPage(
  titlePanel("Really really random"),
  
  theme = shinythemes::shinytheme("flatly"),
  
  sidebarLayout(
    sidebarPanel (
      textInput('name', 'Enter Name', 'David'),
      selectInput ('sex', 
              'Choose a sex',
                   selected = 'F',
                   choices = colnames(data)),
      sliderInput('bins', 'Chose a scale', min=0, max=1, value=1 ),
      numericInput('height','Select height' ,50),
      actionButton('showHeight', 'Only now Count lol')
    ),
    mainPanel(
      textOutput("height_cm"),
      
      tabsetPanel(
        tabPanel('Sex',renderText(output$height)),
        tabPanel('Dosage',plotly::plotlyOutput('dosage'),    
        actionButton('hi', 'Help'))
        )
  )
))
server <- function(input, output, session) {
 
   output$height_cm <- renderText({
     height <- reactiveFunct()
     paste("Your height in centimeters is", height ,"cm")
  })
  
   reactiveFunct <- eventReactive(input$showHeight,{
     input$height * 2.45
   } )
  
  output$dosage <- plotly::renderPlotly({
    ggplot(data=data, aes(x=as.numeric(dosage), fill='steelblue')) + geom_histogram(alpha=input$bins)
  })
  
  #output$sex <- DT::renderDT(data)
  observeEvent(input$hi,
              { showModal(modalDialog('Well.... hi'))})

}


shinyApp(ui = ui, server = server)


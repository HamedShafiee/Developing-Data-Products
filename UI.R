#runApp(display.mode = 'showcase')
# load shiny package
library(shiny)
library(ggplot2)
# begin shiny UI
shinyUI(
    pageWithSidebar(
        #Applictaion Title
        headerPanel("Plotting a Distribution based on User inputs & Calculating Probability for a Range"),
        sidebarPanel(
            #defining the inputs
            selectInput("distType", label = "distribution type", 
                        choices = list("Normal", "Poison", "Uniform"), 
                        selected = "Normal"),
            conditionalPanel(condition="input.distType=='Normal' ",
                numericInput('n',"Sample Length for Distribution Generation",value=10000,min = 10,max = NA,step = 100,width = 250),
                numericInput('mean',"Distribution Mean",value=10,min = 10,max = 20,step = 2,width = 250),
                numericInput('sd',"Distribution Standard Deviation",value=1,min = 1,max = 5,step = 1,width = 250),
                textInput('distributionTitle',"Distribution Title",value = "DefaultTitle"),
                h5('Please determine the range which you want to calculate the probability as Probability(Low<x<High)'),
                sliderInput("range","Probability Range:", min = 5,max = 25,value = c(5, 25))),
            
            conditionalPanel(condition="input.distType=='Poison' ",
                numericInput('n',"Sample Length for Distribution Generation",value=10000,min = 10,max = NA,step = 100,width = 250),
                numericInput('lambda',"Distribution Lambda",value=5,min = 1,max = 10,step = 1,width = 250),
                textInput('distributionTitle',"Distribution Title",value = "DefaultTitle"),
                h5('Please determine the range which you want to calculate the probability as Probability(Low<x<High)'),
                sliderInput("range","Probability Range:", min = 1,max = 20,value = c(1, 20))),
            
            conditionalPanel(condition="input.distType=='Uniform' ",
                numericInput('n',"Sample Length for Distribution Generation",value=10000,min = 10,max = NA,step = 100,width = 250),
                numericInput('min',"Distribution Min",value=5,min = 0,max = 10,step = 1,width = 250),
                numericInput('max',"Distribution Max",value=10,min = 20,max = 30,step = .5,width = 250),
                textInput('distributionTitle',"Distribution Title",value = "DefaultTitle"),
                h5('Please determine the range which you want to calculate the probability as Probability(Low<x<High)'),
                sliderInput("range","Probability Range:", min = 0,max = 25,value = c(0, 30))),
            submitButton('submit')
                     ),
        mainPanel(
            tabsetPanel(
                tabPanel(p(icon("bar-chart-o"),"Plot"), plotOutput("plot1")),
                tabPanel(p(icon("table"),"Summary"), verbatimTextOutput("summary")),
                tabPanel(p(icon("dashboard"),"Probability"), 
                         h5('the lower limit for probability calculation is:'),
                         verbatimTextOutput("lowerrange"),
                         h5('the upper limit for probability calculation is:'),
                         verbatimTextOutput("upperrange"),
                         h5('the calculated probability Pr(lowerrange<x<upperrange):'),
                         verbatimTextOutput("probability"))
                       )
                )
)
)
        
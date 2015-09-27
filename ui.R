library(shiny)

shinyUI(      
    navbarPage("A Simple Stock Search Tool",
        tabPanel("Search",
                pageWithSidebar(
                    headerPanel("Search"),                    
                    sidebarPanel(                        
                        p("This is a simple tool implemented using Shiny to help the
user find basic information about a stock. Please check the Help tab for a more
detailed introduction."),
                        textInput("symbol", "Stock Symbol:", "GE"),                        
                        dateInput("sDate", "From:","2014-09-01" ),
                        dateInput("eDate", "To:", Sys.Date() ),
                        actionButton("btnSearch","Search")
                    ),
                    
                    mainPanel(
                        tabsetPanel(
                            tabPanel('Summary', tableOutput("stockSummary")),
                            tabPanel('Plot', plotOutput("stockPlot"))                            
                        )                       
                    )
                 )
        ),
        tabPanel("Help",    
                 headerPanel("Help"),                    
                 mainPanel(                 
                     tags$a(href="http://rpubs.com/shuoyenl/DevelopingDataProduct", "Introduction of This Tool")
                 )             
        )
    )
)
library(shiny)
library(quantmod)

GetStockData <- function(symbol, sDate, eDate)
{
    sym <- getSymbols(symbol, from=sDate, to=eDate, auto.assign=F)
        
    adjSDate <- seq(as.Date(sDate), length.out=2, by="-1 year")[2]    
    quaDiv <- getDividends(symbol, from=adjSDate, to=eDate)
    if (nrow(quaDiv) >= 4)
    {
        annDiv <- runSum(quaDiv, n=4)
        result <- na.locf(merge(sym, Dividend=annDiv, all=TRUE))
        result$Yield <- result$Dividend/result[,4]*100      
    }
    else
    {
        result <- sym
        result$Dividend = 0
        result$Yield = 0
    }
    result <- result[complete.cases(result),]   
    result
}


shinyServer(function(input, output) {       
    stockData <- reactive(
    {
        GetStockData(input$symbol, input$sDate, input$eDate)
    })
    
    output$stockSummary <- renderTable({
        df <- stockData()
        df <- data.frame(df[,4], df[,5], df[,6], df$Dividend, df$Yield)
    })
    
    output$stockPlot <- renderPlot({
        #input$btnSearch
        chartSeries(stockData(), name=input$stockSymbol)
    })    
})
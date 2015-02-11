library(shiny) 
library(forecast)

#the initial sales array
previousSales<-c(100,61,73,89,66,67,60,40,50,89,72,83,
                 123,78,89,111,82,80,80,59,70,108,89,103,
                 131)
ts<-ts(previousSales,start=c(2013,01),frequency=12)

shinyServer( 
  function(input, output) {
    
    #plot the forecast
    output$forecast<-renderPlot({
        
      #read in the new values for February, March and April and attach them to the salesvector
      currentSales<-c(input$salesFeb,input$salesMarch,input$salesApril)
      previousSales<-append(previousSales,currentSales)
      
      #create the time series, starting Jan 2013
      ts<-ts(previousSales,start=c(2013,01),frequency=12)
      
      #decompose the timeseries
      fit<-stl(ts,s.window="period",t.window=12,robust=TRUE)
              
      #forecast based on the time series decomposition
      fcast<-forecast(fit)
      plot(fcast,ylab="Sales in Mio US$")
        
      #get the point forecast as a table
      output$fcValue<-renderTable(fcast$mean)
    })
     
    #get the original time series of the previous sales as a table
    output$tsValue<-renderTable({
      currentSales<-c(input$salesFeb,input$salesMarch,input$salesApril)
      previousSales<-append(previousSales,currentSales)
      ts<-ts(previousSales,start=c(2013,01),frequency=12)
      ts
      }
    )
    
  }
)
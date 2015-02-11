#setwd("JH/data_products")
library(shiny)


shinyUI( pageWithSidebar(
  # Application title 
  headerPanel("Sales dashboard"),
  sidebarPanel(
    h4('Introduction:'),
    p('The main idea was to create a sales forecast, based on a time series decomposition of the previous sales per month.'),
    p('For this, a time series of fictional sales was generated, starting from January 2013 till April 2015. The last three months, February-April 2015, can be altered individually, using the boxes below, to add a bit of interactivity, and a better understanding of how the forecasting algorithm reactes to changes in the time series.'),
    p('The forecasting algorith will be recalculated and the output updated with each change inside one of the boxes.'),
    numericInput('salesFeb', 'Input sales for February 2015 (in Mio US$)', 90, min = 50, max = 200, step = 5),
    numericInput('salesMarch', 'Input sales for March 2015 (in Mio US$)', 100, min = 50, max = 200, step = 5),
    numericInput('salesApril', 'Input sales for April 2015 (in Mio US$)', 120, min = 50, max = 200, step = 5),
    p('The library(forecast) by Rob J Hyndman is used as sole forecasting (and charting) tool. For details, I recommend https://www.otexts.org/fpp'),
    p('All data are purely fictional and not based on any actual sales data.')
    ), 
  
  mainPanel(
    h3('Sales tables'),
    h4('Previous sales (in Mio US$)'),
    p('Use the input boxes to the left to directly adjust the last three values (February-April 2015). The values will update in real time. All other data in this table are fixed.'),
    tableOutput("tsValue"),
    h4('Sales forecast (in Mio US$)'),
    p('This is the point forecast calculated from the above time series. The values will adjust in realtime, as soon as the values for February-April 2015 change.'),
    tableOutput("fcValue"),
    h3('Forecast chart'),
    h4('Forecast based on decomposition:'),
    p('The black line represents the previous data, the blue line the point forecast for each coming month.'),
    p('This forecast will also be recalculated and updated, as soon as the values for February-April 2015 are altered.'),
    p('You can alter the right end of the black line directly using the boxes on the left side. The blue forecast line will change in accordance with the new results of the forecasting algorithm.'),    
    plotOutput('forecast')
    ) 
  )
)
#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  print("Top of server")
  clColor <- c("salmon","blue","darkolivegreen","thistle","orange")
  tcColor <- c("black","wheat2","firebrick2","steelblue","yellow")
  makeCentersFunc <- function() {
    ff <- function(df) {
      print("Find centers")
      input$randomButton
      input$clusterButton
      print(df)
      kmeans(df, input$kmeansCenters)
    }
    return(ff)
  }
  
  makeData <- reactive({
    values <- reactiveValues()
    print("Make data")
    input$randomButton
    numCenters <- isolate(input$randomCenters)
    dev <- isolate(input$randomDeviation)
    pts <- isolate(input$randomPoints)
    cx <- round(runif(numCenters,0,100))
    cy <- round(runif(numCenters,0,100))
    x <- numeric(0)
    y <- numeric(0)
    tc <- numeric(0)
    for(i in 1:numCenters) {
      tc <- c(tc, rep(i, pts))
      x<-c(x, rnorm(pts, cx[i], dev))
      y<-c(y, rnorm(pts, cy[i], dev))
    }
    data.frame(x=x,y=y, tc=tc)
  })
  findCenters <- reactive({
    findCenters <- makeCentersFunc()
  })
  output$plot1 <- renderPlot({
    values <- reactiveValues()
    print("Render plot")
    df <- makeData()
    cl <- findCenters()(df)
    df$cl <- cl$cluster
    df$xc <- cl$centers[cl$cluster, "x"]
    df$yc <- cl$centers[cl$cluster, "y"]
    plot(x=df$x, y=df$y, xlab="", ylab="", col=clColor[df$cl], pch=19, cex=2)
    for(i in 1:nrow(df)) {
      lines(x=c(df[i,"x"],df[i,"xc"]), y=c(df[i,"y"],df[i,"yc"]), col=clColor[df[i,"cl"]])
    }
    points(x=df$x, y=df$y, col=tcColor[df$tc], pch=19, cex=1)
    points(cl$centers, col=clColor, pch=19)
    
  })
})

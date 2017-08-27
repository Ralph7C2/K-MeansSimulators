#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("K-Means Clustering Simulator"),
    sidebarPanel(
      tags$form(
        h3("Random points paramters"),
        sliderInput("randomPoints", "How many data points per center?", 10, 50, 10, step=5),
        sliderInput("randomCenters", "How many centers?", 1, 5, 2, step=1),
        sliderInput("randomDeviation", "Spread of points?", 1, 10, 5, step=.5),
        actionButton("randomButton", "Generate Points")
      ),
      tags$form(
        h3("K-Means parameters"),
        sliderInput("kmeansCenters","Number of centers?", 1, 5, 2, step=1),
        actionButton("clusterButton", "Find Clusters")
      )
    ),
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plot1", click="plot_click"),
       p("Hello, welcome to the K-Means clustering simulator! Use the panel on
         the side to set the parameters. The upper panel sets the parameters
         used in generating the random points, click the button to generate a
         new set of points.  The lower panel sets how many clusters to use in
         the k-means cluster algorithm, click the button to re-run the algorithm.
         K-means uses random starting points it is non-deterministic, you can
         get different results by re-running the algoritm on the same data."),
       p("The outer color of the point and the color of the line represents which
         cluster the point was found to be in, the inner color represents which
         cluste it was generated for.  The lines connect to the center of the cluster"),
       br(),
       strong("Created by Ralph Landon, 2017-08-19")
    )
  )
)
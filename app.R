# Load necessary libraries
library(shiny)
library(refund)
library(ggplot2)

# Define the UI for the application
ui <- fluidPage(
  titlePanel("FPCA Analysis using fpca.sc()"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", 
                  choices = c("cd4")),  # Add more datasets or change these as needed
      numericInput("n_fpcs", "Number of FPCs:", min = 1, max = 10, value = 5),
      numericInput("nbasis", "Number of Bases:", min = 1, max = 10, value = 5),
      actionButton("run_analysis", "Run Analysis")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Data", plotOutput("data_plot")),
        tabPanel("Eigenfunction", plotOutput("eigen_plot")),
        tabPanel("Mean Function", plotOutput("mean_plot"))
      )
    )
  )
)

# Define the server logic 
server <- function(input, output) {
  
  observeEvent(input$run_analysis, {
    data_to_use <- get(input$dataset)
    
    # Do your FPCA analysis on the dataset using fpca.sc()
    # Note: The following is just an example, adjust as per the dataset structure and needs
    result <- fpca.sc(data_to_use, nbasis = input$nbasis, npc= input$n_fpcs)
    
    # Plot the data
    output$data_plot <- renderPlot({
      # Each subject has multiple entries, one for each time point
      data <- data.frame(
        subject = rep(1:nrow(result$Yhat), each = ncol(result$Yhat)),  # 10 subjects
        time = rep(result$argvals, times = nrow(result$Yhat)),
        value = as.vector(result$Yhat)  # Some random values for this example
      )
      library(ggplot2)
      
      p <- ggplot(data, aes(x = time, y = value, group = subject, color = as.factor(subject))) + 
        geom_line() +  
        labs(title = "FPC approximation of Functional Data for All Subjects",
             x = "Time",
             y = "Value",
             color = "Subject") + 
        theme(legend.position = "none")  # This line removes the legend
      
      print(p)
      
      
      
    })
    
  
    
    output$mean_plot <- renderPlot({
      Fit.mu = data.frame(mu = result$mu,
                          d = as.numeric(colnames(data_to_use)))
      ggplot(Fit.mu, aes(x = d, y = mu)) + geom_path()})
    
    output$eigen_plot <- renderPlot({
      Fit.basis = data.frame(phi = result$efunctions,
                             d = as.numeric(colnames(data_to_use)))
      Fit.basis.m = melt(Fit.basis, id = 'd')
      ggplot(subset(Fit.basis.m, variable %in% paste0('phi.', 1:input$n_fpcs)), aes(x = d,
                                                                                  y = value, group = variable, color = variable)) + geom_path()
    })
    
    

  })
}

# Run the application 
shinyApp(ui = ui, server = server)


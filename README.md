# FPCA Analysis Shiny App

## Overview

This Shiny application provides an interactive interface for Functional Principal Component Analysis (FPCA) using the `fpca.sc()` function from the `refund` package. Users can select datasets, specify the number of Functional Principal Components (FPCs), and determine the number of bases for the analysis.

The app offers three main tabs for visualization:

1. **Data**: Shows the original functional data for all subjects.
2. **Eigenfunction**: Visualizes the eigenfunctions obtained from FPCA.
3. **Mean Function**: Displays the mean function of the functional data.

## Instructions

### Prerequisites

Ensure that you have installed the required R packages:

```R
install.packages(c("shiny", "ggplot2", "refund", "reshape2"))
```

## Running the App

1. **Launch the app script in R or RStudio**.

2. **On the left side of the app**:
    - Use the dropdown menu to **Choose a dataset**.
    - Select the desired **Number of FPCs**.
    - Select the **Number of Bases**.
    - Click the **Run Analysis** button to perform the FPCA analysis and view the visualizations.

3. **Navigate between the tabs** to view different visualizations:
    - **Data**: Displays the functional data.
    - **Eigenfunction**: Shows the eigenfunctions.
    - **Mean Function**: Provides the mean function visualization.

## Adjustments and Extensibility

### Adding More Datasets
To add more datasets to the app, include them in the `choices` argument of the `selectInput()` function within the `ui` definition.

```R
selectInput("dataset", "Choose a dataset:", 
            choices = c("cd4", "another_dataset_name"))
```



## Customizing the Plots
You can further customize the appearance and functionalities of the plots by adjusting the `ggplot` plotting code within the `server` function.

## References

- Ramsay, J.O., Silverman, B.W. (2005). *Functional Data Analysis*. Springer.
  
- Crainiceanu, C. M., Goldsmith, A. J., & Reich, D. S. (2015). *bayesGAM: Bayesian multivariate adaptive splines for functional data*. R package version 2.1.

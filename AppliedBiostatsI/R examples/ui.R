library(shiny)

###########################################################
## Shiny app to visualize a t test
## 
## @author Alain Hauser <alain.hauer@bfh.ch>
## @date 2015-11-09
###########################################################

shinyUI(fluidPage(
  withMathJax(),
  
  # Application title
  titlePanel("One-sample t-test"),
  
  "By",
  a("Alain Hauser", href = "https://staff.ti.bfh.ch/hsa2/"),
  
  sidebarLayout(
    # Sidebar panel: sliders and buttons to specify H_0 and sample
    sidebarPanel(
      h3("Hypotheses"),
      sliderInput("mu0",
                  "Null hypothesis:",
                  min = -3,
                  max = 3,
                  step = 0.2,
                  value = 0),
      radioButtons("alternative",
                   "Alternative hypothesis:",
                   choices = list("μ ≠ μ0" = "two.sided", 
                                  "μ < μ0" = "less", 
                                  "μ > μ0" = "greater"),
                   selected = "two.sided"),
      sliderInput("alpha",
                  "Significance level (%)",
                  min = 1,
                  max = 10,
                  value = 5),
      radioButtons("show",
                   "Show:",
                   choices = list("Range of rejection" = "reject", "p-value" = "pval"),
                   selected = "reject"),
      h3("Sample"),
      sliderInput("n",
                  "Sample size:",
                  min = 2,
                  max = 40,
                  value = 10),
      sliderInput("xbar",
                  "Sample mean:",
                  min = -2,
                  max = 2,
                  step = 0.2,
                  value = 0),
      sliderInput("sx",
                  "Sample standard dev.:",
                  min = 0.1,
                  max = 5,
                  value = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Test statistic under null hypothesis"),
      plotOutput("tStatPlot"),
      h3("Confidence interval for μ"),
      plotOutput("confidencePlot")
    )
  )
))

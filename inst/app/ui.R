library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("CUSP resilience assessment"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(

      conditionalPanel(
        'input.out === "Dataset"',

      # dataTableOutput('mytable'),
        fileInput('file', '1. Choose file to upload',
                  accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv'
                )
        ),
      checkboxInput('header', 'Header', TRUE),
      selectInput('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      actionButton("choice", "2. Load data"),
      hr(),
      selectInput("state", "3. Select State variable", choices = NULL), # no choices before uploading
      selectInput("stA", "4. Select Stressor alpha", choices = NULL),
      selectInput("stB", "5. Select Stressor beta", choices = NULL)
      ),


      conditionalPanel(
        'input.out === "Simulation"',

      # Alpha
      selectInput("alptype", "1. Simulation of Alpha",
                  choices = list("Gaussian"="rn",
                                 "Autocorrelated"="ar"),
                  selected = "ar"),
      conditionalPanel("input.alptype == 'ar'",
                       sliderInput("alpar",
                                   "Autocorrelation",
                                   min = 0,
                                   max = 1,
                                   value = 0.9,
                                   step=0.05)
                       ),
      conditionalPanel("input.alptype == 'rn'",
                       sliderInput("alpu",
                                   "Mean",
                                   min = -2,
                                   max = 2,
                                   value = 0,
                                   step=0.1),
                       sliderInput("alpsd",
                                   "SD",
                                   min = 0.5,
                                   max = 10,
                                   value = 1,
                                   step=0.5)
                        ),

      hr(),
      # Beta
      selectInput("bettype", "2. Simulation of Beta",
                  choices = list("Gaussian"="rn",
                                 "Autocorrelated"="ar"),
                  "Gaussian"),
      conditionalPanel("input.bettype == 'ar'",
                       sliderInput("betar",
                                   "Autocorrelation",
                                   min = 0,
                                   max = 1,
                                   value = 0.9,
                                   step=0.05)
      ),
      conditionalPanel("input.bettype == 'rn'",
                       sliderInput("betu",
                                   "Mean",
                                   min = -2,
                                   max = 2,
                                   value = 0,
                                   step=0.1),
                       sliderInput("betsd",
                                   "SD",
                                   min = 0.5,
                                   max = 10,
                                   value = 1,
                                   step=0.5)
      ),
      hr(),
      numericInput("nstep", "3. Length of the time series:", 50)#,
      # sliderInput("nrep",
      #             "Number of repetions (if any)",
      #             min = 1,
      #             max = 10,
      #             value = 1,
      #             step=1),
    ),

    conditionalPanel(
      'input.out === "Documentation"',

      h4("Work in progress"),
      strong("Not for distribution!"),
      hr(),
      p("By Camilla Sguotti, Romain Frelat, Paris Vasilakopoulos, Evangelos Tzanatos, and Christian Möllmann"),
      hr(),
      div("Last update: 30th May 2022")

    )
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        id = 'out',
        tabPanel("Dataset", plotOutput("showCUSP", width="600px", height = "500px")),
        tabPanel("Simulation", plotOutput("simuPlot", width="600px", height = "500px")),
        tabPanel("Documentation", htmlOutput("renderedReport"))
      )
    )

    # # Show a plot of the generated distribution
    # mainPanel(
    #   plotOutput("distPlot", width="500px", height = "600px")
    # )
  )
))

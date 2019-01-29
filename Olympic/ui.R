




# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel(div("Olympic Game History", img(height = 120, width = 700, src = "olympic.jpg"))),
  
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       #sliderInput("bins",
                   #"Number of bins:",
                   #min = 1,
                   #max = 50,
                   #Value = 30),
       strong("Medal"),
       checkboxGroupInput("Medals", label = NULL,
                          choices = list("Gold", "Silver", "Bronze"),
                          selected = "Gold"),
       strong("Gender"),
       checkboxGroupInput("Gender", label = NULL,
                          choices = list("Female" = "F", "Male" = "M"),
                          selected = "F"),
       strong("Age"),

       sliderInput("Age", label = NULL, width="100%",
                   min = min(data$Age), max = max(data$Age), value = c(min(data$Age),max(data$Age)), step = 1),
       strong("Years"),
       sliderInput("O_year", label = NULL, width = "100%",
                   min = min(data$Year), max = max(data$Year), value = c(min(data$Year), max(data$Year))),
       
       pickerInput("nations", label = "Nations", choices = sort(unique(data$Team)), 
                   options = list(`actions-box` = TRUE),  multiple = TRUE, selected = sort(unique(data$Team)  )),
       
       pickerInput("sports", label = "Sports", choices = sort(unique(data$Sport)), 
                   options = list(`actions-box` = TRUE), 
                   multiple = TRUE, selected = sort(unique(data$Sport)))#,
      # pickerInput("TOP", label = "rank", choices = c(1,10,50,100), multiple = FALSE, selected = 1)
       
       
       
       
       ),
    
    mainPanel(
      fluidRow(
        column(width = 8, 
               tabsetPanel(
                 tabPanel(
          "Medal Count", 
          plotOutput("count", height =1000)),
          tabPanel(
            "World Map",
            plotlyOutput("WorldMap" ,height = 700)
          )
        )
        )
      )
    )
  )
)
)

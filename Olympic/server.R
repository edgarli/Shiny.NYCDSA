


# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
  
  filter_1 <- reactive({
    data %>% filter(Medal %in% input$Medals, Sex %in% input$Gender,
                    Age >= input$Age[1] & Age <= input$Age[2], 
                    Team %in% input$nations, Year >= input$O_year[1] & Year <= input$O_year[2],
                    Sport %in% input$sports)

  })
  #top <- reactive({
    #as.integer(input$TOP)
    
  #})

  #observe(print(class(top())))
   
  output$count <- renderPlot({
    data2 <- left_join(filter_1(), data1, by = "NOC")
    print(data2)
      
    medal_count <- data2 %>% 
      group_by(region,Team,Medal) %>% 
      summarize(Count = length(Medal)) #%>%
      #top_n(top(),Count)
    #print(medal_count)
    
    #print(medal_count)
    Rank <- medal_count %>% group_by(region) %>% 
      summarize(Total=sum(Count)) %>%
      arrange(Total) %>%
      select(region)
      
    #print(Rank)
      
    medal_count$region <- factor(medal_count$region, levels= Rank$region)
    
    #medal_count %>% top_n(top())
     
    ggplot(medal_count, aes(x= region, y = Count , fill = Medal)) + 
      labs(title = "Rank") +
      xlab("Countries") + ylab("Number of Medals") +
      geom_col() + coord_flip() + 
      scale_fill_manual(values = c("gold","lightgray","orange4")) + 
      theme(plot.title = element_text(hjust = 0.5))
    
     

    
  })
  output$WorldMap <- renderPlotly({
    data2 <- left_join(filter_1(), data1, by = "NOC")
    medal_count <- data2 %>%
    group_by(region,NOC,Medal) %>% 
    summarize(Count = length(Medal))%>% 
    group_by(region, NOC) %>% 
    summarize(Total = sum(Count))
    #print(medal_count)
    
    World_map <- plot_geo(medal_count) %>% 
      add_trace(z = ~Total, color = ~Total, colors = "Purples",text = ~region, locations = ~NOC 
                , marker = list(line = list(color = "black", width = 0.5))) %>%
      colorbar("Medals") %>%
      layout(title = "Word Map visulize medal results" ,geo = list(showframe = FALSE, showcoastlines = TRUE, 
                        projection = list(type = 'Equirectangular')
      ) )
      
    
    
    
  })
  
})

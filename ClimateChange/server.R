#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# remove all variables from the workspace
rm(list = ls(all = TRUE))

# close all previous plots
while (!is.null(dev.list())) dev.off()

# import library
library(shiny)
library(tidyverse)
library(shinyjs)
library(plotly)

# read dataset
Temperature_Summary <- read_csv('Temperature_Summary.csv')
AllSnow_Summary <- read_csv('AllSnow_Summary.csv')
AllPrecip_Summary <- read_csv('AllPrecip_Summary.csv')
Co2World_Summary <- read_csv('Co2World_Summary.csv')
Co2North_Summary <- read_csv('Co2North_Summary.csv')
MeanTemp_Summary_prov_anomaly <- read_csv('MeanTemp_Summary_prov_anomaly.csv')

shinyServer(function(input, output) {
  # Data Visualization Tab
  output$CO2Plot <- renderPlotly({
    if(input$co2_options=="Worldwide"){
      data <- Co2World_Summary %>% 
        filter((Year >= input$start_year_co2) & (Year <= input$end_year_c02))
      ggplot(data = data,
             aes(x = Year, y = Value)) +
        geom_point() +
        geom_line() +
        geom_smooth(color = 'blue',method = 'lm') +
        xlab("Year") +
        ylab('Carbon Dioxide (ppm)') +
        ggtitle("Worlwide Carbon Dioxide (ppm) by Year")+theme_light()}
    else if(input$co2_options=="Northern Hemisphere"){
      data <- Co2North_Summary %>% 
        filter((Year >= input$start_year_co2) & (Year <= input$end_year_c02))
      ggplot(data = data,
             aes(x = Year)) +
        geom_line(aes(y = Latitude30value, colour = "Latitude30"))+
        geom_line(aes(y = Latitude33value, colour = "Latitude33"))+
        geom_line(aes(y = Latitude37value, colour = "Latitude37"))+
        geom_line(aes(y = Latitude41value, colour = "Latitude41"))+
        geom_line(aes(y = Latitude44value, colour = "Latitude44"))+
        geom_line(aes(y = Latitude49value, colour = "Latitude49"))+
        geom_line(aes(y = Latitude53value, colour = "Latitude53"))+
        geom_line(aes(y = Latitude58value, colour = "Latitude58"))+
        geom_line(aes(y = Latitude64value, colour = "Latitude64"))+
        geom_line(aes(y = Latitude72value, colour = "Latitude72"))+
        geom_line(aes(y = Latitude90value, colour = "Latitude90"))+
        scale_colour_manual("", 
                            values = c("Latitude30"=1, 
                                       "Latitude33"=2, 
                                       "Latitude37"=3,
                                       "Latitude41"=4,
                                       "Latitude44"=5,
                                       "Latitude49"=6,
                                       "Latitude53"=7,
                                       "Latitude58"=8,
                                       "Latitude64"=9,
                                       "Latitude72"=10,
                                       "Latitude90"=11
                                       )
                            ) +
        xlab("Year") +
        ylab('Carbon Dioxide (ppm)') +
        ggtitle("Northern Hemisphere Carbon Dioxide (ppm) by Year and Lattitude")+theme_light()}
    })
  output$TemperaturePlot <- renderPlotly({
    if(input$weather_options=="Temperature"){
        if(input$trend){
        data <- Temperature_Summary %>% 
          filter((Year >= input$start_year_weather) & (Year <= input$end_year_weather))
        temperaturePlot <- ggplot(data = data, aes(x = Year))+
          geom_point(aes(y=Annual_MeanTemp, color = "Average Temp"))+
          geom_line(aes(y=Annual_MeanTemp, color = "Average Temp"))+
          geom_smooth(aes(y=Annual_MeanTemp, color = "Average Temp"))+
          geom_point(aes(y=Annual_MinTemp, color = "Min Temp"))+
          geom_line(aes(y=Annual_MinTemp, color = "Min Temp"))+
          geom_smooth(aes(y=Annual_MinTemp, color = "Min Temp"))+
          geom_point(aes(y=Annual_MaxTemp, color = "Max Temp"))+
          geom_line(aes(y=Annual_MaxTemp, color = "Max Temp"))+
          geom_smooth(aes(y=Annual_MaxTemp, color = "Max Temp"))+
          scale_colour_manual("", 
                              values = c("Average Temp"=1, 
                                         "Min Temp"=2, 
                                         "Max Temp"=3
                              )
          ) +
          xlab("Year") +
          ylab('Temperature (Celcius)') +
          ggtitle("Canada Temperature by Year")
        temperaturePlot+theme_light()}
      else{
        data <- Temperature_Summary %>% 
          filter((Year >= input$start_year_weather) & (Year <= input$end_year_weather))
        temperaturePlot <- ggplot(data = data, aes(x = Year))+
          geom_point(aes(y=Annual_MeanTemp, color = "Average Temp"))+
          geom_line(aes(y=Annual_MeanTemp, color = "Average Temp"))+
          geom_point(aes(y=Annual_MinTemp, color = "Min Temp"))+
          geom_line(aes(y=Annual_MinTemp, color = "Min Temp"))+
          geom_point(aes(y=Annual_MaxTemp, color = "Max Temp"))+
          geom_line(aes(y=Annual_MaxTemp, color = "Max Temp"))+
          scale_colour_manual("", 
                              values = c("Average Temp"=1, 
                                         "Min Temp"=2, 
                                         "Max Temp"=3
                              )
          ) +
          xlab("Year") +
          ylab('Temperature (Celcius)') +
          ggtitle("Canada Temperature by Year")
        temperaturePlot+theme_light()}
      }
  })
  output$PrecipitationPlot <- renderPlotly({
     if (input$weather_options=="Precipitation"){
       if(input$trend){
        data <- AllPrecip_Summary %>% 
          filter((Year >= input$start_year_weather) & (Year <= input$end_year_weather))
        precipitationPlot <- ggplot(data = data, aes(x = Year))+
          geom_point(aes(y=Annual_AllPrecip))+
          geom_line(aes(y=Annual_AllPrecip))+
          geom_smooth(aes(y=Annual_AllPrecip),color = 'blue',method = 'lm') +
          xlab("Year") +
          ylab('Total Precipitation (millimetres)') +
          ggtitle("Canada Total Precipitation by Year")
        precipitationPlot+theme_light()}
       else{
         data <- AllPrecip_Summary %>% 
           filter((Year >= input$start_year_weather) & (Year <= input$end_year_weather))
         precipitationPlot <- ggplot(data = data, aes(x = Year))+
           geom_point(aes(y=Annual_AllPrecip))+
           geom_line(aes(y=Annual_AllPrecip))+
           xlab("Year") +
           ylab('Total Precipitation (millimetres)') +
           ggtitle("Canada Total Precipitation by Year")
         precipitationPlot+theme_light()
       }
     }
  })
  output$SnowPlot <- renderPlotly({
    if (input$weather_options=="Snow"){
      if(input$trend){
        data <- AllSnow_Summary %>% 
          filter((Year >= input$start_year_weather) & (Year <= input$end_year_weather))
        snowPlot <- ggplot(data = data, aes(x = Year))+
          geom_point(aes(y=Annual_AllSnow))+
          geom_line(aes(y=Annual_AllSnow))+
          geom_smooth(aes(y=Annual_AllSnow),color = 'blue',method = 'lm')+
          xlab("Year") +
          ylab('Total Snow (millimetres)') +
          ggtitle("Canada Total Snow by Year")
        snowPlot+theme_light()}
      else{
        data <- AllSnow_Summary %>% 
          filter((Year >= input$start_year_weather) & (Year <= input$end_year_weather))
        snowPlot <- ggplot(data = data, aes(x = Year))+
          geom_point(aes(y=Annual_AllSnow))+
          geom_line(aes(y=Annual_AllSnow))+
          xlab("Year") +
          ylab('Total Snow (millimetres)') +
          ggtitle("Canada Total Snow by Year")
        snowPlot+theme_light()
      }
    }
  })
  output$CO2Data <- renderUI(HTML(paste("Datasets Reference:", "
                                            Dlugokencky, E.J., K.W. Thoning,
                                             P.M. Lang, and P.P. Tans (2017), NOAA Greenhouse Gas Reference from
                                             Atmospheric Carbon Dioxide Dry Air Mole Fractions from the NOAA ESRL
                                             Carbon Cycle Cooperative Global Air Sampling Network.", sep="<br/>")))
  output$weatherData <- renderUI(HTML(paste("Datasets Reference:", 
"Mekis, É. and L.A. Vincent, 2011: An overview of the second generation adjusted daily precipitation dataset for trend analysis in Canada. Atmosphere-Ocean, 49(2), 163-177.", 
"Vincent, L. A., X. L. Wang, E. J. Milewska, H. Wan, F. Yang, and V. Swail, 2012. A second generation of homogenized Canadian monthly surface air temperature for climate trend analysis, J. Geophys. Res., 117, D18110, doi:10.1029V2012JD017859.",
"Wan, H., X. L. Wang, V. R. Swail, 2010: Homogenization and trend analysis of Canadian near-surface wind speeds. Journal of Climate, 23, 1209-1225.",
"Wan, H., X. L. Wang, V. R. Swail, 2007: A quality assurance system for Canadian hourly pressure data. J. Appl. Meteor. Climatol., 46, 1804-1817. ",
"Wang, X.L, Y. Feng, L. A. Vincent, 2013. Observed changes in one-in-20 year extremes of Canadian surface air temperatures. Atmosphere-Ocean. Doi:10.1080V07055900.2013.818526.",
sep="<br/>")))
  # Climate Change Analysis Tab
  # observeEvent(input$tab == "Data Analysis", {
  #   shinyjs::hide(id = "Sidebar")
  # })
  output$figure1 <- renderPlotly({
    data <- Temperature_Summary %>% 
      filter((Year >= 1977) & (Year <= 2017)) %>% 
      mutate(anomaly = Annual_MeanTemp - mean(Annual_MeanTemp, na.rm = TRUE)) %>% 
      select(Year, Annual_MeanTemp, anomaly)
    ggplot(data = data, aes(x= Year, y=anomaly))+
      geom_point()+
      geom_line()+
      geom_smooth()+
      labs(title ="Canada Temperature, 40 years range  from 1977 to 2017", caption = "Figure 1")+
      labs(x="Year",y="Temperature Anomaly (Celcius)")+theme_light()
  })
  output$figure2 <- renderPlotly({
    data <- MeanTemp_Summary_prov_anomaly
    ggplot(data= data, aes(x=Province, y = anomaly, fill=Province))+
      geom_col()+
      geom_text(aes(label=round(anomaly,2),hjust=0, vjust=0))+
      ggtitle("Canada's Province Temperature Anomaly, 40 years range  from 1977 to 2017")+
      labs(x="Province",y="Temperature Anomaly (Celcius)", caption = "Figure 2")+theme_light()
  })
  output$figure3 <- renderPlotly({
    data <- Co2World_Summary %>% 
      filter((Year >= 1977) & (Year <= 2017))
    ggplot(data = data, aes(x= Year, y=Value))+
      geom_point()+
      geom_line()+
      geom_smooth()+
      ggtitle("Carbon Dioxide (Worlwide) Concentration, 30 years range from 1987 to 2017")+
      labs(x="Year",y="CO2 Concentration (ppm)")+theme_light()
  })
  observe({
    if (input$tab == "Data Analysis" | input$tab == "About") {
      shinyjs::hide(id = "Sidebar")
    } else {
      shinyjs::show(id = "Sidebar")
    }
  })
})


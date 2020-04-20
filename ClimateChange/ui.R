#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(plotly)

shinyUI(fluidPage(
  useShinyjs(),
  # Application title
  h1("Climate Change Dashboard"),
  h4("Coursera: Developing Data Products Course Project"),
  
  # Sidebar
  sidebarLayout(
    div(id ="Sidebar",sidebarPanel(
      HTML("<h3> Options for Data Visualization tab </h3>"),
      radioButtons(inputId = "data",
                   label = "Select Datasets:",
                   choices = c("CO2 Data","Weather Data"),
                   selected = "CO2 Data"),
      conditionalPanel(
        condition = "input.data == 'CO2 Data'",
        selectInput(inputId = "start_year_co2",
                    label = "Starting Year",
                    choices = 1979:2017,
                    selected = 1979),
        selectInput(inputId = "end_year_c02",
                    label = "Ending Year",
                    choices = 1979:2017,
                    selected = 2017),
        radioButtons(inputId = "co2_options",
                     label = "Select the CO2 Data you want to display:",
                     choices = c("Worldwide","Northern Hemisphere"),
                     selected = "Worldwide")
      ),
      conditionalPanel(
        condition = "input.data == 'Weather Data'",
        selectInput(inputId = "start_year_weather",
                    label = "Starting Year",
                    choices = 1840:2017,
                    selected = 1840),
        selectInput(inputId = "end_year_weather",
                    label = "Ending Year",
                    choices = 1840:2017,
                    selected = 2017),
        radioButtons(inputId = "weather_options",
                           label = "Select the Weather Data you want to display:",
                           choices = c("Temperature","Precipitation","Snow"),
                           selected = "Temperature"),
        checkboxInput(inputId= 'trend',label = strong('Show the Trend Line?'))
    ),
    # Built with Shiny by RStudio
    br(), br(),
    h5("Built with",
       img(src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", height = "30px"),
       "by",
       img(src = "https://www.rstudio.com/wp-content/uploads/2014/07/RStudio-Logo-Blue-Gray.png", height = "30px"),
       ".")
    )),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(id="tab",type = "tabs",
          tabPanel("Data Visualization",
           HTML("<h2> Climate Change Exploratory Data Analysis </h2>"),
            conditionalPanel(
              condition = "input.data == 'CO2 Data'",
              plotlyOutput("CO2Plot"),
              htmlOutput("CO2Data")
            ),
            conditionalPanel(
              condition = "input.data == 'Weather Data'",
                conditionalPanel(
                  condition = "input.weather_options == 'Temperature'",
                  plotlyOutput("TemperaturePlot")
                ),
                conditionalPanel(
                  condition = "input.weather_options == 'Precipitation'",
                  plotlyOutput("PrecipitationPlot")
              ),
                conditionalPanel(
                  condition = "input.weather_options == 'Snow'",
                  plotlyOutput("SnowPlot")
                ),
              htmlOutput("weatherData")
      )),
        tabPanel("Data Analysis",
                  HTML("<h2> Climate Change Analysis </h2>
                  <h3> Motivation: </h2>
                  <p> Greenhouse gases play an important role in determining global temperatures and climate patterns due to their capacity to retain heat.
                       As these gases trap heat, increases in greenhouse gas concentrations should correlate with an increase in global temperature.
                       Long term weather patterns (climate) also influenced by greenhouse gas concentrations.</p>
                  <p>  The goal of this project is to analyze and provide evidence of climate change.
                       The datasets that are used consist of two parts: CO2 data (worldwide and northern hemisphere) and Canadian weather data (temperature, snow, and precipitation).
                       Specifically, the timeline of the analysis 40-year range from 1977 to 2017 for weather data and 30-year range from 1987 to 2017 for CO2 data.</p>
                  <h3> Symptoms: Signs of climate change </h3>
                  <p> Let's start by analyzing Canada's temperature in 40 years. Air temperature is recorded at weather stations and by weather baloon.
                      In climate change studies, temperature anomalies are more important than absolute temperature. 
                      A temperature anomaly is the difference from an average, or baseline, temperature.
                      To get the anomaly data, we substract each annual mean temperature to it's baseline, the baseline that we use in this data is using the annual 40-year temperature average.
                      A positive anomaly indicates the observed temperature was warmer than the baseline, while a negative anomaly indicates the observed temperature was cooler than the baseline.
                      Figure 1 illustrate the Canada temperature changes over 40 years.
                       "),
                 plotlyOutput("figure1"),
                 HTML("From figure 1, we can see the trend that Canada temperature is getting warmer over time, especially since last decade. 
                      Two of the highest temperature increase occurs in 2010 (1.49°C increase) and 2016 (1.33°C increase).
                      In terms of province, figure 2 display the temperature anomaly by Canada province using 40-year average as the baseline. 
                      Most of the province is getting warmmer than the baseline, with British Columbia and Nova Scotia have the highest incerase. 
                      Temperature increase is one of  possible sign of climate change, other events such as rise in the sea level and precipitation level as well as more frequent extreme weather conditions
                      ."),
                 plotlyOutput("figure2"),
                 HTML("<h3> Cause: Increase in CO2 concentration caused by human activity </h3>
                      <p>Increase in the carbon dioxide concentration is the primary reason that explain Earth’s observed warming trend. 
                      CO2 is one of Greenhouse gases, they are called that because they effectively act like a layer of insulation for the Earth: they trap heat and warm the planet.
                      The rise of C02 concentration is caused by burning fossil fuels by humans through various of their activities. 
                      Figure 3 display the historical CO2 concentration (worldwide) over 30 years from 1987 to 2017.
                      The plot implies sharp increase in the C02 concentrations, with 20% increase happening since 1987 to 2017.
                      </p>
                      "),
                 plotlyOutput("figure3"),
                 HTML("<h3>Conclusion:</h3>
                      <p> Both the temperature increase and rise of C02 concentration is real and we might think that is not a big deal for human life, it is!
                          These result is not only happening in Canada but global wide means it can translate into massive real-world impacts.
                          Climate is essential to human life as it determines how we live, for example we are dependent on predictable weather for our living (places that we live).
                          We need to take actions to prevent climate change from getting worse and we need to start today.
                      
                      ")
                 ),
        tabPanel("About",source("about.R")$value())
      )
    )
  )
))

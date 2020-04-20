function(){
  tabPanel("About",
           # Part 1
           HTML("
                <h3> About the project: </h2>
                <p> The project is about analyzing climate change data.The Earth's climate has changed throughout history. 
                Given both the CO2 and Canadian weather datasets (temperature, precipitation and snow), we want to analyze how each of the driver of climate change varied over time. </p>
                <p> In terms of techincal skill, the project introduce the author to create a dashboard and a web application using Shiny via R.
                In addition, the user of this application can have the flexibility to choose plot and / or analysis to show the climate change information. </p>
                <h3> CO2 Datasets Reference: </h3>
                <ul>
                    <li> Dlugokencky, E.J., K.W. Thoning,
                                             P.M. Lang, and P.P. Tans (2017), NOAA Greenhouse Gas Reference from
                                             Atmospheric Carbon Dioxide Dry Air Mole Fractions from the NOAA ESRL
                                             Carbon Cycle Cooperative Global Air Sampling Network.</li>
                </ul>
                <h3> Weather Datasets Reference: </h3>
                <ul>
                    <li> Mekis, É. and L.A. Vincent, 2011: An overview of the second generation adjusted daily precipitation dataset for trend analysis in Canada. Atmosphere-Ocean, 49(2), 163-177.</li>
                    <li> Vincent, L. A., X. L. Wang, E. J. Milewska, H. Wan, F. Yang, and V. Swail, 2012. A second generation of homogenized Canadian monthly surface air temperature for climate trend analysis, J. Geophys. Res., 117, D18110, doi:10.1029V2012JD017859.</li>
                    <li> Wan, H., X. L. Wang, V. R. Swail, 2010: Homogenization and trend analysis of Canadian near-surface wind speeds. Journal of Climate, 23, 1209-1225.</li>
                    <li> Wan, H., X. L. Wang, V. R. Swail, 2007: A quality assurance system for Canadian hourly pressure data. J. Appl. Meteor. Climatol., 46, 1804-1817.</li>
                    <li> Wang, X.L, Y. Feng, L. A. Vincent, 2013. Observed changes in one-in-20 year extremes of Canadian surface air temperatures. Atmosphere-Ocean. Doi:10.1080V07055900.2013.818526</li>
                </ul>
           "),
           value="about"
           )
}

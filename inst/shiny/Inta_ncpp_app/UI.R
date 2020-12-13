full <- utils::read.csv("https://health-infobase.canada.ca/src/data/covidLive/covid19-download.csv", header=TRUE,sep=",",as.is=TRUE,stringsAsFactors = FALSE)
Byprov<- subset(full, prname != "Canada")
Byprov[is.na(Byprov)] <- 0
Byprov$date<-lubridate::ymd(Byprov$date)
#"New Cases of COVID-19 plots of Canada "
ui <- fluidPage(
  
  fluidRow(column(12,
                  shinyWidgets::sliderTextInput("stopdate",
                                  label = h5("Select the end date"),
                                  choices = as.Date(unique(Byprov$date)),
                                  selected=NULL,
                                  grid = TRUE,
                                  animate=animationOptions(interval = 2000, loop = FALSE)))),
  fluidRow(column(6, OFFSET=6,    
                  selectInput("cop",
                              label = h5("Select the province name"),
                              choices = c("Alberta", "British Columbia","Manitoba","Nunavut","Northwest Territories",
                                          "Prince Edward Island","Nova Scotia","Newfoundland and Labrador","Repatriated travellers","Saskatchewan","Ontario","Quebec","Yukon")))
  ),
  fluidRow(column(12,
                  plotOutput(outputId = "nc_curve")))
)
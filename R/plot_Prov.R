##' @description Show the new cases/new deaths/cumulative cases from the day the first case occured to a chosen day in the chosen Canada province.
##' 
##' @title New cases/New deaths/Cumulative cases by day in Canada province
##' @name plot_Prov
##' @author Yujie & Jiahui
##' @usage plot_Prov(province,stopdate,type)
##' @param province the province of Canada (List: "Nunavut","Northwest Territories", "Quebec","Newfoundland and Labrador", 
##' "New Brunswick", "Nova Scotia", "Prince Edward Island", "Yukon", "Ontario", "Manitoba", "Saskatchewan", "	Alberta", "British Columbia") Double quotes are required.
##' @param stopdate "yyyy-mm-dd" Double quotes are required. (eg. "2020-06-21")
##' @param type "New", "Deaths", "Cumulative" Double quotes are required.
##' @return A line chart of new cases/new deaths/cumulative cases from the day the first case occured to a chosen day in the chosen Canada province.
##' @import ggplot2
##' @export
##' @examples 
##' plot_Prov("Manitoba","2020-06-10","New")
##' plot_Prov("Alberta","2020-09-10","Deaths")
##' plot_Prov("British Columbia","2020-12-10","Cumulative")
#utils::globalVariables(c("prname","numtoday", "numdeaths", "numtotal"))
plot_Prov <- function(province,stopdate,type){
  full <- utils::read.csv("https://health-infobase.canada.ca/src/data/covidLive/covid19-download.csv", header=TRUE, sep=",",as.is=TRUE,stringsAsFactors = FALSE)
  Byprov <- subset(full, prname != "Canada")
  Byprov[is.na(Byprov)] <- 0
  Byprov$date<-lubridate::ymd(Byprov$date)
  if(type=="New"){
    stopdate<-lubridate::ymd(stopdate)
    sub_pro<-subset(Byprov, prname == province & date<=stopdate)
    ggplot(sub_pro,aes(x=date,y=numtoday))+geom_point(na.rm=TRUE)+geom_line()+ylab("Number of New Cases")
     
  }
  else if(type=="Deaths"){
    stopdate<-lubridate::ymd(stopdate)
    sub_pro<-subset(Byprov, prname == province & date<=stopdate)
    ggplot(sub_pro,aes(x=date,y=numdeaths))+geom_point(na.rm=TRUE)+geom_line()+ylab("Number of Deaths")
  }
  else if(type=="Cumulative"){
    stopdate<-lubridate::ymd(stopdate)
    sub_pro<-subset(Byprov, prname == province & date<=stopdate)
    ggplot(sub_pro,aes(x=date,y=numtotal))+geom_point(na.rm=TRUE)+geom_line()+ylab("Number of Cumulative Cases")
  }
}


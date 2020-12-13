##' @description Show the new cases/new deaths/cumulative cases from the day the first case occured to a chosen day in Canada.
##' 
##' @title New cases/New deaths/Cumulative cases by day in Canada
##' @name plot_Ca
##' @author Yujie & Jiahui
##' @usage plot_Ca(stopdate,type)
##' @param stopdate "yyyy-mm-dd" Double quotes are required. (eg. "2020-06-21")
##' @param type "New", "Deaths", "Cumulative" Double quotes are required.
##' @return A line chart of the new cases/new deaths/cumulative cases from the day the first case occured to a chosen day in Canada.
##' @import ggplot2
##' @export
##' @examples 
##' plot_Ca("2020-06-12","New")
##' plot_Ca("2020-09-12","Cumulative")
##' plot_Ca("2020-11-12","Deaths")
#utils::globalVariables(c("prname","numtoday", "numconf", "numdeaths"))
plot_Ca <- function(stopdate,type){
  full <- utils::read.csv("https://health-infobase.canada.ca/src/data/covidLive/covid19-download.csv", header=TRUE,sep=",",as.is=TRUE,stringsAsFactors = FALSE)
  Canada <- subset(full, prname == "Canada")
  Canada[is.na(Canada)]<-0
  Canada$date<-lubridate::ymd(Canada$date)
  if (type=="New"){
    stopdate<-lubridate::ymd(stopdate)
    sub_pro_ca<-subset(Canada,date<=stopdate)
    ggplot(sub_pro_ca,aes(x=date,y=numtoday))+geom_point(na.rm=TRUE)+geom_line()+ylab("Number of New Cases")
  }
  else if (type=="Cumulative"){
    stopdate<-lubridate::ymd(stopdate)
  sub_pro_ca<-subset(Canada,date<=stopdate)
  ggplot(sub_pro_ca,aes(x=date,y=numconf))+geom_point(na.rm=TRUE)+geom_line()+ylab("Number of Cumulative Cases")
  }
  else if(type=="Deaths"){
    stopdate<-lubridate::ymd(stopdate)
    sub_pro_ca<-subset(Canada,date<=stopdate)
    ggplot(sub_pro_ca,aes(x=date,y=numdeaths))+geom_point(na.rm=TRUE)+geom_line()+ylab("Number of Deaths")
  }
}

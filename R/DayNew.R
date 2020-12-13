##' @description Showing a matrix of the new cases/deathes/recovered/tested of a chosen day in a chosen province of Canada.
##' 
##' @title Matrix of the new cases/deathes/recovered/tested
##' @name DayNew
##' @author Yujie & Jiahui
##' @usage DayNew(province,date)
##' @param province province the province of Canada (List: "Nunavut","Northwest Territories", "Quebec","Newfoundland and Labrador", 
##' "New Brunswick", "Nova Scotia", "Prince Edward Island", "Yukon", "Ontario", "Manitoba", "Saskatchewan", "	Alberta", "British Columbia") Double quotes are required.
##' @param date "yyyy-mm-dd" Double quotes are required. (eg. "2020-06-21") 
##' @return A matrix of new cases/deathes/recovered/tested of a chosen day in a chosen province of Canada.
##' @export
##' @examples 
##' DayNew("Ontario","2020-06-21")
#utils::globalVariables("prname")
DayNew<-function(province,date){
  full <- utils::read.csv("https://health-infobase.canada.ca/src/data/covidLive/covid19-download.csv", header=TRUE,sep=",",as.is=TRUE,stringsAsFactors = FALSE)
  Byprov<- subset(full, prname != "Canada")
  Byprov[is.na(Byprov)] <- 0
  Byprov$date<-lubridate::ymd(Byprov$date)
  date<-lubridate::ymd(date)
  PD_info <- Byprov[which(Byprov$prname ==province & Byprov$date==date),]
  Tx<-matrix(0,nrow=1,ncol=4)
  Tx<-as.data.frame(T,row.names="numbers")
  Tx[1]<-PD_info$numtoday
  Tx[2]<-PD_info$numdeathstoday
  Tx[3]<-PD_info$numrecoveredtoday
  Tx[4]<-PD_info$numtestedtoday
  names(Tx)[1] <- "New cases"
  names(Tx)[2] <- "New deaths"
  names(Tx)[3] <- "New Recovered"
  names(Tx)[4] <- "New tested"
  if( any(is.na(Tx)) )  stop('The data of this province in this day is missing, please choose another day')
  print(Tx)
}


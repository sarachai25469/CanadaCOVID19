##' @description Showing the cumulative cases of a chosen day on the Canada map. 
##' 
##' @title Map of cumulative cases
##' @name map_cum
##' @author Yujie & Jiahui
##' @usage map_cum(date)
##' @param date "yyyy-mm-dd" Double quotes are required. (eg. "2020-06-21")
##' @return Canada map with cumulative cases of a chosen day
##' @import ggplot2
##' @export
##' @examples 
##' map_cum("2020-06-21")
#utils::globalVariables(c("prname","PREABBR","PRUID", "CUMU_NUM"))
map_cum <- function(date){
  cd <- sf::st_read("https://github.com/sarachai25469/Canada_Cov_19/raw/main/data/canada_province_mapdata.geojson", quiet = TRUE)
  crs_string = "+proj=lcc +lat_1=49 +lat_2=77 +lon_0=-91.52 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs"
  full <- utils::read.csv("https://health-infobase.canada.ca/src/data/covidLive/covid19-download.csv", header=TRUE,sep=",",as.is=TRUE,stringsAsFactors = FALSE)
  Byprov<- subset(full, prname != "Canada")
  Byprov[is.na(Byprov)] <- 0
  Byprov$date<-lubridate::ymd(Byprov$date)
  theme_map <- function(base_size=9, base_family="") { 
    theme_bw(base_size=base_size, base_family=base_family) %+replace%
      theme(axis.line=element_blank(),
            axis.text=element_blank(),
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.background=element_blank(),
            panel.border=element_blank(),
            panel.grid=element_blank(),
            panel.spacing=unit(0, "lines"),
            plot.background=element_blank(),
      )}
  
  aoaode<-function(date){
    date<-lubridate::ymd(date)
    PD_info <- Byprov[which(Byprov$date==date),][,c(1,8)]
  }
  da <- aoaode(date)
  colnames(da) <- c("PRUID","CUMU_NUM")
  da$PRUID <- as.factor(da$PRUID)
  da <- da[-which(da$PRUID == 99),]
  used <- dplyr::full_join(cd,da)
  PRUID <- used$PRUID
  CUMU_NUM <- used$CUMU_NUM
  # Plot the map
  gf <- ggplot() +
    geom_sf(aes(group = PRUID, fill = CUMU_NUM), color = "gray60", size = 0.1, data = used) + 
    geom_sf_label( data = used, aes( label = PREABBR ), size = 2.5 )+
    coord_sf(crs = crs_string) + 
    labs(fill = "Cumulative cases") +
    theme_map()
  return(gf)}

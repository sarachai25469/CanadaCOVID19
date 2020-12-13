
full <- utils::read.csv( "https://health-infobase.canada.ca/src/data/covidLive/covid19-download.csv", header=TRUE,sep=",",as.is=TRUE,stringsAsFactors = FALSE)
Byprov<- subset(full, prname != "Canada")
Byprov[is.na(Byprov)] <- 0
Byprov$date<-lubridate::ymd(Byprov$date)
#New cases plot
Newc_plot=function(stopdate,province){
  stopdate<-lubridate::ymd(stopdate)
  sub_pro<-subset(Byprov, prname == province & date<=stopdate)
  ggplot2::ggplot(sub_pro,aes(x=date,y=numtoday,group=1))+geom_point(na.rm=TRUE)+geom_line()+
    ylab("Number of New Cases")+theme(axis.text.x=element_text(angle=90))
}


server=function(input,output){
  output$nc_curve <- renderPlot({Newc_plot(input$stopdate,input$cop)})
}


##' This function can launch a shiny app which is a interactive line plot of new case 
##' in each province in Canada by day. You can choose a date in the slider and a province 
##' in the menu below the slider. Then the plot will show you the new cases 
##' by day in that province from the first recorded day to the day you choose
##'
##' @name Inta_ncpp
##' @title Launch the function of Inta_ncpp
##' @return A shiny app would open
##' @author Yujie & Jiahui
##' @export
#utils::globalVariables("ncpps")
Inta_ncpp<-function(){
  ncpps<-system.file("shiny","Inta_ncpp_app",package="CanadaCOVID19")
  if(ncpps==""){
    stop("Could not find this directory. Try re-installing `mypackage`.", call. = FALSE)
  }
shiny::runApp(ncpps,display.mode="normal")
}
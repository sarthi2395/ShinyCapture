#' ShinyCapture
#'
#' Take easy screenshots of webpage elements in a RShiny Application using Shinyjs package developed by Dean Attali (https://github.com/daattali/shinyjs).
#'
#' \code{ShinyCapture} can be implemented as follows.
#'
#' Add the function \code{useShinyCapture} in the UI part of your RShiny web application which will load up the required scripts for taking and downloading screenshots.
#' The JS can then invoked by using the function \code{Capture} on the server side by passing the element ID, file name of the screenshot and file format.
#'
#' Click \href{https://sarthi2395.shinyapps.io/ShinyCapture}{here} to see a demo.
#'
#' @docType package
#'
#' @name ShinyCapture

NULL

#' @title useShinyCapture
#'
#' @description UI part of the package to load required JavaScript files
#'
#' @return NULL
#'
#' @export useShinyCapture

useShinyCapture <- function(){

  tagList(tags$head(
    useShinyjs(),
    extendShinyjs(text = "shinyjs.capture = function(params) {
                  if(params[[2]]!='jpg' && params[[2]]!='png'){
                  console.log('Provided file format is incorrect. Please use either .jpg or .png');
                  return;
                  }
                  if(params[0]=='html' || params[0]=='body'){
                  var a = document.querySelector(params[0]);
                  }else{
                  var a = document.querySelector('#' +params[0]);
                  }

                  html2canvas(a, {scrollX: 0,scrollY: 0}).then(function (canvas) {
                  var url = canvas.toDataURL();
                  $('<a>', {href: url,download: params[1] + '.' + params[2]})
                  .on('click', function() {$(this).remove()})
                  .appendTo('body')[0].click()
                  }
                  );

}"),
    tags$script(src="https://html2canvas.hertzen.com/dist/html2canvas.js")
    )
    )

}

#' @title Capture
#'
#' @description Server part of the package to pass the element ID, file name and format to take and download the screenshot
#'
#' @param ElementID Pass the ID of the webpage element that needs to be captured. Pass the values 'html' or 'body' to take capture the whole html or body of the webpage.
#'
#' @param FileName Filename of the downloaded screenshot file.
#'
#' @param FileFormat File format of the downloaded screenshot file. 'jpg' and 'png' are the two supported formats.
#'
#' @return NULL
#'
#' @export Capture

Capture <- function(ElementID, FileName, FileFormat){
  js$capture(ElementID,FileName,FileFormat)
}


headers <- list(Accept="text/*",Accept="application/*",
            'Content-Type' = "application/json")

#' Download a csv file specified in the body parameter
#'
#' This function takes three parameters
#' The download endpoint, name of the file to be saved and the details for the file being requested
#'
#' @param url endpoint for the download
#' @param file name of the file to be saved
#' @param bod contains data to be sent to the download endpoint
#' @param hdr HTTP headers for additional information
#' @return download status
#' @export
download_file <- function(url,file,body,hdr=headers){
  fileWriter = RCurl::CFILE(file, mode="wb")
  curlResults = RCurl::curlPerform(url = url, writedata = fileWriter@ref, noprogress=FALSE,
                            .opts = list(httpheader=hdr,postfields=body,verbose=TRUE))

  print(paste("Saving file",file," to ",getwd()))
  RCurl::close(fileWriter)
  return(curlResults)
}

#' Process download
#'
#'This function takes parameters and process the download for the file being requested
#'
#' @param fileName Name of the file being downloaded
#' @param fileFolder if file exists within a sub folder provide the sub-folder path
#' @param user username for accessing the api if empty it will be looked for in the ONA_USER env variable
#' @param pass password for accessing the api if empty it will be looked for in the ONA_PASS env variable
#' @param base_url domain name for the api if empty it will be looked for in the BASE_URL env variable
#' @param end_point resource where the file will be served
#' @param auth_type authentication type default is basic
#' @return download status fo the file
#' @export
process_download <- function(fileName,fileFolder="",
                             user =Sys.getenv("ONA_USER"),
                             pass =Sys.getenv("ONA_PASS"),
                             base_url =Sys.getenv("BASE_URL"),
                             end_point = "/v1/ona-data/download",
                             auth_type = 'basic',
                             .headers = list()
)
{
  uri <- paste(base_url,end_point,sep="")
  body <- data.frame(fileName,fileFolder)

  filePayload <- data.frame(fileName,subFolder)
  body <- jsonlite::toJSON(jsonlite::unbox(filePayload))

  hdr <- append(headers,.headers)
  if(auth_type=='basic'){
    token <- openssl::base64_encode(paste(user,sep=":",pass))
    auth <- c(Authorization=paste("Basic",token))
    hdr <- append(headers,auth)
  }
  print(uri)

  resp <-akilimodownloader::download_file(url=uri,file = fileName,body = body,hdr=hdr)
}

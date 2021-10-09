library(akilimodownloader)

setwd('d:/dev/r/akilimodownloader/test')
getwd()

fileName=("SG Validation choice experiment _ Data collection.csv")
subFolder=("EiA_SAA") ##if CSV exists within a sub folder put the sub-folder here here

t <- akilimodownloader::process_download(fileName = fileName,
                                         fileFolder = subFolder,
                                         user = 'ona',
                                         pass = '',
                                         base_url = 'http://157.245.26.55:8098/api')

print(t)

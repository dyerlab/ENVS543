# This is the content that is read in each time for the setup 
#   chunck in the R for this course.
#


library(tidyverse)
library(lubridate)
library(knitr)
library(DT)

knitr::opts_chunk$set( echo      = FALSE,
                       message   = FALSE,
                       fig.align ="center",
                       out.width="100%")


options( "kableExtra.html.bsTable" = TRUE,
         digits=3 )
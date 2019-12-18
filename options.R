knitr::opts_chunk$set(echo = TRUE, 
                      warking=FALSE, 
                      error = TRUE, 
                      message = FALSE)

options("kableExtra.html.bsTable" = T)

library(tidyverse)
library(knitr)
library(kableExtra)
library(modelr)

theme_set( theme_minimal() )
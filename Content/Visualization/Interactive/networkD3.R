library(networkD3)
library(dplyr)
library(readr)
library(lubridate)

# https://github.com/MuseumofModernArt/collection

moma <- read_csv("https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/Artworks.csv")

moma$YearAcquired <- year(moma$DateAcquired)

moma %>%
  filter(YearAcquired == 1945) %>%
  filter(!grepl("Various", Artist)) %>%
  select(Artist, Department) %>%
  simpleNetwork(Source = "Artist", 
              Target = "Department",  
              nodeColour = "firebrick",
              charge = -75,
              opacity = .5, 
              zoom = TRUE)

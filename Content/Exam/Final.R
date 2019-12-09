# final exam
library(tidyverse)
  
  
read.csv("fossil-fuel-co2-emissions-by-nation_csv.csv") %>%
  mutate( G7 = Country %in% c("CANADA", 
                              "FRANCE (INCLUDING MONACO)", 
                              "GERMANY", 
                              "ITALY (INCLUDING SAN MARINO)", 
                              "JAPAN", 
                              "UNITED KINGDOM", 
                              "UNITED STATES OF AMERICA") ) -> data


summary(data)

# 1

data %>%
  arrange(desc(Total)) %>% 
  filter( Year == 2014, G7 == TRUE ) %>% 
  ggplot( aes(x=Country,y=Total) ) +
  geom_bar(stat="identity")





# 2

data %>%
  filter( Year == 2010 ) %>%
  select( Solid.Fuel, Liquid.Fuel, Gas.Fuel, Cement, Gas.Flaring, Bunker.fuels..Not.in.Total.) %>%
  princomp() -> fit 

summary(fit)
fit.pred <- predict( fit ) 
plot( fit.pred[,1], fit.pred[,2])

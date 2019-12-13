# Ordination Examples

#' This set of exercises are meant for you to explore some aspects of ordiantion.
#' 

library(tidyverse)

#' Load the Rice Data and select the variables Rain, Air Temperature, Wind Speed, Relative 
#'   Humidity, and Barometric pressure.  
#'   
#' Filter these data for daytime only samples.
source("getRiceData.R")
rice_data <- getRiceData()

rice_data %>%
  filter( hour(Date) >= 6,
          hour(Date) <= 17 ) %>%
  select( Rain, AirTemp, WindSpeed, RelHumidity, BP_HG ) -> data




#' Perform a principal component analysis on these data.  Answer the following questions:
data %>%
  prcomp() -> pc.fit


#'  A) How many PC axes are there? 

#  There are five PC axes.
pc.fit

#'  B) What features in the original data are being loaded on each of the PC axes?

# loading of the first axis is:
pc.fit$rotation[,1]

# second axis loads on the variables:
pc.fit$rotation[,2]

# remaining ones etc.

#'  C) How many axes are required to explain 95% of the variation in the data?

sd.percent <- pc.fit$sdev / sum(pc.fit$sdev)

# each axis explains this percentage of the total variation.
sd.percent

# To get the cumulative percentage, you can take the cummulative sum of the sd.percent vector.
cumsum(sd.percent)

# which shows that with three axes, we get 99% of the variation.

#'  D) Make a plot of the predicted values for these data using PC axes 1-2, 1-3, and 2-3.

pred <- data.frame( predict( pc.fit ) )

pred %>%
  ggplot() + 
  geom_point( aes(PC1,PC2) ) + 
  xlab("First Component Axis") +
  ylab("Second Component Axis") + 
  theme_bw()

pred %>%
  ggplot() + 
  geom_point( aes(PC1,PC3) ) + 
  xlab("First Component Axis") +
  ylab("Third Component Axis") + 
  theme_bw()

pred %>%
  ggplot() + 
  geom_point( aes(PC2,PC3) ) + 
  xlab("Second Component Axis") +
  ylab("Third Component Axis") + 
  theme_bw()


#' Perform the same analysis as in the previous question but add `scale=TRUE` to the prcomp() 
#'   function.  Describe the differences in the axis loadings and predicted values in this and
#'   the previous one.

pc.fit.scaled <- prcomp( data, scale = TRUE)

# compare the loadings on the axes

loading.diffs <- pc.fit$rotation - pc.fit.scaled$rotation
loading.diffs

# compare the amount described.
sd.percent.scaled <- pc.fit.scaled$sdev / sum(pc.fit.scaled$sdev)
amount.described <- sd.percent - sd.percent.scaled
amount.described

#' Using the same data as above, take the average value by day of the week.  Perform a hierarchical 
#'   clustering analysis and plot it out. Which days are clustered together?

rice_data %>%
  mutate( Weekday = factor( weekdays(Date), 
                            ordered=TRUE,
                            levels=c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday" ) ) ) %>%
  group_by( Weekday ) %>% 
  summarize( Rain = mean(Rain), 
             AirTemp = mean(AirTemp), 
             WindSpeed = mean(WindSpeed), 
             RelHumidity = mean(RelHumidity), 
             BP = mean( BP_HG) ) -> dailyMeans

M <- as.matrix( dailyMeans[,2:6] )
rownames(M) <- dailyMeans$Weekday
D <- dist( M )
fit.clust <- hclust( D )
plot(fit.clust )



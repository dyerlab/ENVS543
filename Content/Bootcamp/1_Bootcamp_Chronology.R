data <- read.csv( text = "Language,Year,Label
                  S,1975,Bell Laboratories Version 1.0
                  S,1980,Release Outside Bell Labs
                  S,1984,Education & Commercial Licensing
                  S,1988,Statiscal Software Inc.
                  S,1993,Mathsoft Buys S
                  S,1995,Version 3.3
                  S,1996,Version 3.4
                  S,1997,Version 4.0
                  S,1999,Version 5.0
                  S,2000,Version 6.0
                  S,2002,Free Student Version
                  S,2005,Version 7.0
                  S,2007,Version 8.0
                  S,2015,TIBCO
                  R,1995,Unstable
                  R,1997,Version 0.49
                  R,1999,Version 0.65 CRAN & Packages
                  R,2000,Version 1.0
                  R,2001,Version 1.4 S4
                  R,2004,Version 2.0
                  R,2013,Version 3.0
                  R,2017,Version 3.4
                  R,2018,Version 3.5")

data$Y <- c( 0.1, 0.2, 0.3, 0.3, 0.5, 0.55, 0.5, 0.45, 0.5, 0.4, 0.3, 0.2, 0.1, 0.1,
             -0.3, -0.3, -0.3, -0.25, -0.2, rep(-0.3, times=3), 0.25 )
data$ymax <- c( data$Y[1:14], rep(0,9))
data$ymin <- c( rep(0,14), data$Y[15:23])
data$angle <- c( rep(45,14), rep(-43,9) )
data$hjust <- c( rep(0,14), rep(0, 9))
ggplot( data, aes(Year,Y,label=Label) ) + 
  geom_linerange( aes(ymin=ymin,ymax=ymax) ) +
  geom_text( aes( color=Language, angle=angle, hjust=hjust), vjust=0, size=3) +
  geom_hline(yintercept=0,color = "black", size=0.3) + 
  geom_point( aes(y=0, color=Language), size=3) + 
  scale_color_manual( values=c("#0070C0", "#00B050") ) + 
  theme_classic() + ylim(c(-1,1.4) ) + xlim( c(1975,2021) ) + 
  theme( axis.line.y=element_blank(),
                axis.text.y=element_blank(),
                axis.title.x=element_blank(),
                axis.title.y=element_blank(),
                axis.ticks.y=element_blank(),
                legend.position = "none" ) -> p

print(p)
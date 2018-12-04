#Do players who perform better on offense or defense experience 
#more engagement with their Twitter accounts?

library(dplyr)
library(googleVis)

dataset <- data_player %>% 
           select(PLAYER, OFFRTG, DEFRTG, TWITTER_FAVORITE_COUNT, TWITTER_RETWEET_COUNT) %>%
           filter(!is.na(TWITTER_FAVORITE_COUNT) & !is.na(TWITTER_RETWEET_COUNT))

for(i in 1:nrow(dataset)) {
  if(dataset$OFFRTG[i] > dataset$DEFRTG[i]) {
    dataset$OFF_OR_DEF[i] <- "OFF"
  } else {
    dataset$OFF_OR_DEF[i] <- "DEF"
  }
}

dataset <- dataset %>% 
           group_by(OFF_OR_DEF) %>%
           summarize(MED_TWITTER_RETWEETS = median(TWITTER_RETWEET_COUNT), MED_TWITTER_FAVORITES = median(TWITTER_FAVORITE_COUNT))

op <- options(gvis.plot.tag='chart')

graphic2 <- gvisColumnChart(dataset, 
                            options=list(height="800px",
                                         title="Twitter Engagement of Offensive and Defensive Players (2017)"))

createGraphic2 <- function() {plot(graphic2)}
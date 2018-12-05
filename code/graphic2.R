#Do players who perform better on offense or defense experience 
#more engagement with their Twitter accounts?

library(dplyr)
library(googleVis)

dataset <- data_player %>% 
           select(PLAYER, OFFRTG, DEFRTG, TWITTER_FAVORITE_COUNT, TWITTER_RETWEET_COUNT) %>%
           filter(!is.na(TWITTER_FAVORITE_COUNT) & !is.na(TWITTER_RETWEET_COUNT))
colnames(dataset) <- c('Player', 'Offensive Rating', 'Defensive Rating', 'Favorite Count', 'Retweet Count')

for(i in 1:nrow(dataset)) {
  if(dataset$`Offensive Rating`[i] > dataset$`Defensive Rating`[i]) {
    dataset$OFF_OR_DEF[i] <- "Offensive Players"
  } else {
    dataset$OFF_OR_DEF[i] <- "Defensive Players"
  }
}

dataset <- dataset %>% 
           group_by(OFF_OR_DEF) %>%
           summarize(`Median Retweet Count` = median(`Retweet Count`), `Median Favorite Count` = median(`Favorite Count`))

op <- options(gvis.plot.tag='chart')

graphic2 <- gvisColumnChart(dataset, 
                            options=list(height="800px",
                                         title="Twitter Engagement of Offensive and Defensive Players (2017)"))

createGraphic2 <- function() {plot(graphic2)}
# Can the level of engagement with players' Twitter accounts predict 
# their team's audience turnout?

library(dplyr)
library(googleVis)

dataset <- read.csv("../data/dataset.csv", stringsAsFactors = FALSE)

highest_audience <- filter(dataset, AVG_AUDIENCE == max(AVG_AUDIENCE))
lowest_audience <- filter(dataset, AVG_AUDIENCE == min(AVG_AUDIENCE))
highest_retweets <- filter(dataset, TWITTER_RETWEET_COUNT == max(TWITTER_RETWEET_COUNT))
lowest_retweets <- filter(dataset, TWITTER_RETWEET_COUNT == min(TWITTER_RETWEET_COUNT))
highest_favorites <- filter(dataset, TWITTER_FAVORITE_COUNT == max(TWITTER_FAVORITE_COUNT))
lowest_favorites <- filter(dataset, TWITTER_FAVORITE_COUNT == min(TWITTER_FAVORITE_COUNT))

colnames(dataset) <- c('X', 'Team', 'Number of Players', 'Average Audience', 'Twitter Favorite Count', 'Twitter Retweet Count')

# change the behavior of plot.gvis so that only the chart component of the HTML file is written into the output file
op <- options(gvis.plot.tag='chart')

graphic1 <- gvisBubbleChart(dataset, idvar="Team", 
                            xvar="Twitter Retweet Count", yvar="Twitter Favorite Count",
                            colorvar="Number of Players", sizevar="Average Audience",
                            options=list(height="800px", 
                                         explorer="{actions:['dragToZoom', 'rightClickToReset']}",
                                         explorer="{maxZoomIn:.1}",
                                         hAxis='{title:"Median Twitter Retweets"}',
                                         vAxis='{title:"Median Twitter Favorites"}',
                                         bubble="{textStyle:{color: 'none'}}",
                                         colorAxis="{colors: ['#ffe6b7', '#ffa500']}",
                                         title="Correlation Between Number of Players, Median Twitter Retweets, Median Twitter Favorites, and Average Audience Turnout (2017)"))
createGraphic1 <- function() {plot(graphic1)}
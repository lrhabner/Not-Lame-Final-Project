# Can the level of engagement with players' Twitter accounts predict 
# their team's audience turnout?

library(googleVis)

dataset <- read.csv("../data/dataset.csv", stringsAsFactors = FALSE)

# change the behavior of plot.gvis so that only the chart component of the HTML file is written into the output file
op <- options(gvis.plot.tag='chart')

graphic1 <- gvisBubbleChart(dataset, idvar="Team", 
                            xvar="TWITTER_RETWEET_COUNT", yvar="TWITTER_FAVORITE_COUNT",
                            colorvar="NUM_PLAYERS", sizevar="AVG_AUDIENCE",
                            options=list(height="800px", 
                                         explorer="{actions:['dragToZoom', 'rightClickToReset']}",
                                         explorer="{maxZoomIn:.1}",
                                         hAxis='{title:"Median Twitter Retweets"}',
                                         vAxis='{title:"Median Twitter Favorites"}',
                                         title="Correlation Between Median Twitter Retweets, Median Twitter Favorites, and Average Audience Turnout (2017)"))
plot(graphic1)
library(dplyr)
library(googleVis)

unprocessedData <- data.table::fread('../data/nba_2016_2017_100.csv')

data <- unprocessedData %>%
        select(TWITTER_FOLLOWER_COUNT_MILLIONS, AGE, SALARY_MILLIONS, PLAYER_NAME) %>%
        filter(TWITTER_FOLLOWER_COUNT_MILLIONS > 0)
colnames(data) <- c('Twitter Follower Count in Millions', 'Age', 'Salary in Millions', 'Name')

op <- options(gvis.plot.tag='chart')

graphic3 <- gvisBubbleChart(data, idvar = "Name", 
                          xvar = "Twitter Follower Count in Millions", yvar = "Age",
                          colorvar = "Salary in Millions", sizevar = "Salary in Millions",
                          options=list(height="800px", width="1000px",
                                       explorer="{actions:['dragToZoom', 'rightClickToReset']}",
                                       explorer="{maxZoomIn:.1}",
                                       series="[{targetAxisIndex: 0}]",
                                       vAxes="[{title:'Age'}]",
                                       hAxis='{title:"Twitter Followers"}',
                                       bubble="{textStyle:{color: 'none'}}",
                                       title="Correlation Between Twitter Followers, Age, and Salary (2017)"))

createGraphic3 <- function() {plot(graphic3)}

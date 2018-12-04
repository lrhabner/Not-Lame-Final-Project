library(dplyr)
library(googleVis)

unprocessedData <- data.table::fread('../data/nba_2016_2017_100.csv')

data <- unprocessedData %>%
  select(AGE, SALARY_MILLIONS, TWITTER_FOLLOWER_COUNT_MILLIONS) %>%
  filter(TWITTER_FOLLOWER_COUNT_MILLIONS > 0) %>%
  group_by(TWITTER_FOLLOWER_COUNT_MILLIONS) %>%
  summarize(AGE = mean(AGE), SALARY_MILLIONS = mean(SALARY_MILLIONS)) %>%
  arrange(TWITTER_FOLLOWER_COUNT_MILLIONS)

op <- options(gvis.plot.tag='chart')

graphic3 <- gvisLineChart(data, xvar= "TWITTER_FOLLOWER_COUNT_MILLIONS", c("SALARY_MILLIONS","AGE"),
                          options=list(height="800px", width="1000px",
                                       explorer="{actions:['dragToZoom', 'rightClickToReset']}",
                                       explorer="{maxZoomIn:.1}",
                                       series="[{targetAxisIndex: 0}, {targetAxisIndex:1}]",
                                       vAxes="[{title:'Salary'}, {title:'Age'}]",
                                       hAxis='{title:"Twitter Followers"}',
                                       title="Correlation Between Twitter Followers, Age, and Salary (2017)"))

createGraphic3 <- function() {plot(graphic3)}

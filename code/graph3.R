# install.packages('dplyr')
# install.packages('ggplot2')
# install.packages('R.utils')
# setwd('./code')
library(dplyr)
library(ggplot2)
library(R.utils)

unprocessedData <- data.table::fread('../data/nba_2016_2017_100.csv')

data <- unprocessedData %>%
  select(AGE, SALARY_MILLIONS, TWITTER_FOLLOWER_COUNT_MILLIONS) %>%
  filter(TWITTER_FOLLOWER_COUNT_MILLIONS > 0) %>%
  group_by(TWITTER_FOLLOWER_COUNT_MILLIONS) %>%
  summarize(AGE = mean(AGE), SALARY_MILLIONS = mean(SALARY_MILLIONS)) %>%
  arrange(TWITTER_FOLLOWER_COUNT_MILLIONS)

createGraphic3 <- function() {
  ggplot(data=data, aes(x=TWITTER_FOLLOWER_COUNT_MILLIONS)) +
    ggtitle('Twitter Followers vs. Age and Salary') +
    geom_point(aes(y=AGE-20), col='red', size=0.5) +
    geom_point(aes(y=SALARY_MILLIONS), col='green', size=0.5) +
    scale_y_continuous(sec.axis = sec_axis(~.+20, name = "Age (Years)")) +
    xlab('Twitter Followers (Millions)') +
    ylab('Salary (Millions of Dollars)')
}






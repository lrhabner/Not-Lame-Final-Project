<<<<<<< HEAD
library("dplyr")
library("data.table")


# Reading in all necessary csv files
data_salary <- fread("../data/nba_2017_salary.csv")
data_player_stats <- fread("../data/nba_2017_players_stats_combined.csv")
data_twitter <- fread("../data/nba_2017_twitter_players.csv")
data_attendance <- fread("../data/nba_2017_att_val.csv")
data_pie <- fread("../data/nba_2017_pie.csv")


colnames(data_player_stats)[29] <- "TEAM_ABBREVIATION"
data <- left_join(data_player_stats, data_twitter)

colnames(data_salary)[1] <- "PLAYER"
colnames(data_salary)[2] <- "POSITION_2"
data <- left_join(data, data_salary, by = "PLAYER")

# Need to change names of columns to not conflict with current names
colnames(data_pie)[2] <- "TEAM_NAME2"
colnames(data_pie)[3] <- "AGE_2"
colnames(data_pie)[4] <- "GP_2"
colnames(data_pie)[5] <- "W_2"
colnames(data_pie)[21] <- "PACE_2"
colnames(data_pie)[22] <- "PIE_2"
data <- left_join(data, data_pie, by = "PLAYER")

# Select only needed data
data_player <- select(data, PLAYER, AGE, AGE_2, POSITION, TEAM, TEAM_ABBREVIATION, SALARY, OFFRTG, DEFRTG, TWITTER_FAVORITE_COUNT, TWITTER_RETWEET_COUNT)
rm(data_salary, data_player_stats, data_twitter, data_pie)

data_team_twitter <- filter(data_player, !is.na(TWITTER_FAVORITE_COUNT))

data_team_twitter <- group_by(data_team_twitter, TEAM_ABBREVIATION) %>%
  summarize(
    TWITTER_FAVORITE_COUNT_SUM = sum(TWITTER_FAVORITE_COUNT),
    TWITTER_RETWEET_COUNT_SUM = sum(TWITTER_RETWEET_COUNT),
    NUM_PLAYERS = n()
  )
=======
library(dplyr)

#read in data
players <- read.csv("../data/nba_2016_2017_100.csv", stringsAsFactors = FALSE)
twitter <- read.csv("../data/nba_2017_twitter_players.csv", stringsAsFactors = FALSE)

#select top 30 best players with highest off and def values
off_players <- players[order(-players$OFF_RATING),] %>% head(30) %>% select(PLAYER_NAME, OFF_RATING)
def_players <- players[order(-players$DEF_RATING),] %>% head(30) %>% select(PLAYER_NAME, DEF_RATING)
row.names(off_players) <- 1: 30
row.names(def_players) <- 1: 30

#find the corresponding twitter data for players
off_twi <- left_join(off_players, twitter, by = "PLAYER_NAME")
def_twi <- left_join(def_players, twitter, by = "PLAYER_NAME")

#remove old tables
rm(players)
rm(twitter)
rm(off_players)
rm(def_players)

#write processed data into csv file
write.csv(off_twi, "../data/off.csv")
write.csv(def_twi, "../data/def.csv")
>>>>>>> Graphic2

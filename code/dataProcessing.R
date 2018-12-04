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

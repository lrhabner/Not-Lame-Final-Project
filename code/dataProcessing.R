library("dplyr")
library("data.table")


# Reading in all necessary csv files
data_100_sample <- fread("../data/nba_2016_2017_100.csv")
data_salary <- fread("../data/nba_2017_salary.csv")
data_player_stats <- fread("../data/nba_2017_players_stats_combined.csv")
data_twitter <- fread("../data/nba_2017_twitter_players.csv")
data_attendance <- fread("../data/nba_2017_attendance.csv")
data_att_val <- fread("../data/nba_2017_att_val.csv")
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
data <- select(data, PLAYER, AGE, AGE_2, POSITION, POSITION_2, TEAM, TEAM_ABBREVIATION, SALARY, OFFRTG, DEFRTG, TWITTER_FAVORITE_COUNT, TWITTER_RETWEET_COUNT)

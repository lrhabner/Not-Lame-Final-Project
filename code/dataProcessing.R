library("dplyr")
library("data.table")

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
colnames(data_pie)[x] <- "TEAM_NAME2"

data <- left_join(data, data_pie, by = "PLAYER")

# Filter out only needed data
data <- filter(data, "PLAYER", "POSITION", "POSITION_2", "TEAM", "SALARY", "OFFRTG", "DEFRTG", )


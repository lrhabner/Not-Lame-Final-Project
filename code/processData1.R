library(dplyr)

# read in data
player_stats <- read.csv("../data/nba_2017_players_stats_combined.csv", stringsAsFactors = FALSE)
player_twitter_stats <- read.csv("../data/nba_2017_twitter_players.csv", stringsAsFactors = FALSE)
team_attendance <- read.csv("../data/nba_2017_attendance.csv", stringsAsFactors = FALSE)

# assign ID to each team, used for joining datasets
team_attendance <- team_attendance %>% arrange(ï..TEAM)
team_attendance$TEAM_ID <- 1:30

# dataset of all NBA players that includes name, team, favorites, and retweets
player_data <- left_join(player_stats, player_twitter_stats) %>% 
               select(PLAYER, TEAM, TWITTER_FAVORITE_COUNT, TWITTER_RETWEET_COUNT)

# for players with multiple teams, assign to last team
for(i in 1:nrow(player_data)) {
  length <- nchar(player_data$TEAM[i])
  if(length > 3) {
    player_data$TEAM[i] <- substr(player_data$TEAM[i], length-2, length)
  }
}

# dataset that includes number of players on each team
num_players_on_team <- player_data %>% 
                       group_by(TEAM) %>% 
                       summarize(NUM_PLAYERS = n())

# dataset that includes team, median retweets, and median favorites
team_med_twitter_stats <- player_data %>%
                          group_by(TEAM) %>%
                          summarize_at(vars(-PLAYER, -TEAM), funs(median(., na.rm = TRUE)))

team_data <- left_join(num_players_on_team, team_med_twitter_stats)

# reorder team abbreviations to match with other team_attendance
bkn <- team_data[2, ]
bos <- team_data[3, ]
sa <- team_data[26, ]
sac <- team_data[27, ]
tah <- team_data[28, ]
tor <- team_data[29, ]
team_data[2, ] <- bos
team_data[3, ] <- bkn
team_data[26, ] <- sac
team_data[27, ] <- sa
team_data[28, ] <- tor
team_data[29, ] <- tah
team_data$TEAM_ID <- 1:30

# final dataset that includes team, number of players, average audience, median retweets, and median favorites
dataset <- left_join(team_attendance, team_data) %>%
           select(Team = ï..TEAM, NUM_PLAYERS, AVG_AUDIENCE = AVG, TWITTER_FAVORITE_COUNT, TWITTER_RETWEET_COUNT)

# remove old datasets
rm(player_stats)
rm(player_data)
rm(player_twitter_stats)
rm(team_attendance)
rm(num_players_on_team)
rm(team_data)
rm(team_med_twitter_stats)

# write processed data to csv file
write.csv(dataset, "../data/dataset1.csv")
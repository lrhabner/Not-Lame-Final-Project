#Do players who perform better on offense or defense experience 
#more engagement with their Twitter accounts?

library(ggplot2)

off <- read.csv("../data/off.csv", stringsAsFactors = FALSE)
def <- read.csv("../data/def.csv", stringsAsFactors = FALSE)

#make a graph about ratings and twitter retweet counts
graph_retweet <- ggplot() +
    geom_point(data = off, aes(x = OFF_RATING, y = TWITTER_RETWEET_COUNT)) +
    geom_smooth(data = off, aes(x = OFF_RATING, y = TWITTER_RETWEET_COUNT), fill = "blue",
                colour = "darkblue") +
  geom_point(data = def, aes(x = DEF_RATING, y = TWITTER_RETWEET_COUNT)) +
  geom_smooth(data = def, aes(x = DEF_RATING, y = TWITTER_RETWEET_COUNT), fill = "red",
              colour = "red") +
  labs(title = "Ratings VS Twitter Retweet Count") +
  ylab("Twitter Retweet Count") + xlab("Rating")

#make a graph about ratings and twitter favorite counts
graph_favorite <- ggplot() +
  geom_point(data = off, aes(x = OFF_RATING, y = TWITTER_FAVORITE_COUNT)) +
  geom_smooth(data = off, aes(x = OFF_RATING, y = TWITTER_FAVORITE_COUNT), fill = "blue",
              colour = "darkblue") +
  geom_point(data = def, aes(x = DEF_RATING, y = TWITTER_FAVORITE_COUNT)) +
  geom_smooth(data = def, aes(x = DEF_RATING, y = TWITTER_FAVORITE_COUNT), fill = "red",
              colour = "red") +
  labs(title = "Ratings VS Twitter Favorite Count") +
  ylab("Twitter Favorite Count") + xlab("Rating")
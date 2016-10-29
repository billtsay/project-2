# data loaded from twitter.com
# I have created an account in at twitter.com with the credentitals as below.
# The maximum amount of tweets I can download at a time is about 6k - 7k.
# We can download a few times at different time for a bigger dataset if needed.
install.packages(c("devtools"))
library(devtools)
install_github("twitteR", username="geoffjentry")

require(twitteR)
api_key <- "AHghq0UkTVFZI6AZE2JMCM7Qf"
api_secret <- "7fSCVSj38jZIOp5yHFxoydE0m4yz1wnU2NsnqMtD2RvQreH49B"
access_token <- "781643410390159360-avBdwZorL9dCbwI4tXikkJpzj4g0KHX"
access_token_secret <- "NUvN9LyWEK8uhjjlKgsFtmxDiUZumKZdHtwY1FtxDV7Oj"

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
# rm(api_key)
# rm(api_secret)
# rm(access_token)
# rm(access_token_secret)

library(stringr)

# I have used three criteria to filter the tweets and compare them in this project.
# "Election 2016", "Trump", "Clinton", "Hillary"
# The download time is about 2 min each time, be patient.
tweets = searchTwitter("Election 2016", n=1000, lang='en', since="2016-10-01")
# dataFrame <- twListToDF(tweets)
# Converting into dataframe may take 1 min or 2.
dataFrame <- do.call("rbind", lapply(tweets, as.data.frame))

NAME = "election"
fn = str_c("jlt245_project_2_text_mining_dataset_", NAME, "_", Sys.Date(), ".csv") 

write.csv(dataFrame, file = fn)

tweets = searchTwitter("Donald+Trump", n=1000, lang='en', since="2016-10-01")
# dataFrame <- twListToDF(tweets)
# Converting into dataframe may take 1 min or 2.
dataFrame <- do.call("rbind", lapply(tweets, as.data.frame))

NAME = "trump"
fn = str_c("jlt245_project_2_text_mining_dataset_", NAME, "_", Sys.Date(), ".csv") 

write.csv(dataFrame, file = fn)

tweets = searchTwitter("Hillary+Clinton", n=1000, lang='en', since="2016-10-01")
# dataFrame <- twListToDF(tweets)
# Converting into dataframe may take 1 min or 2.
dataFrame <- do.call("rbind", lapply(tweets, as.data.frame))

NAME = "hillary"
fn = str_c("jlt245_project_2_text_mining_dataset_", NAME, "_", Sys.Date(), ".csv") 

write.csv(dataFrame, file = fn)

# verify the length of the tweets.
#(nTweets <- length(tweets))


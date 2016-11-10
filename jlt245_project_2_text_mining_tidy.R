
library(stringr)
library(tm)
library(ggplot2)
library(dplyr)
library(tidyr)
library(tidytext)

setwd("~/project-2")

# load Hillary and Trump's dataframe and merge them into one dataframe
# we will analyze the relative sentiment between these two candidates.
NAME = "hillary"
load(file = str_c("jlt245_project_2_text_mining_dataframe_", NAME, ".Rda"))
tweets_df <- tbl_df(dataFrame)

hillary_tweets <- tweets_df %>%
  select(id, text, created)

hillary_tweets$source = "Hillary"

NAME = "trump"
load(file = str_c("jlt245_project_2_text_mining_dataframe_", NAME, ".Rda"))
tweets_df <- tbl_df(dataFrame)

trump_tweets <- tweets_df %>%
  select(id, text, created)

trump_tweets$source = "Trump"

tweets <- rbind(hillary_tweets, trump_tweets)

tweets

# functions to remove the non-needed items, such as http link, numbers etc.
removeHTTP <- function(x) gsub("http[^[:space:]]*", "", x)
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "", x)

tCorpus <- Corpus(VectorSource(tweets$text))

tCorpus <- tm_map(tCorpus, removePunctuation)
tCorpus <- tm_map(tCorpus, removeNumbers)
tCorpus <- tm_map(tCorpus, FUN=content_transformer(removeHTTP))
tCorpus <- tm_map(tCorpus, FUN=content_transformer(removeNumPunct))

tCorpus <- tm_map(tCorpus, content_transformer(tolower))

# randomly choose a content to verify.
tCorpus[[2001]]$content

# some non-needed stopwords...
rdStopwords <- c(setdiff(stopwords("english"), c("r", "big")),
                 "use", "see", "seed", "via", "amp")

removeTheWords <- function(x) removeWords(x, rdStopwords)

# run to remove the stopwords.
tCorpus <- tm_map(tCorpus, stripWhitespace)
# tCorpus <- tm_map(tCorpus, content_transformer(stemDocument))

# The following step to remove some stopwords does not seem to work as usual due to new tm package. 
# It was reported in the internet too.
## tCorpus <- tm_map(tCorpus, removeWords, rdStopwords)

# make a copy of corpus for use.
copiedCorpus <- tCorpus

# steming.
tCorpus <- tm_map(tCorpus, content_transformer(function(x, d)
    paste(stemCompletion(strsplit(stemDocument(x), ' ')[[1]], d), collapse = ' ')), copiedCorpus, lazy=TRUE)

# verify if the non-needed items are removed.
tCorpus[[2001]]$content

# converting corpus into Document Term Matrix, this may take an hour to execute.
dtm <- DocumentTermMatrix(tCorpus)

fn = str_c("jlt245_project_2_text_mining_tidydtm.RData") 
save(dtm, file = fn)





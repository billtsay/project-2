
library(stringr)
library(tm)
library(ggplot2)
library(dplyr)
library(purrr)
library(twitteR)
library(tidyr)

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


knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE, cache = TRUE,
                      dev = "svg")
theme_set(theme_bw())

library(lubridate)
library(scales)
library(tidytext)

reg <- "([^A-Za-z\\d#@']|'(?![A-Za-z\\d#@]))"
tweet_words <- tweets %>%
  filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word,
         str_detect(word, "[a-z]"))

tweet_words

tweet_words %>%
  count(word, sort = TRUE) %>%
  head(20) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_bar(stat = "identity") +
  ylab("Occurrences") +
  coord_flip()

ggsave(str_c("jlt245_project_2_text_mining_sentiment_tweet_words.pdf"))

nrc <- sentiments %>%
  filter(lexicon == "nrc") %>%
  dplyr::select(word, sentiment)

nrc

sources <- tweet_words %>%
  group_by(source) %>%
  mutate(total_words = n()) %>%
  ungroup() %>%
  distinct(id, source, total_words)

by_source_sentiment <- tweet_words %>%
  inner_join(nrc, by = "word") %>%
  count(sentiment, id) %>%
  ungroup() %>%
  complete(sentiment, id, fill = list(n = 0)) %>%
  inner_join(sources) %>%
  group_by(source, sentiment, total_words) %>%
  summarize(words = sum(n)) %>%
  ungroup()

head(by_source_sentiment)


library(broom)

sentiment_differences <- by_source_sentiment %>%
  group_by(sentiment) %>%
  do(tidy(poisson.test(.$words, .$total_words)))

sentiment_differences %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, estimate)) %>%
  mutate_each(funs(. - 1), estimate, conf.low, conf.high) %>%
  ggplot(aes(estimate, sentiment)) +
  geom_point() +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high)) +
  scale_x_continuous(labels = percent_format()) +
  labs(x = "% increase in Trump relative to Hillary",
       y = "Sentiment")

ggsave(str_c("jlt245_project_2_text_mining_sentiment_differences.pdf"))

trump_hillary_ratios <- tweet_words %>%
  count(word, source) %>%
  filter(sum(n) >= 5) %>%
  spread(source, n, fill = 0) %>%
  ungroup() %>%
  mutate_each(funs((. + 1) / sum(. + 1)), -word) %>%
  mutate(logratio = log2(Trump / Hillary)) %>%
  arrange(desc(logratio))

trump_hillary_ratios %>%
  group_by(logratio > 0) %>%
  top_n(15, abs(logratio)) %>%
  ungroup() %>%
  mutate(word = reorder(word, logratio)) %>%
  ggplot(aes(word, logratio, fill = logratio < 0)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  ylab("Trump / Hillary log ratio") +
  scale_fill_manual(name = "", labels = c("Trump", "Hillary"),
                    values = c("red", "lightblue"))

ggsave(str_c("jlt245_project_2_text_mining_sentiment_log_ratio.pdf"))

trump_hillary_ratios %>%
  inner_join(nrc, by = "word") %>%
  filter(!sentiment %in% c("positive", "negative")) %>%
  mutate(sentiment = reorder(sentiment, -logratio),
         word = reorder(word, -logratio)) %>%
  group_by(sentiment) %>%
  top_n(10, abs(logratio)) %>%
  ungroup() %>%
  ggplot(aes(word, logratio, fill = logratio < 0)) +
  facet_wrap(~ sentiment, scales = "free", nrow = 2) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x = "", y = "Trump / Hillary log ratio") +
  scale_fill_manual(name = "", labels = c("Trump", "Hillary"),
                    values = c("red", "lightblue"))

ggsave(str_c("jlt245_project_2_text_mining_sentiment_scale_log_ratio.pdf"))


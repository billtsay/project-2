#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("One argument must be supplied (input file).n", call.=FALSE)
}

# This script will run three times with NAME = "election", "hillary" and "trump", and generates TDM files for each.
NAME = args[1]    

# NAME = "election"
# NAME = "hillary"
# NAME = "trump"

setwd("~/project-2")

# install.packages(c("tm", "NLP"))

# data cleaning and preprocessing.
# read data from csv file.

library(stringr)

# csv = str_c("jlt245_project_2_text_mining_dataset_", NAME, ".csv") 
# dataFrame = read.csv(csv)

filenames <- c(
  str_c("jlt245_project_2_text_mining_dataset_", NAME, "_2016-10-28.csv"),
  str_c("jlt245_project_2_text_mining_dataset_", NAME, "_2016-10-29.csv"),
  str_c("jlt245_project_2_text_mining_dataset_", NAME, "_2016-10-30.csv"),
  str_c("jlt245_project_2_text_mining_dataset_", NAME, "_2016-10-31.csv"),
  str_c("jlt245_project_2_text_mining_dataset_", NAME, "_2016-11-01.csv"),
  str_c("jlt245_project_2_text_mining_dataset_", NAME, "_2016-11-02.csv"),
  str_c("jlt245_project_2_text_mining_dataset_", NAME, "_2016-11-03.csv"),
  str_c("jlt245_project_2_text_mining_dataset_", NAME, "_2016-11-04.csv"),
  str_c("jlt245_project_2_text_mining_dataset_", NAME, "_2016-11-05.csv"),
  str_c("jlt245_project_2_text_mining_dataset_", NAME, "_2016-11-06.csv")
)

dataFrame <- do.call(rbind,lapply(filenames,read.csv))

save(dataFrame, file=str_c("jlt245_project_2_text_mining_dataframe_", NAME, ".Rda"))
  
names(dataFrame)
dim(dataFrame)
head(dataFrame, 10)
  
# install.packages("tm")
library(tm)


# functions to remove the non-needed items, such as http link, numbers etc.
removeHTTP <- function(x) gsub("http[^[:space:]]*", "", x)
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "", x)

tCorpus <- Corpus(VectorSource(dataFrame$text))

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
#tCorpus <- tm_map(tCorpus, content_transformer(function(x, d)
#    paste(stemCompletion(strsplit(stemDocument(x), ' ')[[1]], d), collapse = ' ')), copiedCorpus, lazy=TRUE)
  
# verify if the non-needed items are removed.
tCorpus[[2001]]$content
  
# converting corpus into Term Document Matrix and plot the term frequency chart.
# this may take an hour to execute.
tdm <- TermDocumentMatrix(tCorpus)
  
fn = str_c("jlt245_project_2_text_mining_tdm_", NAME, ".RData") 
save(tdm, file = fn)


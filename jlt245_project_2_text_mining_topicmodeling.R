NAME = "election"

library(stringr)
library(tm)
library(ggplot2)

load(file = str_c("jlt245_project_2_text_mining_dataframe_", NAME, ".Rda"))
load(file = str_c("jlt245_project_2_text_mining_tdm_", NAME, ".RData"))

# Topic Modeling
dtm <- as.DocumentTermMatrix(tdm)
install.packages("topicmodels")
library(topicmodels)

lda <- LDA(dtm, k = 10)

term <- terms(lda, 6)

(term <- apply(term, MARGIN=2, paste, collapse=", "))

topics <- topics(lda)
topics <- data.frame(date=as.Date(dataFrame$created), topic=topics)
ggplot(topics, aes(date, fill=term[topic])) + geom_density(position = "stack")



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

library(stringr)

fn = str_c("jlt245_project_2_text_mining_tdm_", NAME, ".RData") 
load(file = fn)

library(tm)

dtm <- as.DocumentTermMatrix(tdm)

# Using Spherical k-Means Clustering
library(skmeans)

set.seed(1234)
(topic <- skmeans(weightBin(dtm), k=5, m=1.2, control=list(nruns=20)))

library("clue")
library("grid")

library("seriation")

# This chart may take an hour to display.
res <- dissplot(skmeans_xdist(weightBin(dtm)), cl_class_ids(topic), options=list(silhouette=TRUE, gp=gpar(cex=0.7)))
res

plot(res, options = list(main = "Seriation - threshold", threshold = 1.5))
dev.copy(pdf, str_c("jlt245_project_2_text_mining_seriation_", NAME, ".pdf"), width=6, height=6)
dev.off()

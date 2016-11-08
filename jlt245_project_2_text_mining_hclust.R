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

k = 6 # cluster number

# drawing Cluster Dengrogram by using hierachy cluster.
library(tm)
library(stringr)
  
# tdm loaded from RData file.
fn = str_c("jlt245_project_2_text_mining_tdm_", NAME, ".RData") 
load(file = fn)
# clustering
rTdm <- removeSparseTerms(tdm, sparse = 0.96)
rm <- as.matrix(rTdm)
  
distMatrix <- dist(scale(rm))
fit <-hclust(distMatrix, method = "ward")

pdf(str_c("jlt245_project_2_text_mining_hclust_", NAME, ".pdf"))
plot(fit)
rect.hclust(fit, k = k)
dev.off() 


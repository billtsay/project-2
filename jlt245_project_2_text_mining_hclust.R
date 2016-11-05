NAME = "hillary"
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
  
plot(fit)
  
rect.hclust(fit, k = k)

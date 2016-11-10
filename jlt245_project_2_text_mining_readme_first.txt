The version of R runtime I am using for this project is R3.3.1. There are some updates and compabilities issues in R3.3.2 that I have not yet investigated. R3.3.1 is the current version that you can use yum to install from Centos repositories.

First of All, before running any R scripts, we need to install the needed packages. Please run:

  Rscript jlt245_project_2_text_mining_install_packages.R

It must be executed without any errors and the capabilities should be as below:

The downloaded source packages are in
	‘/tmp/RtmpLFnjMG/downloaded_packages’
       jpeg         png        tiff       tcltk         X11        aqua 
       TRUE        TRUE        TRUE        TRUE        TRUE       FALSE 
   http/ftp     sockets      libxml        fifo      cledit       iconv 
       TRUE        TRUE        TRUE        TRUE       FALSE        TRUE 
        NLS     profmem       cairo         ICU long.double     libcurl 
       TRUE       FALSE        TRUE        TRUE        TRUE        TRUE 

 The X11 must be TRUE since we will use plot to generate graphs and charts etc.

**R scripts:

  jlt245_project_2_text_mining_install_packages.R
  jlt245_project_2_text_mining_dataload.R
  jlt245_project_2_text_mining_preprocessing.R
  jlt245_project_2_text_mining_hclust.R
  jlt245_project_2_text_mining_topicmodeling.R
  jlt245_project_2_text_mining_skmeans.R
  jlt245_project_2_text_mining_sentiment.R
  jlt245_project_2_text_mining_tidy.R
  jlt245_project_2_text_mining_tidy_plot.R


* jlt245_project_2_text_mining_install_packages.R

To install all libraries that will be needed for this project.

How to Run:

  Rscript jlt245_project_2_text_mining_install_packages.R


* jlt245_project_2_text_mining_dataload.R

To load the dataset of tweets from twitter.com. It will generate three csv files as below:

  jlt245_project_2_text_mining_dataset_election_<date>.csv
  jlt245_project_2_text_mining_dataset_trump_<date>.csv
  jlt245_project_2_text_mining_dataset_hillary_<date>.csv

with filters "Election 2016", "Donald Trump" and "Hillary Clinton". In this project, I have collected a week of dataset from each.

How to Run:

  Rscript jlt245_project_2_text_mining_dataload.R


* jlt245_project_2_text_mining_preprocessing.R

To prep-process the datasets collected from above dataload script and generate tdm(term document matrix) files:

  jlt245_project_2_text_mining_tdm_election.RData
  jlt245_project_2_text_mining_tdm_trump.RData
  jlt245_project_2_text_mining_tdm_hillary.RData

Those files are the starting documents to procceed the analysis of this project. The reason we need to generate and save tdm files is it will take an hour to construct tdm for thousands of records.

How to Run:

  Rscript jlt245_project_2_text_mining_preprocessing.R election
  Rscript jlt245_project_2_text_mining_preprocessing.R hillary
  Rscript jlt245_project_2_text_mining_preprocessing.R trump


* jlt245_project_2_text_mining_hclust.R

To generate hierachy clusters of terms:

  jlt245_project_2_text_mining_hclust_election.pdf
  jlt245_project_2_text_mining_hclust_hillary.pdf
  jlt245_project_2_text_mining_hclust_trump.pdf

How to Run:

  Rscript jlt245_project_2_text_mining_hclust.R election
  Rscript jlt245_project_2_text_mining_hclust.R hillary
  Rscript jlt245_project_2_text_mining_hclust.R trump

* jlt245_project_2_text_mining_topicmodeling.R

To analyze topic models and generate topics:

jlt245_project_2_text_mining_topics_election.pdf
jlt245_project_2_text_mining_topics_hillary.pdf
jlt245_project_2_text_mining_topics_trump.pdf

How to Run

  Rscript jlt245_project_2_text_mining_topicmodeling.R election
  Rscript jlt245_project_2_text_mining_topicmodeling.R hillary
  Rscript jlt245_project_2_text_mining_topicmodeling.R trump


* jlt245_project_2_text_mining_sentiment.R

To merge hillary and trump tdm into one, then do sentiment analysis and generate charts of them.

jlt245_project_2_text_mining_sentiment_differences.pdf
jlt245_project_2_text_mining_sentiment_log_ratio.pdf
jlt245_project_2_text_mining_sentiment_scale_log_ratio.pdf
jlt245_project_2_text_mining_sentiment_tweet_words.pdf

How to Run

  Rscript jlt245_project_2_text_mining_sentiment.R


* jlt245_project_2_text_mining_tidy.R

To convert dataset of 10 thousand records into dtm (Document Term Matrix). This step will take half of a day, so I save the outcome into:

  jlt245_project_2_text_mining_tidydtm.RData

for the next step to analyze the dtm and plot the charts.

How to Run

  Rscript jlt245_project_2_text_mining_tidy.R


* jlt245_project_2_text_mining_tidy_plot.R

Read the tidy's dtm RData and analyze them. The outcome is the chart:

  jlt245_project_2_text_mining_tidy_plot.pdf

How to Run

  Rscript jlt245_project_2_text_mining_tidy_plot.R



* jlt245_project_2_text_mining_skmeans.R

Spherical k-means works on thousands of records takes hours to execute. At this moment I have given up this part of analysis.


References:

Text Mining Infrastructure in R by Ingo Feinerer, Kurt Hornik, David Meyer. https://pdfs.semanticscholar.org/37c4/095eb7fc4cfdb6c0218ce260c5125ce1e2ce.pdf

Sentiment Analysis on Donald Trump using R and Tableau, By Fisseha Berhane. https://www.r-bloggers.com/sentiment-analysis-on-donald-trump-using-r-and-tableau/

Text and Sentiment Analysis with Trump, Clinton, Sanders Twitter data, Kan Nishida. https://blog.exploratory.io/sentiment-analysis-with-trump-clinton-sanders-twitter-data-cc978e91960f#.3d92gco8r


 




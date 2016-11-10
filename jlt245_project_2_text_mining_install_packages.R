
install.packages(c("devtools", "stringr"), repos = "http://cran.us.r-project.org")
library(devtools)

install_github("twitteR", username="geoffjentry")


install.packages(c("tm", "NLP"),repos = "http://cran.us.r-project.org")
install.packages(c("skmeans", "seriation"), repos = "http://cran.us.r-project.org")


# depends on gsl, need to use:
# sudo yum install gsl_devel
# before installing this package.
install.packages(c("topicmodels"), repos = "http://cran.us.r-project.org")

# for sentiment analsis.
install.packages(c("tidyr", "purrr", "lubridate", "knitr", "tidytext"), repos = "http://cran.us.r-project.org")

capabilities()


install.packages(c("devtools", "stringr"))
library(devtools)

install_github("twitteR", username="geoffjentry")


install.packages(c("tm", "NLP"))
install.packages(c("skmeans", "seriation"))


# depends on gsl, need to use:
# sudo yum install gsl_devel
# before installing this package.
install.packages(c("topicmodels"))

# for sentiment analsis.
install.packages(c("tidyr", "purrr", "lubridate", "knitr", "tidytext"))

capabilities()

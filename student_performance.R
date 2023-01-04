# PACKAGES
library(ggplot2)
library(dplyr)

# LOAD THE DATA
score_data <- read.csv('StudentsPerformance.csv', header = TRUE)
attach(score_data)


# GENERATE A 'MEAN SCORE' COLUMN THAT AVERAGES ALL SUBJECT SCORES
score_data <- mutate(score_data, mean_score =
                             rowMeans(select(
                                     score_data, c(math.score,
                                                   reading.score,
                                                   writing.score)
                             ), na.rm = TRUE))

# VISUALIZATION
male_score_data <- filter(score_data, gender=='male')
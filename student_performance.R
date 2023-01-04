# PACKAGES
library(ggplot2)
library(dplyr)
library(patchwork)

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
male_score_data <- filter(score_data, gender == 'male')

female_score_data <- filter(score_data, gender == 'female')


#### MATH SCORES
male_math <-
        ggplot(male_score_data, aes(x = math.score)) + geom_histogram(
                aes(y = ..density..),
                binwidth = 2,
                fill = 'darkblue',
                color = 'black',
                alpha = .4
        ) +
        labs(x = "Math Score", y = "Count", title = 'Male Math') +
        geom_density(alpha = .2, fill = 'blue') +
        theme(plot.title = element_text(hjust = 0.5)) +
        scale_x_continuous(breaks = seq(0, 100, 25))

female_math <-
        ggplot(female_score_data, aes(x = math.score)) + geom_histogram(
                aes(y = ..density..),
                binwidth = 2,
                fill = 'red',
                color = 'black',
                alpha = .4
        ) +
        labs(x = "Math Score", y = "Count", title = 'Female Math') +
        geom_density(alpha = .2, fill = 'pink')  +
        theme(plot.title = element_text(hjust = 0.5)) +
        scale_x_continuous(breaks = seq(0, 100, 25))




#### READING SCORES
male_reading <-
        ggplot(male_score_data, aes(x = reading.score)) + geom_histogram(
                aes(y = ..density..),
                binwidth = 2,
                fill = 'darkblue',
                color = 'black',
                alpha = .4
        ) +
        labs(x = "Reading Score", y = "Count", title = 'Distribution of Male Reading Scores') +
        geom_density(alpha = .2, fill = 'blue')  +
        theme(plot.title = element_text(hjust = 0.5)) +
        scale_x_continuous(breaks = seq(0, 100, 25))

female_reading <-
        ggplot(female_score_data, aes(x = reading.score)) + geom_histogram(
                aes(y = ..density..),
                binwidth = 2,
                fill = 'red',
                color = 'black',
                alpha = .4
        ) +
        labs(x = "Reading Score", y = "Count", title = 'Distribution of Female Reading Scores') +
        geom_density(alpha = .2, fill = 'pink')  +
        theme(plot.title = element_text(hjust = 0.5)) +
        scale_x_continuous(breaks = seq(0, 100, 25))




#### WRITING SCORES

male_writing <-
        ggplot(male_score_data, aes(x = writing.score)) + geom_histogram(
                aes(y = ..density..),
                binwidth = 2,
                fill = 'darkblue',
                color = 'black',
                alpha = .4
        ) +
        labs(x = "Writing Score", y = "Count", title = 'Distribution of Male Writing Scores') +
        geom_density(alpha = .2, fill = 'blue')  +
        theme(plot.title = element_text(hjust = 0.5)) +
        scale_x_continuous(breaks = seq(0, 100, 25))

female_writing <-
        ggplot(female_score_data, aes(x = writing.score)) + geom_histogram(
                aes(y = ..density..),
                binwidth = 2,
                fill = 'red',
                color = 'black',
                alpha = .4
        ) +
        labs(x = "Writing Score", y = "Count", title = 'Distribution of Female Writing Scores') +
        geom_density(alpha = .2, fill = 'pink')  +
        theme(plot.title = element_text(hjust = 0.5)) +
        scale_x_continuous(breaks = seq(0, 100, 25))




# PLOTS

plots_arranged <-
        (male_math | female_math) /
        (male_reading | female_reading) /
        (male_writing |
                 female_writing) + plot_annotation(theme = theme_gray(base_family = 'mono'),
                                                   title = "Distribution of Scores across Gender")

plots_arranged

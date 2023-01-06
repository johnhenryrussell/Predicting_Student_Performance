# PACKAGES
library(ggplot2)
library(dplyr)
library(patchwork)
library(plotly)
library(tidyverse)

# LOAD THE DATA
score_data <- read.csv('StudentsPerformance.csv', header = TRUE)
attach(score_data)


# GENERATE A 'MEAN SCORE' COLUMN THAT AVERAGES ALL SUBJECT SCORES
score_data <- mutate(score_data, mean.score =
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

# TABLE OF AVERAGES

male_means <-
        c("Male",
          round(mean(male_score_data$math.score), 2),
          round(mean(male_score_data$reading.score), 2),
          round(mean(male_score_data$writing.score), 2))

female_means <-
        c("Female",
          round(mean(female_score_data$math.score), 2),
          round(mean(female_score_data$reading.score), 2),
          round(mean(female_score_data$writing.score), 2))


mean_matrix <- as.data.frame(rbind(male_means, female_means))
colnames(mean_matrix) <- c('Gender', 'Math', 'Reading', "Writing")
mean_df <- as.data.frame(mean_matrix)


mean_df %>% gt() %>% gt_theme_nytimes() %>% tab_header(title = 'Mean Scores')


# PARENTAL LEVEL OF EDUCATION

parents <- score_data %>% count(parental.level.of.education)

list <- c(
        "associate's",
        "bachelor's",
        "high school",
        "master's",
        "some college",
        "some high school"
)

### For Loop to change row names

for (i in 1:6) {
        parents$parental.level.of.education[i] = list[i]
}


### HISTOGRAM PLOT FOR ALL
parents <- parents %>% mutate(percent = (n / sum(n)) * 100)
parents %>% gt() %>% gt_theme_nytimes()

colnames(parents) <- c('ParentalEducation', "n", "percent")

hi <-
        ggplot(parents,
               aes(x = ParentalEducation, y = n, fill = ParentalEducation)) +
        geom_col() +
        theme(legend.position = "none") +
        labs(x = "", y = "Count", title = 'Parental Level of Education')

parents1 <-
        filter(score_data, parental.level.of.education == "some high school")
parents2 <-
        filter(score_data, parental.level.of.education == "high school")
parents3 <-
        filter(score_data, parental.level.of.education == "some college")
parents4 <-
        filter(score_data,
               parental.level.of.education == "associate's degree")
parents5 <-
        filter(score_data, parental.level.of.education == "bachelor's degree")
parents6 <-
        filter(score_data, parental.level.of.education == "master's degree")


### INDIVIDUAL HISTOGRAM PLOTS
p1 <-
        ggplot(parents1, aes(x = mean.score)) + geom_histogram(fill = '#f8766d',
                                                               color = 'black',
                                                               binwidth = 2.5) +
        labs(title = "Some High School", x = "Mean Score") +
        scale_x_continuous(breaks = seq(0, 100, 10)) +
        scale_y_continuous(NULL, breaks = NULL) +
        geom_density(alpha = .2, fill = 'pink')

p2 <-
        ggplot(parents2, aes(x = mean.score)) + geom_histogram(fill = '#b79f00',
                                                               color = 'black',
                                                               binwidth = 2) +
        labs(title = "High School", x = "Mean Score") +
        scale_x_continuous(breaks = seq(0, 100, 10)) +
        scale_y_continuous(NULL, breaks = NULL)

p3 <-
        ggplot(parents3, aes(x = mean.score)) + geom_histogram(fill = '#00ba38',
                                                               color = 'black',
                                                               binwidth = 2) +
        labs(title = "Some College", x = "Mean Score") +
        scale_x_continuous(breaks = seq(0, 100, 10)) +
        scale_y_continuous(NULL, breaks = NULL)

p4 <-
        ggplot(parents4, aes(x = mean.score)) + geom_histogram(fill = '#00bfc4',
                                                               color = 'black',
                                                               binwidth = 1.7) +
        labs(title = "Associate's Degree", x = "Mean Score") +
        scale_x_continuous(breaks = seq(0, 100, 10)) +
        scale_y_continuous(NULL, breaks = NULL)

p5 <-
        ggplot(parents5, aes(x = mean.score)) + geom_histogram(fill = '#619cff',
                                                               color = 'black',
                                                               binwidth = 2) +
        labs(title = "Bachelor's Degree", x = "Mean Score") +
        scale_x_continuous(breaks = seq(0, 100, 10)) +
        scale_y_continuous(NULL, breaks = NULL)

p6 <-
        ggplot(parents6, aes(x = mean.score)) + geom_histogram(fill = '#f564e3',
                                                               color = 'black',
                                                               binwidth = 2) +
        labs(title = "Master's Degree", x = "Mean Score") +
        scale_x_continuous(breaks = seq(0, 100, 10)) +
        scale_y_continuous(NULL, breaks = NULL) +
        geom_density(alpha = .2, fill = 'pink')

ed_arranged <-
        (p1 |
                 p2) / (p3 |
                                p4) / (p5 |
                                               p6) + plot_annotation(theme = theme_gray(base_family = 'mono'),
                                                                     title = "Distribution of Mean Scores across Parental Education Level")

ed_arranged


### COMPARING COLLEGE VS. NO COLLEGE
parents_college <-
        filter(
                score_data,
                parental.level.of.education %in% c(
                        "associate's degree",
                        "bachelor's degree",
                        "master's degree",
                        "some college"
                )
        )

parents_nocollege <-
        filter(score_data,
               parental.level.of.education %in% c("high school", "some high school"))


f1 <-
        ggplot(parents_college, aes(x = mean.score)) + geom_histogram(aes(y = ..density..), fill =
                                                                              'darkgreen', color = 'black') +
        scale_x_continuous(breaks = seq(0, 100, 25)) +
        labs(title = "Mean Score with Some College") +
        geom_density(alpha = .2, fill = 'green')

f2 <-
        ggplot(parents_nocollege, aes(x = mean.score)) + geom_histogram(aes(y =
                                                                                    ..density..), fill = "darkred", color = 'black') +
        scale_x_continuous(breaks = seq(0, 100, 25)) +
        labs(title = "Mean Scores with No College") +
        geom_density(alpha = .2, fill = 'red')


plot <-
        hi / (f1 |
                      f2) + plot_annotation(theme = theme_gray(base_family = 'mono'),
                                            title = "Distribution of Mean Scores & Some College vs. No College")
plot


#Overlayed histogram parental education

histo_df <-
        data.frame(
                values <-
                        c(
                                parents1$mean.score,
                                parents2$mean.score,
                                parents3$mean.score,
                                parents4$mean.score,
                                parents5$mean.score,
                                parents6$mean.score
                        ),
                group = c(
                        rep("some high school", length(parents1$mean.score)),
                        rep("high school", length(parents2$mean.score)),
                        rep("some college", length(parents3$mean.score)),
                        rep("associate's degree", length(parents4$mean.score)),
                        rep("bachelor's degree", length(parents5$mean.score)),
                        rep("master's degree", length(parents6$mean.score))
                )
        )

overlay_histo <-
        ggplot(histo_df, aes(x = values, fill = group)) + geom_density(position =
                                                                               "identity", alpha = 0.3) +
        theme(legend.position = "bottom") + labs(x = "Mean Score",
                                                 title = "Density Plot for all Education Levels")



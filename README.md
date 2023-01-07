# Predicting Student Performance -- an analysis in R

## The goal of this project is to gain insight on classroom performance. We will begin with a series of visualizations and conclude with a predictive model. 

Packages Required:
```{r echo=FALSE, message=FALSE, warning=FALSE}
library(ggplot2)
library(dplyr)
library(patchwork)
library(plotly)
library(tidyverse)
library(gtExtras)
library(gt)
```

### We will first examine the distribution of subject specific scores across gender.

\begin{center}

![image](https://user-images.githubusercontent.com/64446624/211076993-3092a2e0-6e95-4115-9b6b-94106e958483.png)

![image](https://user-images.githubusercontent.com/64446624/211078199-b50a73ba-efb0-4751-ae0f-2fafc9e4c7a4.png)

\end{center}

## There are some interesting conclusion we can make:


* Male's tend to score higher in Math
* Female's tend to score higher in Reading and Writing
* The distribution for the male group is relatively normal while the distribution for the female group is skewed to the right.


## Next, we want to look at the effect of parental level of education on subject scores.

![image](https://user-images.githubusercontent.com/64446624/211078911-7c6c2f9c-b02e-4403-a509-05d45d2f9251.png)


![image](https://user-images.githubusercontent.com/64446624/211078403-0ca486bc-8e61-48d0-b742-59cd0fcc12cf.png)


## There are a few things to notice:


* Most students have parents who achieved some level of college (62.5%).
* The median score for students whose parents achieved some level of college is 70.3%.
* The median score for kids whose parents did not reach college is 65.7%. 

![image](https://user-images.githubusercontent.com/64446624/211079755-bcb3dece-0adf-41cb-8559-52abdf736d0e.png)

![image](https://user-images.githubusercontent.com/64446624/211080662-f38df0b0-ec83-406b-beb4-62b27eeec391.png)

We see that student's whose parents achieved beyond a bachelor's degree are more likely to score beyond 80%. 
On the other hand, student's whose parents did not attend college are more likely to score below 60%. 
Otherwise, it appears to be difficult to differentiate between different levels of parental education.

## Now, we will look at how a single test preparation course affects exam scores. The results are fascinating!

### The following charts compare the effect of a test preparation course on mean exam score. We also include a table to compare subject specific exam scores.

![image](https://user-images.githubusercontent.com/64446624/211132059-1b631334-565f-4f57-bd3a-0666437071ab.png)

![image](https://user-images.githubusercontent.com/64446624/211132086-54febcec-05c6-4c71-830d-841919317556.png)

We see that a single test preparation course has a significant effect on exam scores. In fact, taking part in a test preparation course leads to an 11.7% increase in mean exam score. We will examine this further when we construct our model. 

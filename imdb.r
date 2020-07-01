setwd("F:\\EXCEL R\\ASSIGNMENTS\\TEXT MINING")
library(rvest)
library(magrittr)
library(XML)


##imdb reviews on avengers
avengers <- NULL
rev <- NULL
aurl <- "https://www.imdb.com/title/tt4154796/reviews?ref_=tt_ql_3"
murl <- read_html(as.character(paste(aurl,1, sep = "")))
rev <- murl %>% 
html_nodes(".show-more__control") %>% 
html_text()
avengers <- c(avengers,rev)


write.table(avengers,"imdb2.txt")

####sentiment analysis###
library(syuzhet)
imdb <- readLines(file.choose())
s_v <- get_sentences(imdb)
sentiment_vector <- get_sentiment(s_v, method="bing")
head(sentiment_vector)
sum(sentiment_vector)
mean(sentiment_vector)
summary(sentiment_vector)


##negative sentiment

negative <- s_v[which.min(sentiment_vector)]
negative

###3positive sentiment

positive <- s_v[which.max(sentiment_vector)]
positive

###plot



plot(sentiment_vector,type = "l", main = "Plot Trajectory",
     xlab = "Narrative Time", ylab = "Emotional Valence")
abline(h= 0, col= "red")
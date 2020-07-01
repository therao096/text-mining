setwd("F:\\EXCEL R\\ASSIGNMENTS\\TEXT MINING")
library(rvest)
library(XML)       
library(magrittr)

##reviews of iphone on anmazon
aurl <- read_html("https://www.amazon.in/Apple-iPhone-XR-64GB-Black/product-reviews/B07JWV47JW")
amazon_reviews <- NULL
for (i in 2:20){
  murl <- read_html(as.character(paste(aurl,i,sep="")))
  rev <- murl %>%
    html_nodes(".review-text") %>%
    html_text()
  amazon_reviews <- c(amazon_reviews,rev)
}
write.table(amazon_reviews,"apple.txt")
write.xlsx(amazon_reviews,file = "Apple.xlsx")
getwd()

###########TEXT MINING###3
library(tm)
library(topicmodels)
library(slam)
apple <- readLines(file.choose()) ##import apple.txt
View(apple)
length(apple)

apple.corpus <- Corpus(VectorSource(apple))
apple.corpus <- tm_map(apple.corpus,removePunctuation)
stopwords <- readLines(file.choose())
apple.corpus <- tm_map(apple.corpus,removeWords,stopwords)
apple.corpus <- tm_map(apple.corpus,removeNumbers)
apple.corpus <- tm_map(apple.corpus,stripWhitespace)
write.table(apple.corpus,file = "Apple2.txt")
###build a term document matrix##3
apple.dtm <- TermDocumentMatrix(apple.corpus)
as.matrix(apple.dtm)
dim(apple.dtm)


####emotion mining
library(syuzhet)

mydata <- readLines(file.choose())
s_v <- get_sentences(mydata)
class(s_v)
head(s_v)
sentiment_vector <- get_sentiment(s_v,method = "bing")
head(sentiment_vector)
nrc_vector <- get_sentiment(s_v,method = "nrc")
head(nrc_vector)

sum(sentiment_vector)
mean(sentiment_vector)
summary(sentiment_vector)


###to get negative sentiment
negative <- s_v[which.min(sentiment_vector)]
negative
###Spotify is quite buggy, but then it was nearly as bad on my old phone, so that's probably a Spotify problem.

####to get positive sentiment
positive <- s_v[which.max(sentiment_vector)]
positive
###I love how the camera consistently delivers great images.

###plot
plot(sentiment_vector,type = "l", main = "Plot Trajectory",
     xlab = "Narrative Time", ylab = "Emotional Valence")
abline(h= 0, col= "red")
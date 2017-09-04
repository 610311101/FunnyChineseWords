library("tm");
library("Rwordseg");
library("slam");
library("magrittr");
setwd("C:/Users/Hou/Desktop");
source("FunnyChineseWords/TermDocumentMatrixCN.R")
##  
text <- Corpus(DirSource("FunnyChineseWords/400 texts data/"));
text <- text[1:400];
text <- tm_map(text,content_transformer(removePunctuation)) %>% 
  tm_map(content_transformer(removeNumbers)) %>%
  tm_map(content_transformer(function(word) {
    gsub("[A-Za-z0-9]", "", word)
  }))
text <- tm_map(text,content_transformer(segmentCN),returnType="tm")
tdm   <- TermDocumentMatrixCN(text,control=list(wordLengths = c(1, Inf)));
tdm <- as.matrix(tdm)
saveRDS(tdm,"tdm.RDS")

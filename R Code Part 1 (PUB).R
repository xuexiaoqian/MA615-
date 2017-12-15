#### Read the companion walkthrough here: prismoji.com/emoji-data-science-in-r-tutorial ####

# set up Twitter Authentication
library(twitteR)
library(reshape)

###### GRAB TWEETS, PROCESS, AND WRITE TO DISK ######
# authenticate with twitter: get your credentials by creating an app at apps.twitter.com
api_key <- 'LFNRqX5i1PkB69SjEEncXWloq'
api_secret <- '4sDHqY6aLm7PRfJLxpq6GsWqphZxzX3dXLjssSLXYhO8wPwL3F'
access_token <- '11180082-wcpSmzCjbvj0csDhtYP5z32sqzrDhxROEPW9ZNAJY'
access_token_secret <- 'mxdJoqVpb6dZPcTzko9YGcK1CbLmjKChCiJ5SpxKfDy7z'
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

# 2017.0202, #nobannowall
set.seed(20170202); ht <- '#fakenews'; 
tweets.raw <- searchTwitter(ht, n = 1000, lang = 'en');
df <- twListToDF(strip_retweets(tweets.raw, strip_manual = TRUE, strip_mt = TRUE)); df$hashtag <- ht; df$created <- as.POSIXlt(df$created); df$text <- iconv(df$text, 'latin1', 'ASCII', 'byte'); df$url <- paste0('https://twitter.com/', df$screenName, '/status/', df$id); df <- rename(df, c(retweetCount = 'retweets'));
df.a <- subset(df, select = c(text, created, url, latitude, longitude, retweets, hashtag));
nrow(df.a); head(df.a);
setwd('.../PRISMOJI/tutorial/');
write.csv(df.a, paste0('tweets.cleaned_', format(min(df.a$created), '%m%d'), '-', format(max(df.a$created), '%m%d'), '_', ht, '_', Sys.Date(), '_', format(Sys.time(), '%H-%M-%S'), '_n', nrow(df.a), '.csv'), row.names = FALSE);
tweets <- df; tweets$z <- 1; tweets$created <- as.POSIXlt(tweets$created); nrow(tweets); min(tweets$created); max(tweets$created); median(tweets$created);

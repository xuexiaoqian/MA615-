library(graphTweets)
library(igraph)
library(streamR)

load("my_oauth.Rdata")

#########################################



filterStream("tweetsUS.json", track=c("carpool"), 
             locations = c(-125, 25, -66,50),  timeout = 30,
             oauth = my_oauth)   

tweets.df <- parseTweets("tweetsUS.json", verbose = TRUE)



#check variable
names(tweets.df)

#build edge table
edges <- getEdges(tweets.df, "text", "in_reply_to_screen_name", 
                  "retweet_count", "favorited")

edges <- getEdges(tweets.df, tweets="text", source="screen_name")

g <- graph.data.frame(edges, directed=TRUE)

g <- graph.data.frame(edges)


plot(g)


#check output
names(edges)

nodes <- getNodes(edges, "source", "target")


#check return
names(nodes)


#create graph
graph <- graph.data.frame(edges, directed=TRUE, vertices=nodes)


#plot unconnected graph
plot(graph, layout=layout.fruchterman.reingold)








#######################################
                            

filterStream("tweetsUS.json", track=c("carpool"), 
             locations = c(-125, 25, -66,50),  timeout = 30,
             oauth = my_oauth)   

tweets.df <- parseTweets("tweetsUS.json", verbose = TRUE)

ck1 <- sum(tweets.df$lat>0, na.rm = TRUE)
ck1
ck2 <- sum(tweets.df$place_lat>0, na.rm = TRUE)
ck2
ck3 <- sum(!is.na(tweets.df$location))
ck3



library(ggplot2)   
library(grid)   

map.data <- map_data("state")   
points <- data.frame(x = as.numeric(tweets.df$lon),  
                       y = as.numeric(tweets.df$lat))



points <- points[points$y > 25, ]   
ggplot(map.data) + 
  geom_map(aes(map_id = region),  
           map = map.data,  
           fill = "white",             
           color = "grey20", size = 0.25) + 
  expand_limits(x = map.data$long, y = map.data$lat) +            
  theme(axis.line = element_blank(),  
        axis.text = element_blank(),  
        axis.ticks = element_blank(),                     
        axis.title = element_blank(),  
        panel.background = element_blank(),  
        panel.border = element_blank(),                     
        panel.grid.major = element_blank(), 
        plot.background = element_blank(),                     
        plot.margin = unit(0 * c( -1.5, -1.5, -1.5, -1.5), "lines")) +  
        geom_point(data = points,             
        aes(x = x, y = y), size = 1,  
        alpha = 1/5, color = "darkblue")  

noEn <- tweets.df[(tweets.df$lang != "en"),]

points1 <- data.frame(x = as.numeric(noEn$lon),  
                     y = as.numeric(noEn$lat))

ggplot(map.data) + 
  geom_map(aes(map_id = region),  
           map = map.data,  
           fill = "white",             
           color = "grey20", size = 0.25) + 
  expand_limits(x = map.data$long, y = map.data$lat) +            
  theme(axis.line = element_blank(),  
        axis.text = element_blank(),  
        axis.ticks = element_blank(),                     
        axis.title = element_blank(),  
        panel.background = element_blank(),  
        panel.border = element_blank(),                     
        panel.grid.major = element_blank(), 
        plot.background = element_blank(),                     
        plot.margin = unit(0 * c( -1.5, -1.5, -1.5, -1.5), "lines")) +  
  geom_point(data = points,             
             aes(x = x, y = y), size = 1,  
             alpha = 1/5, color = "red")  















#########################

sampleStream("tweetsSample.json", timeout = 120, oauth = my_oauth, verbose = TRUE)

tweets.df <- parseTweets("tweetsSample.json", verbose = TRUE)

mean(as.numeric(tweets.df$friends_count))

table(is.na(tweets.df$lat))

round(sort(table(tweets.df$lang), decreasing = T)[1:5]/sum(table(tweets.df$lang)), 2)

userStream("mytweets.json", timeout = 120, oauth = my_oauth, verbose = FALSE)

tweets.df <- parseTweets("mytweets.json", verbose = FALSE)
round(sort(table(tweets.df$lang), decreasing = T)[1:3]/sum(table(tweets.df$lang)), 2)




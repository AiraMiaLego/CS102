library(dplyr,dbplyr)
library(RMySQL)
library (RMariaDB)

#creating connections

connection <- dbConnect(RMySQL::MySQL(), 
                        dsn="MySQL-connection",
                        Server = "localhost",
                        dbname = "movie10_reviews", 
                        user = "root", 
                        password = "") #if you have a password


# Read the CSV file
movie<- read.csv(file = 'worksheet/CS 102/10Movies.csv')
movie

# Print the structure of the data frame
str(movie)

# Print the first few rows of the data frame
head(movie)

#only getting the data I want
movies<-movie[c(1,301,601,901,1201,1501,1801,2101,2401,2701),]
movies


View(movies)

#clean up the Review_Title column by removing leading, trailing and extra white spaces.
movies$Review_Title <- trimws(movies$Review_Title)
movies$Review_Title[1]<- substring(movies$Review_Title[1], 1, nchar(movies$Review_Title[1]) -1)
movies$Review_Title[1]<- substring(movies$Review_Title[1], 2, nchar(movies$Review_Title[1]) -0)

movies$Review_Title


#'\\s+' is a regular expression pattern that matches one or more white spaces.
# gsub() replaces all occurrences of the pattern with a single space.
movies$Rate <- gsub("\\s+", " ", movies$Rate)
movies$Rate <- trimws(movies$Rate)
movies$Rate

movies$Review_Title <- gsub("\\s+", " ", movies$Review_Title)
movies$Review_Title<-gsub("\\[\\d+\\] |\"", "", movies$Review_Title)
movies$Review_Title


dbWriteTable(connection,name="movie10",value=movies,row.names=FALSE,append=TRUE)
#listing the tables of the movie10_reviews 
dbListTables(connection)

#listing the fields of the authors in the table sample_db
dbListFields(connection,"movies")

glimpse(movies)
#disconnect from dbase

write.csv(movies, file = "10movies_mysql.csv")




dbDisconnect(connection)


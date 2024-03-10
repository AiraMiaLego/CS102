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
head(data)

#only getting the data I want
movies<-movie[c(1,301,601,901,1201,1501,1801,2101,2401,2701),]
movies

movies<-movies [c(-1)]
View(movies)

#clean up the Review_Title column by removing leading, trailing and extra white spaces.
movies$Review_Title <- trimws(movies$Review_Title)
movies
View(movies)

#'\\s+' is a regular expression pattern that matches one or more white spaces.
# gsub() replaces all occurrences of the pattern with a single space.
movies$Rate <- gsub("\\s+", " ", movies$Rate)
movies$Rate <- trimws(movies$Rate)
movies$Rate

View(movies)

movies$Review_Title <- gsub("\\s+", " ", movies$Review_Title)
movies$Review_Title

#I want the first line of movies$Review_Title which is "\"Gentlemen, you can't fight in here! This is the War Room.\"" 
#To be like this "Gentlemen, you can't fight in here! This is the War Room."

#substring(x, first, last) extracts substrings from x starting from first character to last character.
#Specify 2 as the starting position and nchar(movies$Title_review) - 1 as the ending position to exclude the first and last characters, which are the double quotes.
movies$Review_Title <- substring(movies$Review_Title, 2, nchar(movies$Review_Title) -1)
View(movies)


moviesQ<- character(nrow(movies))

for (i in 1:nrow(movies)){
  moviesQ[i]<- paste0("INSERT INTO movie10 (movie_title, reviewer, date_of_review, rating,  title_of_the_review,  review) VALUES('",
                      movies$movtitles[i], "', '",
                      movies$Username[i], "', '",
                      movies$Date[i], "', '",
                      movies$Rate[i], "', '",
                      movies$Review_Title[i], "', '",
                      movies$Review_Content[i], "')")
}
moviesQ[1]


#listing the tables of the movie10_reviews 
dbListTables(connection)

#listing the fields of the authors in the table sample_db
dbListFields(connection,"movies")

glimpse(movies)

write.csv(movies,file = "10Movies_mysql.csv")
#disconnect from dbase
dbDisconnect(connection)



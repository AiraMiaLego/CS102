library(dplyr,dbplyr)
library(RMySQL)
library (RMariaDB)

#creating connections

connection <- dbConnect(RMySQL::MySQL(), 
                        dsn="MySQL-connection",
                        Server = "localhost",
                        dbname = "movie_3k", 
                        user = "root", 
                        password = "") #if you have a password


# Read the CSV file
movie<- read.csv(file = 'worksheet/CS 102/10Movies.csv')
movie

# Print the structure of the data frame
str(movie)

# Print the first few rows of the data frame
head(movie)

movies<-movie [c(-1)]
View(movies)

#movietitles to lower case 
movies$movtitles<- tolower(movies$movtitles)
movies$movtitles

#reviewer to lower case
movies$Username<- tolower(movies$Username)
head(movies$Username)

#clean and turn the content into lower case
movies$Review_Content<- tolower(movies$Review_Content)
movies$Review_Content <- gsub("\\s+", " ", movies$Review_Content)
movies$Review_Content<-gsub("\\[\\d+\\] |\"", "", movies$Review_Content)
movies$Review_Content<- gsub("\\.\\.\\.", "", movies$Review_Content)
head(movies$Review_Content)


#clean up the Review_Title column by removing leading, trailing and extra white spaces.
movies$Review_Title<- tolower(movies$Review_Title)
movies$Review_Title <- trimws(movies$Review_Title)
head(movies$Review_Title)

#gsub() is used to substitute patterns in strings.
#\\[\\d+\\] matches the pattern [number], where \\[ matches the character [, \\d+ matches one or more digits, and \\] matches the character ].
movies$Review_Title <- gsub("\\[\\d+\\] |\"", "", movies$Review_Title)
head(movies$Review_Title)

#clean rates and change to numeric
movies$Rate <- gsub("\\s+", " ", movies$Rate)
movies$Rate <- trimws(movies$Rate)
glimpse(movies$Rate)

# Split the "Rate" column
rates <- strsplit(movies$Rate, "/")

# Define a function to convert and calculate ratio
ratesof<- function(x, y) {
  as.numeric(x) / as.numeric(y)
}

# Apply the function using mapply
ratios <- mapply(ratesof, sapply(rates, "[", 1), sapply(rates, "[", 2))

# Assign ratios to the "Rate" column
movies$Rate <- ratios
movies$Rate


date_obj <- as.Date(movies$Date, format = "%d %B %Y")
date_obj
movies$Date<-as.POSIXct(date_obj, format = "%d-%m-%Y")
head(movies$Date)

View(movies)



dbWriteTable(connection,name="movie_3k",value=movies,row.names=FALSE,append=TRUE)

#listing the tables of the movie10_reviews 
dbListTables(connection)

#listing the fields of the authors in the table sample_db
dbListFields(connection,"movies")

glimpse(movies)
#disconnect from dbase

write.csv(movies, file = "3000movies_mysql.csv")

dbDisconnect(connection)



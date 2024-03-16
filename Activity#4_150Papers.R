library(dplyr,dbplyr)
library(RMySQL)
library (RMariaDB)

#creating connections

connection <- dbConnect(RMySQL::MySQL(), 
                        dsn="MySQL-connection",
                        Server = "localhost",
                        dbname = "rvix_lego", 
                        user = "root", 
                        password = "") #if you have a password


# Read the CSV file
papers<- read.csv(file = 'worksheet/CS 102/WebScraping/DataScience.csv')

# Print the structure of the data frame
str(papers)

# Print the first few rows of the data frame
head(papers)

#only getting the data I want
paper2<-papers [c(-1)]
View(paper2)

#clean up the paper2$abstract column by removing leading, trailing, special caharacters and extra white spaces.
paper2$abstract <- trimws(paper2$abstract)
paper2$abstract
View(paper2)

paper2$abstract<- gsub("$", "", paper2$abstract )
paper2$abstract<- gsub("\"", "", paper2$abstract )
paper2$abstract
paper2$abstract <- gsub("[^a-zA-Z0-9,.?! ]", "", paper2$abstract)
paper2$abstract[1]<- gsub("\\s+", " ", paper2$abstract[1])

paper2<-`colnames<-`(paper2,c("title", "author", "subject", "abstract", "date"))

paper2

# Print the structure of the data frame
str(paper2)

# Print the first few rows of the data frame
head(paper2)

View(paper2)

dbWriteTable(connection,name="arvix_papers",value=paper2,row.names=FALSE,append=TRUE)

write.csv(paper2, file = "arvix_papers.csv")
save.csv

dbDisconnect(connection)



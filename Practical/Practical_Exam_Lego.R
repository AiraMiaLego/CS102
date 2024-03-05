warpbreaks

##1.Find out, in single command,which columns are either numeric or integer
num<-sapply(warpbreaks, function(x) is.numeric(x))
num
int<-sapply(warpbreaks, function(x) is.integer(x))
int

##2.My answer: No need to convert in integer.

##3.

##1.Read the complete file using readLines
num1b<-readLines("/cloud/project/Practical/exampleFile.txt ")
num1b

##2.Separate the vector lines containing comment and data
data<-grepl("//",num1b)
dat<-num1b[!data]
dat

comments<-grepl(";",num1b)
com<-num1b[!comments]
com

##3 Extract the date from first comment line

com1 <- com[1]
date <- gsub("//Survey data. Created :","",com1)
date

##4a.Read the data into matrix as follows:

##a.Split character vectors
split4a<-strsplit(num1b, ";")
split4a

##b. Find Maximum
max4b<- max(lengths(split4a))
split4a<- lapply(split4a, function(x){
  if (length(x)< max4b){
    x<- c(x, rep(NA, max4b - length(x)))
  }
  return(x)
})
split4a

##c. Use unlist and matix to transform the data to row-column format
mat4c<- matrix(unlist(split4a), ncol = max4b, byrow = TRUE)
mat4c

##d. Extract name of fields
unl4d<- unlist(strsplit(com[2:4], ";"))
colnames(mat4c)<- unl4d
unl4d

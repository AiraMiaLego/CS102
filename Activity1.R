library(rvest)
library(httr)
library(dplyr)
library(polite)

library(kableExtra)



polite::use_manners(save_as = 'polite_scrape.R')


url <- 'https://www.amazon.com/s?i=specialty-aps&bbn=16225007011&rh=n%3A16225007011%2Cn%3A172635&ref=nav_em__nav_desktop_sa_intl_printers_0_2_6_11'
session <- bow(url,
               user_agent = "Educational")


title<- character(0)


title_list<- scrape(session) %>%
  html_nodes('span.a-size-base-plus.a-color-base.a-text-normal') %>%
  html_text
title_list

title_list_sub <- as.data.frame(title_list[1:33])
colnames(title_list_sub) <- "Brand Description"
title_list_sub


#-------------------------------------------------------
price<- character(0)


price_list<- scrape(session) %>%
  html_nodes('span.a-price') %>%
  html_text
price_list

price_list_sub <- as.data.frame(price_list[1:33])
colnames(price_list_sub) <- "Price"
price_list_sub
split_df <- strsplit((price_list_sub$Price),"$",fixed = TRUE)
split_df <- data.frame(do.call(rbind,split_df))
split_df<-split_df[-2]


num1<- cbind(title_list_sub,split_df)
num1
#---------------------------------------------------------
rate<- character(0)


rate_list<- scrape(session) %>%
  html_nodes('span.a-size-base.s-underline-text') %>%
  html_text
rate_list

rate_list_sub <- as.data.frame(rate_list[1:33])
colnames(price_list_sub) <- "Ratings"
rate_list_sub

#----------------------------------------------------------
star<- character(0)


star_list<- scrape(session) %>%
  html_nodes('i.a-icon.a-icon-star-small.a-star-small-4-5.aok-align-bottom') %>%
  html_text
star_list

star_list_sub <- as.data.frame(star_list[1:33])
colnames(price_list_sub) <- "Star"
star_list_sub

num2<-cbind(num1,rate_list_sub,star_list_sub)
num2

View(num2)
#-----------------------------------------------------------
#-----------------------------------------------------------

url <- 'https://www.amazon.com/s?i=specialty-aps&bbn=16225007011&rh=n%3A16225007011%2Cn%3A1292115011&ref=nav_em__nav_desktop_sa_intl_monitors_0_2_6_8'
session <- bow(url,
               user_agent = "Educational")


title<- character(0)


title_list<- scrape(session) %>%
  html_nodes('span.a-size-base-plus.a-color-base.a-text-normal') %>%
  html_text
title_list

title_list_sub <- as.data.frame(title_list[1:30])
colnames(title_list_sub) <- "Brand Description"
title_list_sub

price<- character(0)


price_list<- scrape(session) %>%
  html_nodes('span.a-price') %>%
  html_text
price_list

price_list_sub <- as.data.frame(price_list[1:30])
colnames(price_list_sub) <- "Price"
price_list_sub
split_df <- strsplit((price_list_sub$Price),"$",fixed = TRUE)
split_df <- data.frame(do.call(rbind,split_df))
split_df<-split_df[-2]
split_df


num1<- cbind(title_list_sub,split_df)
num1

rate<- character(0)


rate_list<- scrape(session) %>%
  html_nodes('span.a-size-base.s-underline-text') %>%
  html_text
rate_list

rate_list_sub <- as.data.frame(rate_list[1:30])
colnames(price_list_sub) <- "Ratings"
rate_list_sub

star<- character(0)


star_list<- scrape(session) %>%
  html_nodes('i.a-icon.a-icon-star-small.a-star-small-4-5.aok-align-bottom') %>%
  html_text
star_list

star_list_sub <- as.data.frame(star_list[1:30])
colnames(price_list_sub) <- "Star"
star_list_sub

num2<-cbind(num1,rate_list_sub,star_list_sub)
num2<- num2[-2]
colnames(num2)<- c("Brand Description,","Product Price"," No. of Ratings","Ratings")


View(num2)


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

num1<- cbind(title_list_sub,price_list_sub)
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
  html_nodes('i.a-icon') %>%
  html_text
star_list

star_list_sub <- as.data.frame(star_list[1:33])
colnames(price_list_sub) <- "Star"
star_list_sub

num2<-cbind(num1,rate_list_sub,star_list_sub)
num2
#-----------------------------------------------------------
#-----------------------------------------------------------
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



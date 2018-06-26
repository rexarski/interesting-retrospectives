---
title: Basic Web Scraping with rvest
author: Qiu Rui
date: '2018-06-26'
slug: basic-web-scraping-with-rvest
categories:
  - R
tags:
  - rvest
---

The [post](https://datascienceplus.com/building-a-hacker-news-scraper-with-8-lines-of-r-code-using-rvest-library/) here demonstrates an example of Hacker News scraper with `rvest` library. 

But a tiny problem emerges as sometimes YC-funded startup post job ads on the front page so that the scraper would find different information vector with different lengths. Specifically, the it would not return any score value for that ad. One possible remedy is to log in as a real user, then do the scraping. In R, it is implemented as:

```r
library(rvest)

login <- 'https://news.ycombinator.com/login'
session <- html_session(login)
form <- html_form(session)[[1]]
filled_form <- set_values(form, acct='MyAccountName', pw='MyPassword')
submit_form(session, filled_form)
content <- jump_to(session, 'https://news.ycombinator.com/')

title <- content %>% html_nodes('a.storylink') %>% html_text()
link_domain <- content %>% html_nodes('span.sitestr') %>% html_text()
score <- content %>% html_nodes('span.score') %>% html_text()
age <- content %>% html_nodes('span.age') %>% html_text()
df <- data.frame(title = title, link_domain = link_domain, score = score, age = age)
```

The saved data frame would contain all the 30 links on the front page of Hacker News.

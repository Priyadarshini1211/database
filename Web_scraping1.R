  
#Load the libraries
library(tidyverse) #to manipulate
library(rvest) #to scrape
  
site_to_scrape <- read_html("http://quotes.toscrape.com/page/1")


#Scrape the first page of the site
content <- site_to_scrape %>% 
  html_nodes(".text") %>% 
  html_text()

#If necessary, scrape multiple pages
for(i in 2:4)
{
  site_to_scrape <- read_html(paste0("http://quotes.toscrape.com/page/",i))
  
  temp <- site_to_scrape %>% 
    html_nodes(".text") %>% 
    html_text()
  
  content <- append(content,temp)
  
}

write.csv(content,file= "content.csv",row.names = FALSE)
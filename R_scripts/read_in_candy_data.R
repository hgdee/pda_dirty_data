# Read in the candy data 
candy_data_1 <- read_excel(here::here("data/candy_ranking_data/boing-boing-candy-2016.xlsx"), na = "NA") %>% 
                          clean_names() 
candy_data_2 <- read_excel(here::here("data/candy_ranking_data/boing-boing-candy-2017.xlsx"), na = "NA") %>% 
                          clean_names()
candy_data_3 <- read_excel(here::here("data/candy_ranking_data/boing-boing-candy-2015.xlsx"), na = "NA") %>%
                          clean_names()
                          

# We don't know origin so can't cast to time stamp and, therefore, simply 
# cast as character with year as the string so we can merge
candy_data_1$timestamp <- as.character(candy_data_1$timestamp) 
candy_data_1$timestamp <- "2016"
candy_data_2$timestamp <- as.character(candy_data_2$timestamp)
candy_data_2$timestamp <- "2017"
candy_data_3$timestamp <- as.character(candy_data_3$timestamp)
candy_data_3$timestamp <- "2015"

# Make consistent NA values
candy_data_1$which_country_do_you_live_in <- candy_data_1$which_country_do_you_live_in %>%
  replace(., is.na(.), "NA")
candy_data_2$which_country_do_you_live_in <- candy_data_2$which_country_do_you_live_in %>%
  replace(., is.na(.), "NA")


# Convert the country types to a consistent format  - 2015 has no country data
country_convert_list <- c( "united states" = "usa", "united states of america" = "usa","america" = "usa","usa! usa! usa!" = "usa", "usa! usa! usa!" = "USA", "u.s." = "usa", 
                           "sub-canadian north usa... 'merica" = "usa", "usa of usa" = "usa", "the best one - usa" = "usa","murica" = "usa","^us$" = "usa", "usa of usa"= "usa",
                           "england" = "united kingdom","uk" = "united kingdom", "usaa." = "usa") 
candy_data_1$which_country_do_you_live_in <- str_replace_all(tolower(candy_data_1$which_country_do_you_live_in), country_convert_list)
                                                             
candy_data_2$which_country_do_you_live_in <- str_replace_all(tolower(candy_data_2$which_country_do_you_live_in), country_convert_list)
                                                             
#  we need to create a column for 2015 - candy_data_3 which has 5630  
#                                        candy_data_1 1259 
# It is assumed that as the data is untouched it is random and reflects 
# probable 'real' values
j <- 1
for(i in 1:nrow(candy_data_3)) {
  
  
  candy_data_3$which_country_do_you_live_in[i] =  
    candy_data_1$which_country_do_you_live_in[j]
  if(j == nrow(candy_data_1)){
    
    #We need to reset the candy_data_1 index
    j <- 1
    
  } else {
    
    j <- j + 1
    
  }
  
}


# Convert age to numeric
candy_data_1$how_old_are_you <- as.integer(candy_data_1$how_old_are_you)
candy_data_2$how_old_are_you <- as.integer(candy_data_2$how_old_are_you)
candy_data_3$how_old_are_you <- as.integer(candy_data_3$how_old_are_you)

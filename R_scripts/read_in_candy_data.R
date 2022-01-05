# Called from pda_dirty_data.Rmd
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



# Try a mutate
us_convert_list <- c( "united states", "united states of america","america","usa! usa! usa!" , "usa! usa! usa!" , "u.s." , 
                           "sub-canadian north usa... 'merica" , "usa of usa" , "the best one - usa" ,"murica" ,"^us$" , "usa of usa",
                            "usaa.", "usa","u.s.a.","america","u.s.", "usa usa", "usa usa usa","usa! usa!","usa!","usausausausa",
                            "unites states", "usa (i think but it's an election year so who can really tell)","usa!!!!!!","united states of america") 
candy_data_1 <- candy_data_1 %>% 
                  mutate(country = case_when( tolower(which_country_do_you_live_in)  %in% us_convert_list ~ "usa",
                                              tolower(which_country_do_you_live_in)  %in% c("england", "uk","united kindom","united kingdom") 
                                                                                                  ~ "united kingdom",
                                              TRUE ~ tolower(which_country_do_you_live_in)))

candy_data_2 <- candy_data_2 %>% 
  mutate(country = case_when( which_state_province_county_do_you_live_in  %in% us_convert_list ~ "usa",
                              which_country_do_you_live_in  %in% c("england", "uk","united kindom","united kingdom") 
                              ~ "united kingdom",
                              TRUE ~ tolower(which_country_do_you_live_in)))

# Make consistent NA values
candy_data_1$country <- candy_data_1$country %>%
  replace(., is.na(.), "NA")
candy_data_2$country <- candy_data_2$country %>%
  replace(., is.na(.), "NA")

#Get rid of the long country names
candy_data_1 <- candy_data_1 %>% select (1,2,3,4,124, everything())
candy_data_2 <- candy_data_2 %>% select (1,2,3,4,124, everything())


# Convert the country types to a consistent format  - 2015 has no country data
# country_convert_list <- c( "united states" = "usa", "united states of america" = "usa","america" = "usa","usa! usa! usa!" = "usa", "usa! usa! usa!" = "USA", "u.s." = "usa", 
  #                         "sub-canadian north usa... 'merica" = "usa", "usa of usa" = "usa", "the best one - usa" = "usa","murica" = "usa","^us$" = "usa", "usa of usa"= "usa",
   #                        "england" = "united kingdom","uk" = "united kingdom", "usaa." = "usa") 
#candy_data_1$which_country_do_you_live_in <- str_replace_all(tolower(candy_data_1$which_country_do_you_live_in), country_convert_list)
                                                             
#candy_data_2$which_country_do_you_live_in <- str_replace_all(tolower(candy_data_2$which_country_do_you_live_in), country_convert_list)
                                                             
#  we need to create columns for 2015 - candy_data_3 which has 5630  
#                             using           candy_data_1 1259 
# It is assumed that as the data is untouched it is random and reflects 
# probable 'real' values. 
# Also do the missing your_gender field at the same time

j <- 1
for(i in 1:nrow(candy_data_3)) {
  
  
  candy_data_3$country[i] =  
    candy_data_1$country[j]
  
  candy_data_3$your_gender[i] =  
    candy_data_1$your_gender[j]
  
#  candy_data_3$are_you_going_trick_or_treating[i] =  
#    candy_data_1$are_you_going_trick_or_treating[j]
  
  if(j == nrow(candy_data_1)){
    
    #We need to reset the candy_data_1 index
    j <- 1
    
  } else {
    
    j <- j + 1
    
 }
  
}

# Change the column order for candy_data_3 
candy_data_3 <- candy_data_3[,c(1,2,3,126,125, 4:124)]

# Convert age to numeric
candy_data_1$how_old_are_you <- as.integer(candy_data_1$how_old_are_you)
candy_data_2$how_old_are_you <- as.integer(candy_data_2$how_old_are_you)
candy_data_3$how_old_are_you <- as.integer(candy_data_3$how_old_are_you)

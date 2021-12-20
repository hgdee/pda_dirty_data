# Read in the candy data 
candy_data_1 <- read_excel(here::here("data/candy_ranking_data/boing-boing-candy-2016.xlsx"), na = "NA") %>% 
                          clean_names() 
candy_data_2 <- read_excel(here::here("data/candy_ranking_data/boing-boing-candy-2017.xlsx"), na = "NA") %>% 
                          clean_names()
candy_data_3 <- read_excel(here::here("data/candy_ranking_data/boing-boing-candy-2015.xlsx"), na = "NA") 
                          

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
candy_data_3$which_country_do_you_live_in <- candy_data_3$which_country_do_you_live_in %>%
  replace(., is.na(.), "NA")

# Convert the country types to a consistent format
str_replace_all(tolower(candy_data_1$which_country_do_you_live_in), 
                c("usa" ="USA", "united states" = "USA", "united states of america" = "USA","america" = "USA","usa! usa! usa!" = "USA", "USA! USA! USA!" = "USA", "u.s." = "USA", "us" = "USA", "sub-canadian north USA... 'merica" = "USA", "USA of USA" = "USA", "the best one - USA" = "USA","murica" = "USA") )
candy_data_2$which_country_do_you_live_in <- str_replace_all(tolower(candy_data_2$which_country_do_you_live_in), 
                c("usa" ="USA", "united states" = "USA", "united states of america" = "USA","america" = "USA","usa! usa! usa!" = "USA", "USA! USA! USA!" = "USA", "u.s." = "USA", "us" = "USA", "sub-canadian north USA... 'merica" = "USA", "USA of USA" = "USA", "the best one - USA" = "USA","murica" = "USA") )


# Convert age to numeric
candy_data_1$how_old_are_you <- as.integer(candy_data_1$how_old_are_you)
candy_data_2$how_old_are_you <- as.integer(candy_data_2$how_old_are_you)
candy_data_3$how_old_are_you <- as.integer(candy_data_3$how_old_are_you)
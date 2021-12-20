# Read in the candy data - starting with 'cleanest' header file
candy_data_1 <- read_excel(here::here("data/candy_ranking_data/boing-boing-candy-2016.xlsx")) %>% clean_names()
                    
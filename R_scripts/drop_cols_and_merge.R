# Called from pda_dirty_data.Rmd
# Handle dropping columns and merging the data

# List of 'starts with' values gained by examining data sets
drop_cols_list <- c("please","which_state","which_day", "sourpatch", "spotted_dick", "those",
                    "vials", "white", "whole", "guess", "betty", "that",
                    "what", "do", "when", "york", "cash", "glow", "broken",
                    "fuzzy", "dental", "candy_that_is", "creepy", "hugs",
                    "peterson", "generic", "sourpatch", "person", "please",
                    "anonymous","check_all_that_apply", "fill_in","if_you_squint",
                    "mini_bags","swedish_fish", "three_musketeers", "bonkers_the_board_game",
                    "lapel_pins", "bottle_caps","peeps", "mike_and_ike", "mr_goodbar",
                    "runts", "sea_salt", "mint_leaves", "kale_smoothie", "heath_bar",
                    "joy_joy", "peanut_butter_jars","mint_julep","nerds", "chardonnay",
                    "vicodin","any_full_size")

hit_list <- candy_data_1 %>% 
  select(starts_with(drop_cols_list))

# Set up operator to exclude
`%ni%` <- Negate(`%in%`)


candy_data_1 <- subset(candy_data_1,select = names(candy_data_1) %ni% (names(hit_list)))

hit_list <-candy_data_2 %>% 
  select(starts_with(drop_cols_list))

candy_data_2 <- subset(candy_data_2,select = names(candy_data_2) %ni% (names(hit_list)))

hit_list <- candy_data_3 %>% 
  select(starts_with(drop_cols_list))

candy_data_3 <- subset(candy_data_3,select = names(candy_data_3) %ni% (names(hit_list)))

# Try a merge on cleaner data sets
first_merge <- merge(candy_data_1,candy_data_2, by = intersect(names(candy_data_1), names(candy_data_2)),  all = TRUE, 
                     sort = TRUE,  no.dups = TRUE,
                     incomparables = NULL )

second_merge <- merge(first_merge,candy_data_3, by = intersect(names(first_merge), names(candy_data_3)),  all = TRUE, 
                      sort = TRUE,  no.dups = TRUE,
                      incomparables = NULL )

# Check we have no columns full of NA
names(which(colSums(is.na(second_merge)) == nrow(second_merge)))

# the data is now cleaned-ish and ready to use.
candy_data <- second_merge

# Change the order so that all non-candy columns are first - move gender
candy_data <- candy_data %>% select (1,2,3, 56, everything())

# Back up the data at this stage
write_rds(candy_data,here::here("Cleaned_data/candy_data.rds"))

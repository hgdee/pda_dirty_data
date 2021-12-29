# read_in_dog_survey.R
# called from pda_dirty_data.Rmd
dog_survey <- read.csv(here::here("data/dog_survey.csv"))  %>% clean_names()

# Get rid of duplicates
dog_survey <- dog_survey %>%
                unique()

# Cut out the currency figures
dog_survey$amount_spent_on_dog_food <- dog_survey$amount_spent_on_dog_food %>% 
                                          substring(3, )

# Convert to number

# Remove NA's
dog_survey %>%
  drop_na()

# Drop empty columns
dog_survey <- dog_survey %>%
                select(!x) %>%
                select(!x_1)

# Correct dog_age issues and convert to number
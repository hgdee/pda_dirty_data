# read_in_dog_survey.R
# called from pda_dirty_data.Rmd
# Howard Davies pda_dirty_data D12
dog_survey <- read.csv(here::here("data/dog_survey.csv"))  %>% clean_names()

# Get rid of duplicates
dog_survey <- dog_survey %>%
                unique()

# Cut out the currency figures
dog_survey$amount_spent_on_dog_food <- dog_survey$amount_spent_on_dog_food %>% 
                                          substring(3, )

# Convert to number
dog_survey$amount_spent_on_dog_food <- 
                    as.integer(dog_survey$amount_spent_on_dog_food)



# Drop empty columns
dog_survey <- dog_survey %>%
                select(!x) %>%
                select(!x_1)

# Correct dog_age issues and convert to number
dog_survey[dog_survey == "Less than 20"]  <- "19"
dog_survey[dog_survey == "12+"]  <- "12"
dog_survey  <- dog_survey %>% separate_rows(dog_age, sep = " and ", convert = TRUE)
dog_survey  <- dog_survey %>% separate_rows(dog_age, sep = ",", convert = TRUE)
dog_survey$dog_age <- as.integer(dog_survey$dog_age)

# Correct dog_gender issues
dog_survey  <- dog_survey %>% separate_rows(dog_gender, sep = " and ", convert = TRUE)
# dog_survey$dog_gender  <- dog_survey$dog_gender %>% separate_rows(dog_gender, sep = ",", convert = TRUE)
dog_survey[dog_survey == "1 female"]  <- "F"
dog_survey[dog_survey == "1 male"]  <- "M"
dog_survey[dog_survey == "femlae"]  <- "F"
dog_survey[dog_survey == "Female"]  <- "F"
dog_survey[dog_survey == "female"]  <- "F"
dog_survey[dog_survey == "Male"]  <- "M"
dog_survey[dog_survey == "male"]  <- "M"
dog_survey[dog_survey == "MALE"]  <- "M"
dog_survey[dog_survey == "^Don"]  <- "NA"
dog_survey[dog_survey == "Unknown"]  <- "NA"
dog_survey[dog_survey == "Unkown"]  <- "NA"
dog_survey[dog_survey == "-"]  <- "NA"
dog_survey[is.null(dog_survey)]  <- "NA"
dog_survey[dog_survey == "Smallish"]  <- "S"
dog_survey[dog_survey == "Medium sized"]  <- "M"
dog_survey[dog_survey == "large"]  <- "L"


# Remove rows with special characters etc. in gender field
dog_survey  <- dog_survey %>% filter(id != 117 & id != 208)

# This skews the amount spent on dog food column and id 174
dog_survey  <- dog_survey %>% separate_rows(dog_gender, sep = ",", convert = TRUE)
dog_survey  <- dog_survey %>% filter(dog_gender %in% c("M","F"))

# There should only be 3 for id 174 and there are 9 so clean up by hand
dog_survey <- dog_survey[-c(171,172,173,174,175,176),]
dog_survey[c(171),]$dog_size <- "S"
dog_survey[c(171),]$amount_spent_on_dog_food <- 33
dog_survey[c(171),]$dog_age <- 3
dog_survey[c(172),]$dog_size <- "L"
dog_survey[c(172),]$amount_spent_on_dog_food <- 33
dog_survey[c(172),]$id <- dog_survey %>% select(id)  %>% max() +1
dog_survey[c(173),]$dog_size <- "L"
dog_survey[c(173),]$amount_spent_on_dog_food <- 33
dog_survey[c(173),]$id <- dog_survey %>% select(id)  %>% max() +1

dog_survey[c(118),]$id <- dog_survey %>% select(id)  %>% max() +1
dog_survey[c(118),]$dog_age <- 4
dog_survey <- dog_survey[-c(119,120),]

# Not sure this is laid out right but...
## Not run: 
{
 
  dog_survey %>% assertr::verify(is_uniq(id))
}
## End (not run)

write_rds(dog_survey, here::here("Cleaned_data/dog_survey.rds"))



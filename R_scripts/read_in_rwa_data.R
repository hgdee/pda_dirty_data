
rwa_data <- read.csv(here::here("data/rwa.csv"))  %>% clean_names()

# Warm up questions are removed (2)
rwa_data <- rwa_data %>%
              select(!q1) %>%
              select(!q2)
             
# Reverse score 4,6,8,9,11,13,15,18,20,21
# As above the first two questions are removed so we need keys 1-20 as
# there were 22 questions . Keys are for use with the 'psych' package.
keys <- c(1, -1, 1, -1, 1, -1, -1, 1, -1, 1, -1, 1, -1, 1, 1, -1, 1, -1, -1, 1)
rwa_q1_q20 <- reverse.code(keys, rwa_data[1:20]) 


# Calculate the scores
#rwa_q1_q20 <- rwa_q1_20 %>%
#               mutate(rwa_score = sum(.))


# Now recombine the reversed columns with the original data
rwa_data_wrangled <- cbind( rwa_data[21:88], rwa_q1_q20)

rwa_data_wrangled <- rwa_data_wrangled %>%
                            mutate(rwa_score = 
                                   rowSums(across(starts_with("q")), na.rm = T))

rwa_data <- rwa_data_wrangled

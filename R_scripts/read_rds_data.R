# Called from pda_dirty_data.Rmd
decathlon_data <- read_rds("data/decathlon.rds") %>% clean_names()

# Make the rownames a column
decathlon_data <- cbind(rownames(decathlon_data),decathlon_data)
colnames(decathlon_data)[1]       <- "competitor"
rownames(decathlon_data) <- NULL

decathlon_data$competitor <- tolower(decathlon_data$competitor)
decathlon_data$competition <- tolower(decathlon_data$competition) 



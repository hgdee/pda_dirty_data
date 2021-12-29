# pda_dirty_data
 Dirty data project
## Howard Davies PDA for CodeClan 19/12/2021

This project is intended to read, clean up and analyse 
various data files for analysis. 

# Files:  
         # R Project pda_dirty_data  - runs the whole show
         ## R Notebook pda_dirty_data.Rmd 
         ### Answers to the analysis questions in Dirty Data Project Question 1
         ### Answers to the analysis questions in Dirty Data project Question 4
          your_gender values were consolidated to "Other" and NA's were ignored
          'any_full_sized_candy_bar' was considered a valid name as it had
          informational value - but as it was not a brand name answers where 
          it was the most popular were offered with two values, 
          the other being KitKat
         ## R_scripts directory
         ###  read_dirty_data.R reads decathlon rds data file
         #### Read in the rds file
         #### convert rownames to a column called competitor
         #### convert text to a consistent lower case
         ###  read_in_candy_data.R reads dirty candy data and renames columns, 
              amends data types, turns timestamps to "YYYY" character strings 
              for 2015, 2016 and 2017.
              converts country to consistent format using 2016 data to populate
              missing 2015 data.
              header was inserted in 2017
         ###  drop_cols_and_merge.R takes the three years of data and 
              drops irrelevant columns and reorders non-candy columns 
              and then merges the resultant data sets
         ###  read_in_rwa_data.R gets rwa data 
              drops Q1 and Q2 as they are warm up questions.
              Use the psych package to reverse scores on identified questions.
              calculate rwa_score of required columns using across and rowSums
         ## Data directory - input data with various data files, some unused
         ## Cleaned_data   - cleaned output saved for transparency and othe use
         ## Screenshots

# Fertility Rates
A Repository Where I Explore the Average Total Fertility Rate by Geographic Region for the Last 50 Years

This case study aimed to answer the following question: What was the Average Total Fertility Rate by Geographic Region from 1960 to 2021? I used data from a [World Bank dataset](https://data.worldbank.org/indicator/SP.DYN.TFRT.IN?end=2021&start=2021&view=map&year=2021), which contains country names and their respective total fertility rates by year. 

By answering this question, I was able to find the general worldwide trend of average total fertility rates. 

Below are some of the questions I used to guide myself as I completed this case study. This guide is broken up into six sections: 
  1. [Ask](#Ask)
  2. [Prepare](#Prepare)
  3. [Process](#Process)
  4. [Analyze](#Analyze)
  5. [Share](#Share)
  6. [Act](#Act)

# Ask
Guiding questions:
- What is the problem you are trying to solve? 
    - For this case study, we are trying to answer the following question: What was the Average Total Fertility Rate by Geographic Region for the last 50 years?
- How can your insights drive business decisions?
    - My insights will shed light on the general trend of average total fertility rates worldwide.

# Prepare
Guiding questions:
- Where is your data located? 
    - My data is located on the [World Bank](https://data.worldbank.org/indicator/SP.DYN.TFRT.IN?end=2021&start=2021&view=map&year=2021) website.
- How is the data organized? 
    - This dataset is a csv file. It contains country names and their respective total fertility rates by year.  
- Are there issues with bias or credibility in this data? Does your data ROCCC (i.e., is it reliable, original, comprehensive, current, and cited)?
    - The data seems reliable, original, comprehensive, and current. 
- How are you addressing licensing, privacy, security, and accessibility? 
    - The data has a Creative Commons Attribution 4.0 International license (CC-BY 4.0). Hence, I plan to cite the dataset I'm using. 
- How did you verify the data’s integrity? 
    - The World Bank is known for having high-quality data. 
- How does the data help you answer your question?
    - This data set will allow me to look, on a country-by-bountry basis, at different trends as they relate fertility rates.
- Are there any problems with the data?
    - This data set will allow one to see *how* fertility rates are changing, but not *why* they are changing. 

# Process
Guiding questions:
- What tools are you choosing and why?
    - This data set is not too large, and I enjoy using R, so I plan to use R.
- Have you ensured your data’s integrity?
    - Yes, this data ROCCC's! (i.e., it is reliable, original, comprehensive, current, and cited).
- What steps have you taken to ensure that your data is clean?
    -  This data set is not too large, so I just used the following functions to ensure the data did not have any incongruencies
        - colnames(fertility_rates)  # Column names
        - nrow(fertility_rates)  # Number of rows
        - dim(fertility_rates)  # Dimensions
        - head(fertility_rates)  # First 6 rows of data frame
        - str(fertility_rates)  # Columns and respective data types (numeric, character, etc)
        - summary(fertility_rates)  # Statistical summary of data. Mainly for numerics
- How can you verify that your data is clean and ready to analyze?
    - I double-checked the data the ensure that any non-trivial information was not missing.  
- Have you documented your cleaning process so you can review and share those results?
    - Yes, the cleaning process is part of my fertility_rates.R file. 

# Analyze
Guiding questions:
- How should you organize your data to perform analysis on it?
    - I am going to do three things:
        1. I plan to map Average Total Fertility Rates in 1960 vs. Average Total Fertility Rates in 2021,
           to get an understanding of the general trend of Average Total Fertility Rates. 
        2. I plan to split the geographical regions into six groups: North America, South America, Europe, Asia, Africa, Oceania.
- Has your data been properly formatted?
    - Yes. During the analysis stage, I plan to re-shape the data from a wide to a long format.
- What surprises did you discover in the data?
    - The country 'Yemen, Rep' at one point in time had an average total fertility rate of 9!
    - Israel's fertility rate is actually increasing, and is one of a few outliers with respect to the trend of its total fertility rates. 
- What trends or relationships did you find in the data?
    - That nearly *every* country in the last few decades has experienced a decrease in fertility rates. 
- How will these insights help answer your case study questions?
    - These insights indicate that many countries have for the last 50 years been experiencing a non-trivial decrease in fertility rates.

# Share
Guiding questions:
- Were you able to answer the original question?
    - Yes. The original question was the following: What was the Average Total Fertility Rate by Geographic Region for the last 50 years?
    - By creating a tableau dashboard, anyone can see what the total fertility rate is on a yearly basis for a geographic region. 
- What story does your data tell?
    - The story is likely one of concern. If fertility rates continue to drop in the coming decades as precipitously as they have in the last few decades, there will likely be many distastrous knock-on effects economically.  
- How do your findings relate to your original question?
    - By performing an analysis using R and creating a Tableau dashboard, my findings allow me to see nearly *every* country's average total fertility rate at a given time period. 
- Who is your audience? What is the best way to communicate with them?
    - I think the audience of my data set is primarily younger people. I think it's important that everyone understand the marked drop over time in average total fertility rates across nearly every geographic region. 
- Can data visualization help you share your findings?
    - Yes -- visualizations have helped me considerably to share my findings!
- Is your presentation accessible to your audience?
    - Yes, the dashboard is on Tableau. See (here)[https://public.tableau.com/app/profile/bradley.cardona/viz/AverageFertilityRatebyRegion1960-2021/Dashboard2]

# Act
Guiding questions:
- What is your final conclusion based on your analysis?
    - To re-iterate, nearly *every* country has experienced, is experiencing, or likely will experience a sharp decrease in average total fertility rates. 
- What next steps would you or your stakeholders take based on your findings?
    - If I were to continue my analysis, I would look at the following:
        - The factors contributing to the rapid decrease in fertility rates. 
        - The future "success" of older parents relative to the future "success" of younger parents
        - The percentage of people in each geographical region who regret not having had a child
- Is there additional data you could use to expand on your findings?
    - Yes. As to which data, however, I am not yet sure.

### Case Study: Fertility Rate Averages Across Countries in last 50 Years ###
# Dataset: https://data.worldbank.org/indicator/SP.DYN.TFRT.IN?end=2021&start=2021&view=map&year=2021
# Question: How have 
#========================================
# Install required packages
# tidyverse for data import and wrangling
# lubridate for date functions
# ggplot for visualization
# readxl for reading Excel files
# maps to generate maps
#========================================

library(tidyverse)  #helps wrangle data
library(lubridate)  #helps wrangle date attributes
library(ggplot2)  #helps visualize data
library(readxl)
getwd() #displays your working directory
# setwd("") #sets your working directory to simplify calls to data

#=====================
# STEP 1: COLLECT DATA
#=====================

# Note: Deleted manually first two rows of table in Excel
fertility_rates <- read_xls("Documents/data_analytics/fertility_rate_case_study/fertility_rates.xls")
head(fertility_rates)
View(fertility_rates)

#====================================================
# STEP 2: WRANGLE DATA AND COMBINE INTO A SINGLE FILE
#====================================================

# Inspect the table and look for incongruencies
colnames(fertility_rates)  # Column names
nrow(fertility_rates)  # Number of rows
dim(fertility_rates)  # Dimensions
head(fertility_rates)  # First 6 rows of data frame
str(fertility_rates)  # Columns and respective data types (numeric, character, etc)
summary(fertility_rates)  # Statistical summary of data. Mainly for numerics

# delete two columns: "Indicator Name" and "Indicator Code"
fertility_rates <- fertility_rates %>% 
  select(-c("Indicator Name", "Indicator Code"))

#======================================================
# STEP 3: CLEAN UP AND ADD DATA TO PREPARE FOR ANALYSIS
#======================================================
# Inspect the new table that has been created
colnames(fertility_rates)  # Column names
nrow(fertility_rates)  # Number of rows
dim(fertility_rates)  # Dimensions
head(fertility_rates)  # First 6 rows of data frame
str(fertility_rates)  # Columns and respective data types (numeric, character, etc)
summary(fertility_rates)  # Statistical summary of data. Mainly for numerics

#=====================================
# STEP 4: CONDUCT DESCRIPTIVE ANALYSIS
#=====================================
# Descriptive analysis on average birth rates per country in 1960 
summary(fertility_rates$"1960")

# Compare average fertility rates in 1960 vs. average fertility rates in 2021
aggregate(fertility_rates$"1960" ~ fertility_rates$"2021", FUN = mean)
aggregate(fertility_rates$"1960" ~ fertility_rates$"2021", FUN = median)
aggregate(fertility_rates$"1960" ~ fertility_rates$"2021", FUN = max)
aggregate(fertility_rates$"1960" ~ fertility_rates$"2021", FUN = min)

# The average fertility rate by Country Code in 1960 vs. 2021
aggregate(fertility_rates$"1960" ~ fertility_rates$"2021" + fertility_rates$"Country Code", FUN = mean)

# The average fertility rate by Country Name in 1960 vs. 2021
aggregate(fertility_rates$"1960" ~ fertility_rates$"2021" + fertility_rates$"Country Name", FUN = mean)

# assign "average fertility rate by Country Name in 1960 vs. 2021" to variable avg_birth_rate
avg_fertility_rate <- aggregate(fertility_rates$"1960" ~ fertility_rates$"2021" + fertility_rates$"Country Name", FUN = mean)

#=====================================
# STEP 4: CREATE FIGURES
#=====================================

# Create a scatter plot of the data
ggplot(avg_fertility_rate, aes(x = `fertility_rates$"2021"`, y = `fertility_rates$"1960"`)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  xlab("Average Fertility Rate in 2021") +
  ylab("Average Fertility Rate in 1960") +
  ggtitle("Average Fertility Rate by Country Name in 1960 vs. 2021")

# Reshape the data from wide to long format
fertility_rates_long <- fertility_rates %>%
  pivot_longer(cols = `1960`:`2021`,
               names_to = "Year",
               values_to = "Fertility_Rate")

# Create a line graph
ggplot(fertility_rates_long, aes(x = Year, y = Fertility_Rate, color = `Country Name`)) +
  geom_line() +
  xlab("Year") +
  ylab("Fertility Rate") +
  ggtitle("Average Fertility Rate by Country Name")

# Find unique country names in fertility_rates table
country_names <- unique(fertility_rates$`Country Name`)
sorted_country_names <- sort(country_names)

#=========================================================
# Average Fertility Rate in European Countries (1960-2021)
#=========================================================

# Filter the dataset to include only Euopean countries
european_countries <- c("Albania", "Andorra", "Austria", "Belarus", "Belgium", "Bosnia and Herzegovina", "Bulgaria", "Channel Islands", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Faroe Islands", "Finland", "France", "Germany", "Gibraltar", "Greece", "Hungary", "Iceland", "Ireland", "Isle of Man", "Italy", "Latvia", "Liechtenstein", "Lithuania", "Luxembourg", "Malta", "Moldova", "Monaco", "Montenegro", "Netherlands", "North Macedonia", "Norway", "Poland", "Portugal", "Romania", "Russian Federation", "San Marino", "Serbia","Slovakia","Slovenia","Spain","Sweden","Switzerland","Ukraine","United Kingdom","Vatican City")


# Replace with the list of European countries
fertility_rates_europe <- fertility_rates %>%
  filter(`Country Name` %in% european_countries)

# Reshape the data from wide to long format
fertility_rates_long <- fertility_rates_europe %>%
  pivot_longer(cols = `1960`:`2021`,
               names_to = "Year",
               values_to = "Fertility_Rate")

# Create the plot with custom x-axis labels
p <- ggplot(fertility_rates_long, 
            aes(x = Year, 
                y = Fertility_Rate, 
                color = `Country Name`, 
                group = `Country Name`)) +
  geom_line() +
  xlab("Year") +
  ylab("Fertility Rate") +
  ggtitle("Average Fertility Rate in European Countries (1960-2021)") +
  scale_x_discrete(breaks = seq(1960, 2021, by = 5)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Save the plot to a file with a resolution of 400 dpi
ggsave("Documents/data_analytics/fertility_rate_case_study/figures/fertility_rates_europe.png", 
       plot = p, 
       width = 10, 
       dpi = 1000)


#=========================================================
# Average Fertility Rate in African Countries (1960-2021)
#=========================================================

# Filter the dataset to include only African countries
african_countries <- c("Angola", "Benin", "Burkina Faso", "Burundi", "Cabo Verde", "Cameroon", "Central African Republic", "Chad", "Comoros", "Congo, Dem. Rep.", "Congo, Rep.", "Cote d'Ivoire", "Djibouti", "Egypt, Arab Rep.", "Equatorial Guinea", "Eritrea", "Eswatini", "Ethiopia", "Gabon", "Gambia, The", "Ghana", "Guinea", "Guinea-Bissau", "Kenya", "Lesotho", "Liberia", "Libya", "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Morocco", "Mozambique", "Namibia", "Niger", "Nigeria", "Rwanda", "Sao Tome and Principe", "Senegal", "Seychelles", "Sierra Leone", "Somalia", "South Africa", "South Sudan", "Sudan", "Tanzania", "Togo", "Tunisia", "Uganda", "Zambia", "Zimbabwe")

# Replace with the list of African countries
fertility_rates_africa <- fertility_rates %>%
  filter(`Country Name` %in% african_countries)

# Reshape the data from wide to long format
fertility_rates_long <- fertility_rates_africa %>%
  pivot_longer(cols = `1960`:`2021`,
               names_to = "Year",
               values_to = "Fertility_Rate")

# Create the plot with custom x-axis labels
p <- ggplot(fertility_rates_long, 
            aes(x = Year, 
                y = Fertility_Rate, 
                color = `Country Name`, 
                group = `Country Name`)) +
  geom_line() +
  xlab("Year") +
  ylab("Fertility Rate") +
  ggtitle("Average Fertility Rate in African Countries (1960-2021)") +
  scale_x_discrete(breaks = seq(1960, 2021, by = 5)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Save the plot to a file with a resolution of 400 dpi
ggsave("Documents/data_analytics/fertility_rate_case_study/figures/fertility_rates_africa.png",
       plot = p,
       width = 10,
       dpi = 1000)

#=========================================================
# Average Fertility Rate in Asian Countries (1960-2021)
#=========================================================
# Filter the dataset to include only Asian countries
asian_countries <- c("Afghanistan", "Armenia", "Azerbaijan", "Bahrain", "Bangladesh", "Bhutan", "Brunei Darussalam", "Cambodia", "China", "Georgia", "Hong Kong SAR, China", "India", "Indonesia", "Iran, Islamic Rep.", "Iraq", "Israel", "Japan", "Jordan", "Kazakhstan", "Korea, Dem. People's Rep.", "Korea, Rep.", "Kuwait", "Kyrgyz Republic", "Lao PDR", "Lebanon", "Macao SAR, China", "Malaysia", "Maldives", "Mongolia", "Myanmar", "Nepal", "Oman", "Pakistan","Palestine","Philippines","Qatar","Russian Federation","Saudi Arabia","Singapore","Sri Lanka","Syrian Arab Republic","Taiwan, China","Tajikistan","Thailand","Timor-Leste","Turkey","Turkmenistan","United Arab Emirates","Uzbekistan","Vietnam","Yemen, Rep.")

# Replace with the list of Asian countries
fertility_rates_asia <- fertility_rates %>%
  filter(`Country Name` %in% asian_countries)

# Reshape the data from wide to long format
fertility_rates_long <- fertility_rates_asia %>%
  pivot_longer(cols = `1960`:`2021`,
               names_to = "Year",
               values_to = "Fertility_Rate")

# Create the plot with custom x-axis labels
p <- ggplot(fertility_rates_long, 
            aes(x = Year, 
                y = Fertility_Rate, 
                color = `Country Name`, 
                group = `Country Name`)) +
  geom_line() +
  xlab("Year") +
  ylab("Fertility Rate") +
  ggtitle("Average Fertility Rate in Asian Countries (1960-2021)") +
  scale_x_discrete(breaks = seq(1960, 2021, by = 5)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Save the plot to a file with a resolution of 400 dpi
ggsave("Documents/data_analytics/fertility_rate_case_study/figures/fertility_rates_asia.png",
       plot = p,
       width = 10,
       dpi = 1000)

#===============================================================
# Average Fertility Rate in North American Countries (1960-2021)
#===============================================================

# Filter the dataset to include only North American countries
north_american_countries <- c("Antigua and Barbuda", "Bahamas, The", "Barbados", "Belize", "Canada", "Costa Rica", "Cuba", "Dominica", "Dominican Republic", "El Salvador", "Greenland", "Grenada", "Guatemala", "Haiti", "Honduras", "Jamaica", "Mexico", "Nicaragua", "Panama", "St. Kitts and Nevis", "St. Lucia", "St. Vincent and the Grenadines", "Trinidad and Tobago", "United States")

# Replace with the list of North American countries
fertility_rates_north_america <- fertility_rates %>%
  filter(`Country Name` %in% north_american_countries)

# Reshape the data from wide to long format
fertility_rates_long <- fertility_rates_north_america %>%
  pivot_longer(cols = `1960`:`2021`,
               names_to = "Year",
               values_to = "Fertility_Rate")

# Create the plot with custom x-axis labels
p <- ggplot(fertility_rates_long, 
            aes(x = Year, 
                y = Fertility_Rate, 
                color = `Country Name`, 
                group = `Country Name`)) +
  geom_line() +
  xlab("Year") +
  ylab("Fertility Rate") +
  ggtitle("Average Fertility Rate in North American Countries (1960-2021)") +
  scale_x_discrete(breaks = seq(1960, 2021, by = 5)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the plot to a file with a resolution of 400 dpi
ggsave("Documents/data_analytics/fertility_rate_case_study/figures/fertility_rates_north_america.png",
       plot = p,
       width = 10,
       dpi = 1000)

#===============================================================
# Average Fertility Rate in South American Countries (1960-2021)
#===============================================================

# Filter the dataset to include only South American countries
south_american_countries <- c("Argentina", "Bolivia", "Brazil", "Chile", "Colombia", "Ecuador", "Guyana", "Paraguay", "Peru", "Suriname", "Uruguay", "Venezuela")

# Replace with the list of South American countries
fertility_rates_south_america <- fertility_rates %>%
  filter(`Country Name` %in% south_american_countries)

# Reshape the data from wide to long format
fertility_rates_long <- fertility_rates_south_america %>%
  pivot_longer(cols = `1960`:`2021`,
               names_to = "Year",
               values_to = "Fertility_Rate")

# Create the plot with custom x-axis labels
p <- ggplot(fertility_rates_long, 
            aes(x = Year, 
                y = Fertility_Rate, 
                color = `Country Name`, 
                group = `Country Name`)) +
  geom_line() +
  xlab("Year") +
  ylab("Fertility Rate") +
  ggtitle("Average Fertility Rate in South American Countries (1960-2021)") +
  scale_x_discrete(breaks = seq(1960, 2021, by = 5)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the plot to a file with a resolution of 400 dpi
ggsave("Documents/data_analytics/fertility_rate_case_study/figures/fertility_rates_south_america.png",
       plot = p,
       width = 10,
       dpi = 1000)


#===============================================================
# Average Fertility Rate in Oceanic Countries (1960-2021)
#===============================================================

# Filter the dataset to include only Oceanic countries
oceanic_countries <- c("Australia", "Fiji", "Kiribati", "Marshall Islands", "Micronesia, Fed. Sts.", "Nauru", "New Zealand", "Palau", "Papua New Guinea", "Samoa", "Solomon Islands", "Tonga", "Tuvalu", "Vanuatu")

# Replace with the list of Oceanic countries
fertility_rates_oceania <- fertility_rates %>%
  filter(`Country Name` %in% oceanic_countries)

# Reshape the data from wide to long format
fertility_rates_long <- fertility_rates_oceania %>%
  pivot_longer(cols = `1960`:`2021`,
               names_to = "Year",
               values_to = "Fertility_Rate")

# Create the plot with custom x-axis labels
p <- ggplot(fertility_rates_long, 
            aes(x = Year, 
                y = Fertility_Rate, 
                color = `Country Name`, 
                group = `Country Name`)) +
  geom_line() +
  xlab("Year") +
  ylab("Fertility Rate") +
  ggtitle("Average Fertility Rate in Oceanic Countries (1960-2021)") +
  scale_x_discrete(breaks = seq(1960, 2021, by = 5)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the plot to a file with a resolution of 400 dpi
ggsave("Documents/data_analytics/fertility_rate_case_study/figures/fertility_rates_oceania.png",
       plot = p,
       width = 10,
       dpi = 1000)

#===============================================================
# Average Fertility Rate by Region (1960-2021)
#===============================================================

# Combine the data for all regions into one data frame
fertility_rates_all_regions <- bind_rows(
  fertility_rates_africa %>% mutate(Region = "Africa"),
  fertility_rates_asia %>% mutate(Region = "Asia"),
  fertility_rates_europe %>% mutate(Region = "Europe"),
  fertility_rates_north_america %>% mutate(Region = "North America"),
  fertility_rates_oceania %>% mutate(Region = "Oceania"),
  fertility_rates_south_america %>% mutate(Region = "South America")
)

# Reshape the data from wide to long format
fertility_rates_long <- fertility_rates_all_regions %>%
  pivot_longer(cols = `1960`:`2021`,
               names_to = "Year",
               values_to = "Fertility_Rate")

# Create the plot with custom x-axis labels and facets
p1 <- ggplot(fertility_rates_long, 
             aes(x = Year, 
                 y = Fertility_Rate, 
                 color = `Country Name`, 
                 group = `Country Name`)) +
  geom_line() +
  xlab("Year") +
  ylab("Fertility Rate") +
  ggtitle("Average Fertility Rate by Region (1960-2021)") +
  scale_x_discrete(breaks = seq(1960, 2021, by = 5)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none") +
  facet_wrap(~ Region)

# Save the plot with the graphs to a file with a resolution of 400 dpi
ggsave("Documents/data_analytics/fertility_rate_case_study/figures/fertility_rates_all_regions_graphs.png",
       plot = p1,
       width = 10,
       dpi = 1000)

#===============================================================
# STEP 5: CREATE INTERACTIVE DASHBOARD
#===============================================================

# Export the data to a CSV file for Tableau visualization
write.csv(fertility_rates_long, 
          "Documents/data_analytics/fertility_rate_case_study/fertility_rates_all_regions.csv",
          row.names = FALSE)



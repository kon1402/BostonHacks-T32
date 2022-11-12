# Packages used
install.packages("ggplot2")
install.packages("plotly")
install.packages("dplyr")
library(ggplot2)
library(plotly)
library(dplyr)

# Data source: https://www.kaggle.com/datasets/tunguz/drug-use-by-age
drug_use_by_age <- read.csv(file = 'drug_use_by_age.csv')

# Cleaning dataset
college_age_drugs <- drug_use_by_age[-c(1:5, 12:17), ]  # only college age rows

college_age_drugs <- select(college_age_drugs, -contains("frequency"))  # only by percent use
college_age_drugs <- college_age_drugs %>% select(1, 3, 4, 5, 10, 12)

college_age_drugs <- college_age_drugs %>% 
  rename(`Age`=`age`) %>%
  rename(`Percent using alcohol` = `alcohol-use`) %>%
  rename(`Percent using marijuana` = `marijuana-use`) %>%
  rename(`Percent using cocaine` = `cocaine-use`) %>%
  rename(`Percent using pain relievers` = `pain-releiver-use`) %>%
  rename(`Percent using tranquilizers` = `tranquilizer-use`)

# Creating legend reference
colors <- c("Alcohol" = "darkred", "Marijuana" = "steelblue", "Cocaine" = "darkgreen",
            "Pain Reliever" = "darkorange", "Tranquiilizer" = "gold")

# Creating multi-line graph
d <- ggplot(data = college_age_drugs, aes(x = Age, group = 1)) +
  geom_line(aes(y = `Percent using alcohol`, color = "Alcohol")) + 
  geom_point(aes(y = `Percent using alcohol`, color = "Alcohol")) +
               
  geom_line(aes(y = `Percent using marijuana`, color = "Marijuana")) +
  geom_point(aes(y = `Percent using marijuana`, color = "Marijuana")) +
               
  geom_line(aes(y = `Percent using cocaine`, color = "Cocaine")) +
  geom_point(aes(y = `Percent using cocaine`, color = "Cocaine")) +
    
  geom_line(aes(y = `Percent using pain relievers`, color = "Pain Reliever")) +
  geom_point(aes(y = `Percent using pain relievers`, color = "Pain Reliever")) +
    
  geom_line(aes(y = `Percent using tranquilizers`, color = "Tranquiilizer")) +
  geom_point(aes(y = `Percent using tranquilizers`, color = "Tranquiilizer")) +

  labs(title = "Frequency of drug use over 12 months of different college age groups",
                y = "Percent Use", x = "Age",
                color = "Legend") +
  
  scale_color_manual(values = colors)

# Making graph interactive using ggplotly
final <- ggplotly(d, tooltip=c("Age","Percent using alcohol","Percent using marijuana", "Percent using cocaine", 
                      "Percent using pain relievers", "Percent using tranquilizers"))

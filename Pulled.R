library(tidyverse)
library(ggplot2)
install.packages("dplyr")
library(dplyr)
install.packages("devtools")
library(devtools)
library(usethis)
install.packages("ggimage")
library(ggimage)

ggplot(data = Pulled_Sheet1, 
       mapping = aes(x = FB_Pulled_Percentage, y = weighted_Runs_Created, label = Team)) +
  geom_text() +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE) +
  scale_x_continuous(limits = c(12, 18), breaks = seq(10, 18, by = 0.5)) +
  labs(title = "MLB Teams Pulled FB% and wRC+",
       x = "Pulled FB%",
       y = "wRC+",
       caption = "Data from FG and Baseball Savant by Ethan Mann", "Correlation": round(correlation, 2))) +
  theme(plot.title = element_text(hjust = 0.5))
ggsave("PulledFBwRC+.png", width = 7.5, height = 5)


ggplot(data = Pulled_Sheet1, 
       aes(x = Isolated_Power, y = weighted_Runs_Created)) +
  geom_mlb_logos(aes(team_abbr= Team), width=0.050)+
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE) +
  labs(title = "MLB Teams ISO% and wRC+",
       x = "ISO%",
       y = "wRC+",
       caption = paste("Data from FG by Ethan Mann")) +
  theme(plot.title = element_text(hjust = 0.5))
ggsave("PulledISOwRC.png", width = 7.5, height = 5)

# Calculate the correlation coefficient
correlation <- cor(Pulled_Sheet1$FB_Pulled_Percentage, Pulled_Sheet1$weighted_Runs_Created)

# Create the ggplot
p <- ggplot(data = Pulled_Sheet1,
            aes(x = FB_Pulled_Percentage, y = weighted_Runs_Created, label = Team)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE) +
  scale_x_continuous(limits = c(12, 18), breaks = seq(12, 18, by = 0.5)) +
  geom_text(aes(x = 12, y = max(Pulled_Sheet1$weighted_Runs_Created) - 1, label = paste("Correlation =", round(correlation, 2)), hjust = 0))

print(p)

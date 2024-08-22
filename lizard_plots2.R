library("tidyverse")
library("here")
library("janitor")
library("patchwork")
library("here")

lizards <- read_csv(here("data_tidy", "lizards.csv"))

two_lizards <- lizards %>% 
  filter(common_name %in% c("eastern fence", "western whiptail"))

#putting legends in good places ----

p1 <- ggplot(data = two_lizards, aes(x = total_length, y = weight)) +
  geom_point(aes(color = common_name,
                 shape = common_name),
             size = 2) +
  theme_minimal() +
  scale_color_manual(name = "Lizard species:",
                     values = c("orange", "navy"),
                     labels = c("Eastern fence lizard", "Western whiptail")) +
  scale_shape_discrete(name = "Lizard species:",
                       labels = c("Eastern fence lizard", "Western whiptail")) +
  
  theme(legend.position = c(0.2, 0.8),
        legend.background = element_blank())

#boxplots ----
p2 <- ggplot(data = lizards, aes(x = weight, y = site))+
  geom_boxplot()+
  labs(x = "Weight (grams",
       y = "Site")

p3 <- ggplot(data = lizards, aes(x = weight,)) +
  geom_histogram()+
  labs(x = "Weight (grams",
       y = "Counts (n)")

#how to show multiple unique graphs/compound figures
#and add themes to all
#how to save as png ----
p4 <- ((p1 +p2)/p3) & theme_minimal()
ggsave("patchwork-example.png")

#handsome tables


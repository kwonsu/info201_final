#SuJin : Gender vs characteristics

library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)

# Circular one
GenderCharacteristic <- function(dataset, char) {
  my.data <- group_by(dataset, SEX,ALIGN) %>%
    summarize(count=n())
  
  my.data <- my.data[!(is.na(my.data$SEX) | my.data$SEX=="" | my.data$ALIGN==""), ]
  
  
  total <- group_by(my.data, SEX) %>%
    summarize(sum = sum(count)) 
  colnames(total) <- c("Sex","total")
  
  
  b.data <- filter(my.data, ALIGN =="Bad Characters") %>%
    select(SEX,count) 
  colnames(b.data) <- c("Sex","bad")
  
  g.data <- filter(my.data, ALIGN == "Good Characters") %>%
    select(SEX,count)
  colnames(g.data) <- c("Sex","good")
  
  n.data <- filter(my.data, ALIGN == "Neutral Characters") %>%
    select(SEX,count)
  colnames(n.data) <- c("Sex","neutral")
  
  table <- left_join(b.data,g.data, by= "Sex") %>% 
    left_join(n.data, by="Sex") %>%
    left_join(total, by="Sex")
  
  pcnt <- data.frame(c("Agenda","Female","Male"),
                     round(table$bad/table$total *100, digit=0), 
                     round(table$good/table$total *100, digit=0),
                     round(table$neutral/table$total *100, digit=0))
  colnames(pcnt) <- c("Gender","Bad","Good","Neutral")
  
  circular <- ggplot(pcnt, aes(x = Gender, y = eval(parse(text = char)) ,fill = Gender)) + 
    geom_bar(width = 0.85, stat="identity") +    
    
    # To use a polar plot and not a basic b arplot
    coord_polar(theta = "y") +    
    
    #Remove useless labels of axis
    xlab("") + ylab("") +
    
    #Increase ylim to avoid having a complete circle
    ylim(c(0,75)) + 
    
    #Add group labels close to the bars :
    geom_text(data = pcnt, hjust = 1, size = 3, aes(x = Gender, y = 0, label = Gender)) +
    
    #Remove useless legend, y axis ticks and y axis text
    theme(legend.position = "none" , axis.text.y = element_blank() , axis.ticks = element_blank()) +
    
    ggtitle(paste("Proportion of each gender for ",as.character(char), "Characteristic"))
  
  return(circular)
}

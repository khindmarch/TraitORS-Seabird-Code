PCA_traits <- read.csv("PCA_traits.csv")

library(PCAmixdata)
library(dplyr)

#To show scientific name
rownames(PCA_traits) <- PCA_traits$ScientificName_accepted

#Combine Datasets
combined <- PCA_traits %>% 
  select(Maximum.body.size, Body.size, Distribution, Depth.range, 
         Feeding.mode, Trophic.position, Life.span, Sociability, Diel.activity.pattern)

#Get rid of n/a entries
combined <- combined %>% drop_na()

#drop blanks
> categorical2 <- categorical %>% filter(!if_any(everything(), ~ . == ""))
> combined2 <- combined %>% filter(!if_any(everything(), ~ . == ""))

#
continuous <- combined2 %>% select(Maximum.body.size)
categorical <- combined2 %>% select(Body.size, Distribution, Depth.range, Trophic.position, Life.span, Sociability, Diel.activity.pattern)

#Check number of rows
nrow(continuous) == nrow(categorical)

#confirm data in categorical and continuous datasets
str(continuous)
str(categorical)

# make sure columns are correct
continuous <- continuous %>% mutate(across(everything(), as.numeric))
categorical <- categorical %>% mutate(across(everything(), as.factor))

#count rows
print(nrow(continuous))
print(nrow(categorical))

# Run the mixed PCA
traits_PCA <- PCAmix(X.quanti=continuous, X.quali=categorical, rename.level=TRUE, graph=T)

# To obtain the variance of the principal components:
traits.pcamix$eig
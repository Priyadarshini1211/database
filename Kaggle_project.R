setwd("C:/Users/Lenovo/Documents/Kaggle")
getwd()

titanic.train <- read.csv(file = "train.csv", stringsAsFactors = FALSE,header = TRUE)

titanic.test <- read.csv(file = "test.csv", stringsAsFactors = FALSE,header = TRUE)

tail(titanic.train)
tail(titanic.test)

median(titanic.train$Age)

median(titanic.train$Age,na.rm=TRUE)

median(titanic.test$Age,na.rm=TRUE)

#Creating a column for train test
titanic.train$IsTrainSet <- TRUE
  titanic.test$IsTrainSet <- FALSE
  
tail(titanic.train$IsTrainSet)
  
ncol(titanic.train)
ncol(titanic.test)
  
names(titanic.train)
names(titanic.test)

titanic.test$Survived <- NA

titanic.full <- rbind(titanic.train,titanic.test)

tail(titanic.full)

table(titanic.full$IsTrainSet)

table(titanic.full$Embarked)

titanic.full[titanic.full$Embarked == '',"Embarked"] <- 'S'
             
table(titanic.full$Embarked)

table(is.na(titanic.full$Age))


# Replacing the missing value with global median
titanic.full[is.na(titanic.full$Age),"Age"] <- 28

table(is.na(titanic.full$Age))

table(is.na(titanic.full$Fare))

fare.median <- median(titanic.full$Fare,na.rm = TRUE)

titanic.full[is.na(titanic.full$Fare),"Fare"] <- fare.median


str(titanic.full)
# categorical casting
table(titanic.full$Survived)

titanic.full$Pclass <- as.factor(titanic.full$Pclass)
titanic.full$Sex <- as.factor(titanic.full$Sex)
titanic.full$Embarked <- as.factor(titanic.full$Embarked)

str(titanic.full)

#Split the data into training and test

titanic.train<- titanic.full[titanic.full$IsTrainSet == TRUE,]
tail(titanic.train)

titanic.test<- titanic.full[titanic.full$IsTrainSet == FALSE,]
tail(titanic.test)


titanic.train$Survived <- as.factor(titanic.train$Survived)
str(titanic.train)

survived.equation <- "Survived~Pclass+Sex+Age+SibSp+Parch+Fare+Embarked"
survived.formula <- as.formula(survived.equation)

install.packages("randomForest")
randomForest(Survived~.survived.formula)
library(randomForest)

titanic.model<- randomForest(formula = survived.formula,data = titanic.train,ntree= 500,mtry = 3,nodesize = 0.01*nrow(titanic.test))

features.equation <- "Pclass+Sex+Age+SibSp+Parch+Fare+Embarked"

Survived <- predict(titanic.model, newdata= titanic.test)

Survived

PassengerId <- titanic.test$PassengerId
output.df <- as.data.frame(PassengerId)


output.df$Survived <- Survived
tail(output.df)


write.csv(output.df,file = "Kaggle_submission.csv")

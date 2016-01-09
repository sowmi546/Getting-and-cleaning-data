install.packages("dplyr")
install.packages("data.table")
install.packages("reshape")
library(dplyr)
library(reshape)
library(data.table)
getwd()

#reading the feature names and the activities from the downloaded zip file

namesOfFeatures<-read.table("features.txt")
namesOfActivities<- read.table("activity_labels.txt", header=FALSE)
#colnames(namesOfFeatures)
#colnames(namesOfActivities)


#reading the training data
subjectTrainData<- read.table("train/subject_train.txt", header=FALSE)
featuresTrainData<-read.table("train/X_train.txt", header=FALSE)
activityTrainData<-read.table("train/Y_train.txt", header=FALSE)

#reading the test data

subjectTestData<- read.table("test/subject_test.txt", header=FALSE)
featuresTestData<-read.table("test/X_test.txt", header=FALSE)
activityTestData<-read.table("test/Y_test.txt", header=FALSE)

#merging training data and test data

subjectFinal<- rbind(subjectTrainData,subjectTestData)
featuresFinal<-rbind(featuresTrainData,featuresTestData)
activityFinal<-rbind(activityTrainData,activityTestData)

colnames(subjectFinal)<- "Subject"
colnames(activityFinal)<- "Activity"
colnames(featuresFinal)<-t(namesOfFeatures[2])

finalDataSet<- cbind(featuresFinal,activityFinal,subjectFinal)







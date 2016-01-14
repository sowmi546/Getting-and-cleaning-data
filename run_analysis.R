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

#part2
reqCols <- grep(".*Mean.*|.*Std.*", names(finalDataSet), ignore.case=TRUE)
finalCols<-c(reqCols,562,563)
dim(finalDataSet)


finalCols

modifiedData<-finalDataSet[,finalCols]
dim(modifiedData)


#part3
colnames(modifiedData)
class(modifiedData$Activity)

modifiedData$Activity <- as.character((modifiedData$Activity))
#replacing the values with those from the names of activites
namesOfActivities
for(i in 1:6)
{
  modifiedData$Activity[modifiedData$Activity==i]<-as.character(namesOfActivities[i,2])

}

#factoring the activity variable
modifiedData$Activity <- as.factor(modifiedData$Activity)


#giving descriptive variable names
names(modifiedData)

#modifying variable names so that they are more descriptive

names(modifiedData)<-gsub("Acc","Accelerometer",names(modifiedData))
names(modifiedData) <- gsub("Gyro","Gyroscope",names(modifiedData))
names(modifiedData)<- gsub("Mag","Magnitude",names(modifiedData))
names(modifiedData) <- gsub("^t","Time",names(modifiedData))
names(modifiedData) <- gsub("^f","Frequency",names(modifiedData))
names(modifiedData)<-gsub("-freq()", "Frequency", names(modifiedData), ignore.case = TRUE)
names(modifiedData)<-gsub("tBody", "TimeBody", names(modifiedData))
names(modifiedData)<-gsub("-mean()", "Mean", names(modifiedData), ignore.case = TRUE)
names(modifiedData)<-gsub("-std()", "StandardDeviation", names(modifiedData), ignore.case = TRUE)


#part5

modifiedData$Subject <- as.factor(modifiedData$Subject)
modifiedData<- data.table(modifiedData)

modifiedData2 <- aggregate(.~Subject+Activity,modifiedData,mean)
modifiedData2 <-modifiedData[order(modifiedData$Subject,modifiedData$Activity),]
write.table(modifiedData2,file="FinalData.txt",row.names=FALSE)
#checking the content of the newly generated file

a<-read.table("FinalData.txt")
head(a) #displays the data with modified col names and activity values


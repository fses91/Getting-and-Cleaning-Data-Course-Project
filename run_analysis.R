setwd("UCI\ HAR\ Dataset/")

# Read data
testSet <- read.table("test/X_test.txt")
testLabels <- read.table("test/y_test.txt")
testSubjects <- read.table("test/subject_test.txt")

trainingSet <- read.table("train/X_train.txt")
trainingLabels <- read.table("train/y_train.txt")
trainingSubjects <- read.table("train/subject_train.txt")

features <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt")

# Merge data
testData <- cbind(testSubjects, testSet)
testData <- cbind(testLabels, testData)

trainingData <- cbind(trainingSubjects, trainingSet)
trainingData <- cbind(trainingLabels, trainingData)

mergedData <- rbind(trainingData, testData)

# Set feature names names
colnames(mergedData)[1:2] <- c("activity", "subject")
colnames(mergedData)[3:563] <- as.character(features$V2)

# Choose columns we need
neededColumns <- mergedData[,grep("[Mm]ean|[Ss]td", colnames(mergedData)[3:563])]

# Set readable names
colnames(neededColumns) <- gsub("-[Mm]ean", "Mean", colnames(neededColumns))
colnames(neededColumns) <- gsub("-[Ss]td", "Std", colnames(neededColumns))
colnames(neededColumns) <- gsub("[()-]", "", colnames(neededColumns))

neededColumns <- group_by(neededColumns, activity, subject)
activitySubjectMeans <- aggregate(. ~ activity + subject, neededColumns, mean)

indexCounter <- 1

for (activity in activitySubjectMeans$activity) {
        activityLabel <- as.character(activityLabels[activityLabels$V1 == activity,]$V2)
        activitySubjectMeans$activity[indexCounter] <- activityLabel
        indexCounter = indexCounter + 1
}

write.table(activitySubjectMeans, "tidy.txt")
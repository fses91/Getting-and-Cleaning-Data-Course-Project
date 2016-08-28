# Read data
testSet <- read.table("test/X_test.txt")
testLabels <- read.table("test/y_test.txt")
testSubjects <- read.table("test/subject_test.txt")

trainingSet <- read.table("train/X_train.txt")
trainingLabels <- read.table("train/y_train.txt")
trainingSubjects <- read.table("train/subject_train.txt")

# Merge data
testData <- cbind(testSubjects, testSet)
testData <- cbind(testLabels, testData)

trainingData <- cbind(trainingSubjects, trainingSet)
trainingData <- cbind(trainingLabels, trainingData)

mergedData <- rbind(trainingData, testData)





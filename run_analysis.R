addNames <- function(DF) {
    features <- read.table("UCI HAR Dataset/features.txt", sep=" ", stringsAsFactors = FALSE)
    tests <- list(
        c("^t", "time"),
        c("^f", "frequency"),
        c("[-(),]", "_"),
        c("__+", "_"),
        c("_$", "")
    )
    
    clean_features <- Reduce(function(features, test) {
        gsub(test[1], test[2], features)
    }, tests, init = features[, 2])
    
    names(DF) <- clean_features
    
    DF
}

addActivities <- function(DF, file) {
    activity <- read.table(file, col.names = c('activity_id'))

    cbind(activity, DF)
}

addSubjects <- function(DF, file) {
    subject <- read.table(file, col.names = c('subject_id'))
    
    cbind(subject, DF)
}

addActivitiesLabel <- function(DF) {
    activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", sep = " ", stringsAsFactors = TRUE, col.names = c('activity_id', 'activity_labels'))
    
    merge(DF, activity_labels, by = "activity_id")
}

run_analysis <- function() {
    
    train <- read.table("UCI HAR Dataset/train/X_train.txt")
    train <- addNames(train)
    train <- addActivities(train, "UCI HAR Dataset/train/y_train.txt")
    train <- addSubjects(train, "UCI HAR Dataset/train/subject_train.txt")
    train <- cbind(list(trainOrTest = rep("train", nrow(train))), train)

    test <- read.table("UCI HAR Dataset/test/X_test.txt")
    test <- addNames(test)
    test <- addActivities(test, "UCI HAR Dataset/test/y_test.txt")
    test <- addSubjects(test, "UCI HAR Dataset/test/subject_test.txt")
    test <- cbind(list(trainOrTest = rep("test", nrow(test))), test)

    binded <- rbind(train, test)
    
    merged <- addActivitiesLabel(binded)

    cbind(list(trainOrTest = merged$trainOrTest, subject_id = merged$subject_id, activity=merged$activity_labels), merged[, grep("mean", names(merged))], merged[, grep("std", names(merged))])
}

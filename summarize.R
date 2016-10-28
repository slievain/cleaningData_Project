library(reshape2)

summariseTidyData <- function(DF) {
    tidyDataMelt <- melt(DF, id = c("trainOrTest", "subject_id", "activity"), measure.vars = c(grep("mean", names(DF)), grep("std", names(DF))))
    summary <- dcast(tidyDataMelt, trainOrTest + subject_id + activity ~ variable, mean)
    
    write.table(summary, "summary.txt", row.name = FALSE)
    
    summary
}
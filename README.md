## Study Design

### Clarification
Since the instructions say to assume that the Samsung data is in the working directory, I decided to work on the basis that the zip file was already downloaded and unzipped keeping the folder structure.

### Running the script
Run the following code in R Console:
> source("run_analysis.R")
> tidyData <- run_analysis()

Data can be saved as a CSV file for future analysis:
> write.csv(tidyData, "tidyData.csv", row.names = FALSE)


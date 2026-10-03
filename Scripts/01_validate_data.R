dat <- read.csv("data/dar_naturalized_data_70.csv", check.names=FALSE)
dir.create("outputs", showWarnings=FALSE)
PAIRS <- list(
  "Prompting density"=c("Pre_Density","Post_Density"),
  "Mean prompt length"=c("Pre_Length","Post_Length"),
  "AI-suggestion rejection rate"=c("Pre_Rejection","Post_Rejection"),
  "Stance marking"=c("Pre_Stance","Post_Stance"),
  "Lexical agency"=c("Pre_Lexical","Post_Lexical"),
  "Voice consistency"=c("Pre_Consistency","Post_Consistency"),
  "Critical dialogue"=c("Pre_Critical","Post_Critical")
)

expected <- c("Participant", unlist(PAIRS))
cat("Rows:",nrow(dat),"\nDuplicate IDs:",sum(duplicated(dat$Participant)),"\n")
cat("Missing expected columns:",paste(setdiff(expected,names(dat)),collapse=", "), "\n")
print(colSums(is.na(dat)))
stopifnot(nrow(dat)==70, all(expected %in% names(dat)), !anyDuplicated(dat$Participant))
cat("Validation passed.\n")

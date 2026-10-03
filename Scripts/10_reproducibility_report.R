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

lines<-c("# DAR analysis run report (R)","",paste("- Run date:",Sys.Date()),
 paste("- R version:",R.version.string),"- Input: `data/dar_naturalized_data_70.csv`",
 paste("- Rows:",nrow(dat)),paste("- Columns:",ncol(dat)),
 paste("- Duplicate participant IDs:",sum(duplicated(dat$Participant))),
 paste("- Missing cells:",sum(is.na(dat))),"",
 "## Interpretation notes",
 "- A one-group pre/post design does not by itself establish causality.",
 "- Scores are operational indicators, not direct proof of epistemic agency.",
 "- Confirm consent, ethics, privacy, and data provenance before public release.")
writeLines(lines,"outputs/reproducibility_report_R.md"); cat("Report written.\n")

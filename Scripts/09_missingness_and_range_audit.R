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

num<-dat[vapply(dat,is.numeric,logical(1))]
audit<-data.frame(Variable=names(num),Missing_n=sapply(num,function(x)sum(is.na(x))),
 Missing_pct=sapply(num,function(x)mean(is.na(x))*100),Minimum=sapply(num,function(x)min(x,na.rm=TRUE)),
 Maximum=sapply(num,function(x)max(x,na.rm=TRUE)),Mean=sapply(num,function(x)mean(x,na.rm=TRUE)),
 SD=sapply(num,function(x)sd(x,na.rm=TRUE)))
write.csv(audit,"outputs/range_missingness_audit_R.csv",row.names=FALSE); print(audit,digits=3)

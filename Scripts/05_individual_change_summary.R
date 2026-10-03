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

out <- do.call(rbind,lapply(names(PAIRS),function(nm){
 d<-dat[[PAIRS[[nm]][2]]]-dat[[PAIRS[[nm]][1]]]
 data.frame(Measure=nm,N=sum(!is.na(d)),Increased=sum(d>0,na.rm=TRUE),Decreased=sum(d<0,na.rm=TRUE),
 Ties=sum(d==0,na.rm=TRUE),Mean_Change=mean(d,na.rm=TRUE),Median_Change=median(d,na.rm=TRUE))
}))
write.csv(out,"outputs/individual_change_summary_R.csv",row.names=FALSE); print(out)

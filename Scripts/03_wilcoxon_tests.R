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
 a<-dat[[PAIRS[[nm]][1]]]; b<-dat[[PAIRS[[nm]][2]]]; keep<-complete.cases(a,b); delta<-b[keep]-a[keep]
 wt<-wilcox.test(b[keep],a[keep],paired=TRUE,exact=FALSE,correct=FALSE)
 data.frame(Measure=nm,N_pairs=sum(keep),W=unname(wt$statistic),p_value=wt$p.value,
 Increased=sum(delta>0),Decreased=sum(delta<0),Ties=sum(delta==0))
}))
write.csv(out,"outputs/wilcoxon_tests_R.csv",row.names=FALSE); print(out,digits=5)

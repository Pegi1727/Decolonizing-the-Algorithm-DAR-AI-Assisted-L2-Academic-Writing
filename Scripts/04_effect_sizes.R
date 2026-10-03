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
 a<-dat[[PAIRS[[nm]][1]]]; b<-dat[[PAIRS[[nm]][2]]]; keep<-complete.cases(a,b)
 wt<-wilcox.test(b[keep],a[keep],paired=TRUE,exact=FALSE,correct=FALSE)
 z<-qnorm(wt$p.value/2,lower.tail=FALSE)
 data.frame(Measure=nm,N_pairs=sum(keep),Z_abs_approx=z,r_Z_over_sqrt_N=z/sqrt(sum(keep)),p_value=wt$p.value)
}))
write.csv(out,"outputs/effect_sizes_R.csv",row.names=FALSE); print(out,digits=4)
cat("Z is approximated from the p-value; results may differ from software-reported Z.\n")

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

changes <- as.data.frame(lapply(PAIRS,function(p) dat[[p[2]]]-dat[[p[1]]]))
names(changes)<-paste0(gsub(" ","_",names(PAIRS)),"_change")
corr<-cor(changes,method="spearman",use="pairwise.complete.obs")
write.csv(corr,"outputs/change_score_spearman_correlations_R.csv"); print(round(corr,3))
cat("Exploratory associations do not establish causality.\n")

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

library(ggplot2); library(tidyr)
dir.create("figures",showWarnings=FALSE)
long<-do.call(rbind,lapply(names(PAIRS),function(nm)data.frame(Participant=dat$Participant,Measure=nm,
 Pre=dat[[PAIRS[[nm]][1]]],Post=dat[[PAIRS[[nm]][2]]])))
long<-pivot_longer(long,c("Pre","Post"),names_to="Time",values_to="Value")
p<-ggplot(long,aes(Time,Value,group=Participant))+geom_line(alpha=.25)+geom_point(alpha=.4,size=1)+
 facet_wrap(~Measure,scales="free_y")+labs(title="Participant-level pre/post changes",x=NULL,y="Observed value")+theme_minimal()
ggsave("figures/figure_paired_changes_R.png",p,width=10,height=9,dpi=300)
ggsave("figures/figure_paired_changes_R.pdf",p,width=10,height=9)

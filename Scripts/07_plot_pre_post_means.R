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

library(ggplot2)
dir.create("figures",showWarnings=FALSE)
long<-do.call(rbind,lapply(names(PAIRS),function(nm)data.frame(
 Measure=nm,Time=c("Pre-test","Post-test"),Value=c(dat[[PAIRS[[nm]][1]]],dat[[PAIRS[[nm]][2]]))))
sumdat<-aggregate(Value~Measure+Time,long,function(x)c(mean=mean(x,na.rm=TRUE),sd=sd(x,na.rm=TRUE)))
sumdat<-data.frame(Measure=sumdat$Measure,Time=sumdat$Time,Mean=sumdat$Value[,"mean"],SD=sumdat$Value[,"sd"])
p<-ggplot(sumdat,aes(Measure,Mean,fill=Time))+geom_col(position=position_dodge(.8))+
 geom_errorbar(aes(ymin=Mean-SD,ymax=Mean+SD),position=position_dodge(.8),width=.2)+
 labs(title="DAR pre/post descriptive results",x=NULL,y="Mean (error bars = SD)")+
 theme_minimal()+theme(axis.text.x=element_text(angle=30,hjust=1))
ggsave("figures/figure_pre_post_means_R.png",p,width=11,height=6,dpi=300)
ggsave("figures/figure_pre_post_means_R.pdf",p,width=11,height=6)

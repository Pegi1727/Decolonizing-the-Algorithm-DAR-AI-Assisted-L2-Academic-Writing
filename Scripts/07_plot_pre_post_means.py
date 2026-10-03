from pathlib import Path
import pandas as pd
DATA = Path("data/dar_naturalized_data_70.csv")
OUT = Path("outputs"); OUT.mkdir(exist_ok=True)
PAIRS = {'Prompting density': ('Pre_Density', 'Post_Density'), 'Mean prompt length': ('Pre_Length', 'Post_Length'), 'AI-suggestion rejection rate': ('Pre_Rejection', 'Post_Rejection'), 'Stance marking': ('Pre_Stance', 'Post_Stance'), 'Lexical agency': ('Pre_Lexical', 'Post_Lexical'), 'Voice consistency': ('Pre_Consistency', 'Post_Consistency'), 'Critical dialogue': ('Pre_Critical', 'Post_Critical')}
df = pd.read_csv(DATA)

import matplotlib.pyplot as plt
import numpy as np
FIG=Path("figures"); FIG.mkdir(exist_ok=True)
labels=list(PAIRS); pre=[df[a].mean() for a,b in PAIRS.values()]
post=[df[b].mean() for a,b in PAIRS.values()]
presd=[df[a].std() for a,b in PAIRS.values()]; postsd=[df[b].std() for a,b in PAIRS.values()]
x=np.arange(len(labels)); w=.36
fig,ax=plt.subplots(figsize=(11,6))
ax.bar(x-w/2,pre,w,yerr=presd,capsize=3,label="Pre-test")
ax.bar(x+w/2,post,w,yerr=postsd,capsize=3,label="Post-test")
ax.set_xticks(x); ax.set_xticklabels(labels,rotation=30,ha="right")
ax.set_ylabel("Mean (error bars = SD)"); ax.set_title("DAR pre/post descriptive results")
ax.legend(); fig.tight_layout()
fig.savefig(FIG/"figure_pre_post_means.png",dpi=300); fig.savefig(FIG/"figure_pre_post_means.pdf")
plt.close(fig); print("Saved mean plots.")

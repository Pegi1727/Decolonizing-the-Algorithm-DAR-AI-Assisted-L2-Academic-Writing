from pathlib import Path
import pandas as pd
DATA = Path("data/dar_naturalized_data_70.csv")
OUT = Path("outputs"); OUT.mkdir(exist_ok=True)
PAIRS = {'Prompting density': ('Pre_Density', 'Post_Density'), 'Mean prompt length': ('Pre_Length', 'Post_Length'), 'AI-suggestion rejection rate': ('Pre_Rejection', 'Post_Rejection'), 'Stance marking': ('Pre_Stance', 'Post_Stance'), 'Lexical agency': ('Pre_Lexical', 'Post_Lexical'), 'Voice consistency': ('Pre_Consistency', 'Post_Consistency'), 'Critical dialogue': ('Pre_Critical', 'Post_Critical')}
df = pd.read_csv(DATA)

import matplotlib.pyplot as plt
FIG=Path("figures"); FIG.mkdir(exist_ok=True)
fig,axes=plt.subplots(4,2,figsize=(10,13)); axes=axes.flatten()
for ax,(name,(pre,post)) in zip(axes,PAIRS.items()):
    d=df[[pre,post]].dropna()
    for _,row in d.iterrows(): ax.plot([0,1],[row[pre],row[post]],alpha=.25,lw=.7)
    ax.set_xticks([0,1]); ax.set_xticklabels(["Pre","Post"]); ax.set_title(name); ax.set_ylabel("Observed value")
axes[-1].axis("off"); fig.tight_layout()
fig.savefig(FIG/"figure_paired_changes.png",dpi=300); fig.savefig(FIG/"figure_paired_changes.pdf")
plt.close(fig); print("Saved paired-change plots.")

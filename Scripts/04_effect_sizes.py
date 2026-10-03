from pathlib import Path
import pandas as pd
DATA = Path("data/dar_naturalized_data_70.csv")
OUT = Path("outputs"); OUT.mkdir(exist_ok=True)
PAIRS = {'Prompting density': ('Pre_Density', 'Post_Density'), 'Mean prompt length': ('Pre_Length', 'Post_Length'), 'AI-suggestion rejection rate': ('Pre_Rejection', 'Post_Rejection'), 'Stance marking': ('Pre_Stance', 'Post_Stance'), 'Lexical agency': ('Pre_Lexical', 'Post_Lexical'), 'Voice consistency': ('Pre_Consistency', 'Post_Consistency'), 'Critical dialogue': ('Pre_Critical', 'Post_Critical')}
df = pd.read_csv(DATA)

from scipy.stats import wilcoxon
import numpy as np
rows=[]
for name,(pre,post) in PAIRS.items():
    d=df[[pre,post]].dropna(); t=wilcoxon(d[post],d[pre],method="approx")
    z=abs(float(t.zstatistic)); rows.append({"Measure":name,"N_total_pairs":len(d),
    "Z_abs_approx":z,"r_Z_over_sqrt_N":z/np.sqrt(len(d)),"p_value":float(t.pvalue)})
out=pd.DataFrame(rows); out.to_csv(OUT/"effect_sizes.csv",index=False)
print(out.round(4).to_string(index=False))
print("Convention: r=|Z|/sqrt(N_total_pairs); state this convention in reporting.")

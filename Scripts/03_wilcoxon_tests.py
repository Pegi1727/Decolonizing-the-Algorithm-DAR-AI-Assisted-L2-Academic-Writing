from pathlib import Path
import pandas as pd
DATA = Path("data/dar_naturalized_data_70.csv")
OUT = Path("outputs"); OUT.mkdir(exist_ok=True)
PAIRS = {'Prompting density': ('Pre_Density', 'Post_Density'), 'Mean prompt length': ('Pre_Length', 'Post_Length'), 'AI-suggestion rejection rate': ('Pre_Rejection', 'Post_Rejection'), 'Stance marking': ('Pre_Stance', 'Post_Stance'), 'Lexical agency': ('Pre_Lexical', 'Post_Lexical'), 'Voice consistency': ('Pre_Consistency', 'Post_Consistency'), 'Critical dialogue': ('Pre_Critical', 'Post_Critical')}
df = pd.read_csv(DATA)

from scipy.stats import wilcoxon
rows=[]
for name,(pre,post) in PAIRS.items():
    d=df[[pre,post]].dropna(); delta=d[post]-d[pre]
    t=wilcoxon(d[post],d[pre],alternative="two-sided",method="approx")
    rows.append({"Measure":name,"N_pairs":len(d),"W":float(t.statistic),
    "Z_abs_approx":abs(float(t.zstatistic)),"p_value":float(t.pvalue),
    "Increased":int((delta>0).sum()),"Decreased":int((delta<0).sum()),"Ties":int((delta==0).sum())})
out=pd.DataFrame(rows); out.to_csv(OUT/"wilcoxon_tests.csv",index=False)
print(out.to_string(index=False)); print("Report very small p-values as p < .001, not p = .000.")

from pathlib import Path
import pandas as pd
DATA = Path("data/dar_naturalized_data_70.csv")
OUT = Path("outputs"); OUT.mkdir(exist_ok=True)
PAIRS = {'Prompting density': ('Pre_Density', 'Post_Density'), 'Mean prompt length': ('Pre_Length', 'Post_Length'), 'AI-suggestion rejection rate': ('Pre_Rejection', 'Post_Rejection'), 'Stance marking': ('Pre_Stance', 'Post_Stance'), 'Lexical agency': ('Pre_Lexical', 'Post_Lexical'), 'Voice consistency': ('Pre_Consistency', 'Post_Consistency'), 'Critical dialogue': ('Pre_Critical', 'Post_Critical')}
df = pd.read_csv(DATA)

rows=[]
for name,(pre,post) in PAIRS.items():
    delta=df[post]-df[pre]
    rows.append({"Measure":name,"N":delta.count(),"Increased":int((delta>0).sum()),
    "Decreased":int((delta<0).sum()),"Ties":int((delta==0).sum()),
    "Mean_Change":delta.mean(),"Median_Change":delta.median()})
out=pd.DataFrame(rows); out.to_csv(OUT/"individual_change_summary.csv",index=False)
print(out.to_string(index=False))

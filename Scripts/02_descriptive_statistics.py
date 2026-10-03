from pathlib import Path
import pandas as pd
DATA = Path("data/dar_naturalized_data_70.csv")
OUT = Path("outputs"); OUT.mkdir(exist_ok=True)
PAIRS = {'Prompting density': ('Pre_Density', 'Post_Density'), 'Mean prompt length': ('Pre_Length', 'Post_Length'), 'AI-suggestion rejection rate': ('Pre_Rejection', 'Post_Rejection'), 'Stance marking': ('Pre_Stance', 'Post_Stance'), 'Lexical agency': ('Pre_Lexical', 'Post_Lexical'), 'Voice consistency': ('Pre_Consistency', 'Post_Consistency'), 'Critical dialogue': ('Pre_Critical', 'Post_Critical')}
df = pd.read_csv(DATA)

rows=[]
for name,(pre,post) in PAIRS.items():
    rows.append({"Measure":name,"Pre_N":df[pre].count(),"Pre_Mean":df[pre].mean(),
    "Pre_SD":df[pre].std(),"Pre_Median":df[pre].median(),"Post_N":df[post].count(),
    "Post_Mean":df[post].mean(),"Post_SD":df[post].std(),"Post_Median":df[post].median(),
    "Mean_Change":(df[post]-df[pre]).mean()})
out=pd.DataFrame(rows); out.to_csv(OUT/"descriptive_statistics.csv",index=False)
print(out.round(3).to_string(index=False))

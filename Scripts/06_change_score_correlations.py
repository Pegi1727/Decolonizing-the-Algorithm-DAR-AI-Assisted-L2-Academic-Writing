from pathlib import Path
import pandas as pd
DATA = Path("data/dar_naturalized_data_70.csv")
OUT = Path("outputs"); OUT.mkdir(exist_ok=True)
PAIRS = {'Prompting density': ('Pre_Density', 'Post_Density'), 'Mean prompt length': ('Pre_Length', 'Post_Length'), 'AI-suggestion rejection rate': ('Pre_Rejection', 'Post_Rejection'), 'Stance marking': ('Pre_Stance', 'Post_Stance'), 'Lexical agency': ('Pre_Lexical', 'Post_Lexical'), 'Voice consistency': ('Pre_Consistency', 'Post_Consistency'), 'Critical dialogue': ('Pre_Critical', 'Post_Critical')}
df = pd.read_csv(DATA)

changes=pd.DataFrame({name.replace(" ","_")+"_change":df[post]-df[pre]
    for name,(pre,post) in PAIRS.items()})
corr=changes.corr(method="spearman"); corr.to_csv(OUT/"change_score_spearman_correlations.csv")
print(corr.round(3).to_string())
print("Exploratory correlations do not establish causality.")

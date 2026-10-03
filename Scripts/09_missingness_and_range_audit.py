from pathlib import Path
import pandas as pd
DATA = Path("data/dar_naturalized_data_70.csv")
OUT = Path("outputs"); OUT.mkdir(exist_ok=True)
PAIRS = {'Prompting density': ('Pre_Density', 'Post_Density'), 'Mean prompt length': ('Pre_Length', 'Post_Length'), 'AI-suggestion rejection rate': ('Pre_Rejection', 'Post_Rejection'), 'Stance marking': ('Pre_Stance', 'Post_Stance'), 'Lexical agency': ('Pre_Lexical', 'Post_Lexical'), 'Voice consistency': ('Pre_Consistency', 'Post_Consistency'), 'Critical dialogue': ('Pre_Critical', 'Post_Critical')}
df = pd.read_csv(DATA)

num=df.select_dtypes(include="number")
audit=pd.DataFrame({"missing_n":num.isna().sum(),"missing_pct":100*num.isna().mean(),
"minimum":num.min(),"maximum":num.max(),"mean":num.mean(),"sd":num.std()})
audit.to_csv(OUT/"range_missingness_audit.csv")
print(audit.round(3).to_string())
print("This audit flags values for human review; it does not decide validity.")

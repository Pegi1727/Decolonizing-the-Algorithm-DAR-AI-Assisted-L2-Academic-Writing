from pathlib import Path
import pandas as pd
DATA = Path("data/dar_naturalized_data_70.csv")
OUT = Path("outputs"); OUT.mkdir(exist_ok=True)
PAIRS = {'Prompting density': ('Pre_Density', 'Post_Density'), 'Mean prompt length': ('Pre_Length', 'Post_Length'), 'AI-suggestion rejection rate': ('Pre_Rejection', 'Post_Rejection'), 'Stance marking': ('Pre_Stance', 'Post_Stance'), 'Lexical agency': ('Pre_Lexical', 'Post_Lexical'), 'Voice consistency': ('Pre_Consistency', 'Post_Consistency'), 'Critical dialogue': ('Pre_Critical', 'Post_Critical')}
df = pd.read_csv(DATA)

expected = ["Participant"] + [c for pair in PAIRS.values() for c in pair]
print("N rows:", len(df))
print("Missing expected columns:", sorted(set(expected)-set(df.columns)))
print("Duplicate IDs:", int(df["Participant"].duplicated().sum()))
print("Missing values by column:\n", df.isna().sum().to_string())
if len(df) != 70 or df["Participant"].duplicated().any() or set(expected)-set(df.columns):
    raise ValueError("Dataset validation failed; inspect messages above.")
print("Validation passed.")

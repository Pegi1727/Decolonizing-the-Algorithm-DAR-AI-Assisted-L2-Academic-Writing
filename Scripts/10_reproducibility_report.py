from pathlib import Path
import pandas as pd
DATA = Path("data/dar_naturalized_data_70.csv")
OUT = Path("outputs"); OUT.mkdir(exist_ok=True)
PAIRS = {'Prompting density': ('Pre_Density', 'Post_Density'), 'Mean prompt length': ('Pre_Length', 'Post_Length'), 'AI-suggestion rejection rate': ('Pre_Rejection', 'Post_Rejection'), 'Stance marking': ('Pre_Stance', 'Post_Stance'), 'Lexical agency': ('Pre_Lexical', 'Post_Lexical'), 'Voice consistency': ('Pre_Consistency', 'Post_Consistency'), 'Critical dialogue': ('Pre_Critical', 'Post_Critical')}
df = pd.read_csv(DATA)

import sys, scipy, matplotlib
from datetime import date
report=f"""# DAR analysis run report

- Run date: {date.today().isoformat()}
- Python: {sys.version.split()[0]}
- pandas: {pd.__version__}
- SciPy: {scipy.__version__}
- Matplotlib: {matplotlib.__version__}
- Input: `{DATA.as_posix()}`
- Rows: {len(df)}
- Columns: {len(df.columns)}
- Duplicate participant IDs: {int(df["Participant"].duplicated().sum())}
- Missing cells: {int(df.isna().sum().sum())}

## Interpretation notes
- A one-group pre/post design does not by itself establish causality.
- Scores and interactional measures are operational indicators, not direct proof of epistemic agency.
- Confirm consent, ethics, privacy, and data-provenance requirements before public release.
"""
(OUT/"reproducibility_report.md").write_text(report,encoding="utf-8")
print("Wrote reproducibility report.")

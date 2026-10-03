# DAR Jupyter Notebooks

Ten Jupyter notebooks for reproducible analysis of the DAR pre–post study.

## Required input
Place `dar_naturalized_data_70.csv` at `data/dar_naturalized_data_70.csv` relative to the repository root.

## Install dependencies
```bash
python -m pip install pandas scipy matplotlib jupyter
```

Run Jupyter from the repository root so the relative data paths resolve:
```bash
jupyter notebook
```

## Notebook index
1. Validate dataset
2. Descriptive statistics
3. Paired Wilcoxon tests
4. Effect sizes
5. Individual change summary
6. Exploratory correlations among change scores
7. Pre/post mean plot
8. Participant-level paired plots
9. Missingness and range audit
10. Reproducibility report

## Important notes
- Effect-size convention: `r = |Z| / sqrt(N_total_pairs)`; state this explicitly.
- Correlations are exploratory. A one-group pre–post design does not establish causality.
- The scores are operational indicators, not direct proof of epistemic agency.
- Confirm consent, ethics approval, privacy requirements, and data provenance before releasing participant-level data publicly.

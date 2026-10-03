# DAR Analysis Logs

This directory is reserved for execution logs generated when the DAR analysis scripts or automated workflows run.

## Contents
- `run_log_template.csv`: blank template for recording a local analysis run.
- `analysis_log_template.txt`: text template for recording environment, commands, and outcomes.
- `*.log`: generated console output from scripts or CI workflows.

## Important
The templates in this folder are blank examples, not evidence that an analysis has been run. Add logs only after executing the relevant scripts. Logs can contain local paths or environment details; review them before publishing.

## Suggested local usage
From the repository root, run a script and capture its output:

```bash
mkdir -p logs
python scripts/python/01_validate_data.py 2>&1 | tee logs/python_validation.log
```

For R:

```bash
Rscript scripts/R/01_validate_data.R 2>&1 | tee logs/r_validation.log
```

Adjust script paths if your repository uses a different folder structure.

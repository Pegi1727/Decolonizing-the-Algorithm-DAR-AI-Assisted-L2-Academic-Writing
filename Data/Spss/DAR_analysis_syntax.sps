* DAR study: reproducible SPSS syntax.
* Run from the repository root; update the path if needed.
GET DATA
  /TYPE=TXT
  /FILE='data/raw/dar_naturalized_data_70.csv'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /VARIABLES=
  Participant A40
  Pre_Density F12.4
  Post_Density F12.4
  Pre_Length F12.4
  Post_Length F12.4
  Pre_Rejection F12.4
  Post_Rejection F12.4
  Pre_Stance F12.4
  Post_Stance F12.4
  Pre_Lexical F12.4
  Post_Lexical F12.4
  Pre_Consistency F12.4
  Post_Consistency F12.4
  Pre_Critical F12.4
  Post_Critical F12.4
.
EXECUTE.

* Variable labels.
VARIABLE LABELS Pre_Density 'Prompting density pre-test' Post_Density 'Prompting density post-test'.
VARIABLE LABELS Pre_Length 'Mean prompt length pre-test' Post_Length 'Mean prompt length post-test'.
VARIABLE LABELS Pre_Rejection 'AI-suggestion rejection rate pre-test' Post_Rejection 'AI-suggestion rejection rate post-test'.
VARIABLE LABELS Pre_Stance 'Stance marking pre-test' Post_Stance 'Stance marking post-test'.
VARIABLE LABELS Pre_Lexical 'Lexical agency pre-test' Post_Lexical 'Lexical agency post-test'.
VARIABLE LABELS Pre_Consistency 'Voice consistency pre-test' Post_Consistency 'Voice consistency post-test'.
VARIABLE LABELS Pre_Critical 'Critical dialogue pre-test' Post_Critical 'Critical dialogue post-test'.

* Compute post-minus-pre change scores.
COMPUTE Prompting_density_Change = Post_Density - Pre_Density.
COMPUTE Mean_prompt_length_Change = Post_Length - Pre_Length.
COMPUTE AI-suggestion_rejection_rate_Change = Post_Rejection - Pre_Rejection.
COMPUTE Stance_marking_Change = Post_Stance - Pre_Stance.
COMPUTE Lexical_agency_Change = Post_Lexical - Pre_Lexical.
COMPUTE Voice_consistency_Change = Post_Consistency - Pre_Consistency.
COMPUTE Critical_dialogue_Change = Post_Critical - Pre_Critical.
EXECUTE.

* Descriptive statistics.
DESCRIPTIVES VARIABLES=Pre_Density Post_Density Pre_Length Post_Length Pre_Rejection Post_Rejection Pre_Stance Post_Stance Pre_Lexical Post_Lexical Pre_Consistency Post_Consistency Pre_Critical Post_Critical /STATISTICS=MEAN STDDEV MIN MAX.

* Paired nonparametric comparisons; SPSS will produce Wilcoxon output.
NPAR TESTS /WILCOXON=Pre_Density WITH Post_Density (PAIRED) /MISSING ANALYSIS.
NPAR TESTS /WILCOXON=Pre_Length WITH Post_Length (PAIRED) /MISSING ANALYSIS.
NPAR TESTS /WILCOXON=Pre_Rejection WITH Post_Rejection (PAIRED) /MISSING ANALYSIS.
NPAR TESTS /WILCOXON=Pre_Stance WITH Post_Stance (PAIRED) /MISSING ANALYSIS.
NPAR TESTS /WILCOXON=Pre_Lexical WITH Post_Lexical (PAIRED) /MISSING ANALYSIS.
NPAR TESTS /WILCOXON=Pre_Consistency WITH Post_Consistency (PAIRED) /MISSING ANALYSIS.
NPAR TESTS /WILCOXON=Pre_Critical WITH Post_Critical (PAIRED) /MISSING ANALYSIS.

* Exploratory correlations among change scores.
NONPAR CORR
 /VARIABLES=Prompting_density_Change Mean_prompt_length_Change AI-suggestion_rejection_rate_Change Stance_marking_Change Lexical_agency_Change Voice_consistency_Change Critical_dialogue_Change
 /PRINT=SPEARMAN TWOTAIL
 /MISSING=PAIRWISE.

* Optional: save imported data with computed change scores as an SPSS .sav file.
SAVE OUTFILE='spss/DAR_processed_data.sav'.
EXECUTE.

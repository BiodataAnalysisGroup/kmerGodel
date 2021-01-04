 # Overview
This folder contains all the necessary R scripts in order to implement the statistical analysis of Gödel Number distributions, which is described in the first section of [this](https://docs.google.com/document/d/1NmUVwm7LgNPBs8XDQ6K_F3AxtICaeUjSTDy3h5Sd0Wk/edit?usp=sharing) report. An initial version of the report is also uploaded in the current folder as a .pdf file, however it may not be up to date.

# General Project Details:
- Input: Matrices consisting of 4 columns: **K-mer, Value, Gödel Number and entropy**. These matrices can be easily created by running the **kmer_godel_numbers.ipynb** script from [this](https://github.com/BiodataAnalysisGroup/kmerAnalyzerJupyter) github repository. The input in this Jupyter Notebook file should be a single .fasta file and the output are 4-column matrices for a specified k-range, one for each k-value.
- Output: The output is placed inside the 'plots/' direcoty and it depends on the script that you execute. Generally, it consists of plots inside the 'plots/sars_{encoding}/' directories - one folder for each gödel encoding - and .csv files, as it is mentioned below.

# Report details
Concerning the plots presented 

- Input: The input

# In this Repository
- Input:


## How to execute
- Change directory to ~/kmerGodel/R_statAnalysis folder.
- Install "combinat" R package
- Install "LaplacesDemon"
- Install "future.apply"
- **Specify number of cores in line 13**
- **Specify the input directory in line 18**
- **Specify the k-range in lines 24-25**
- Run the sars_analysis_v2.R script.

## Output
- A "plots" directory will be created, containing the total output of the project.

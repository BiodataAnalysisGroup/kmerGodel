 # Overview
This folder contains all R scripts necessary to implement the statistical analysis of Gödel Number distributions, which is described in the first section of [this](https://docs.google.com/document/d/1NmUVwm7LgNPBs8XDQ6K_F3AxtICaeUjSTDy3h5Sd0Wk/edit?usp=sharing) report. An initial version of the report is also uploaded in the 
current folder as a .pdf file, however it may not be up to date.


# General Project Details
- Input: Matrices consisting of 4 columns: **K-mer, Value, Gödel Number and entropy**. These matrices can be easily constructed by executing the **kmer_godel_numbers.ipynb** script from [this](https://github.com/BiodataAnalysisGroup/kmerAnalyzerJupyter) github repository. The input in this Jupyter Notebook file should be a single .fasta file and the output are 4-column matrices for a specified k-range, one for each k-value.
- Output: The output is placed inside the 'plots/' direcoty and it depends on the R script that you execute. Generally, the output consists of plots inside the 'plots/sars_{encoding}/' directories - one folder for each gödel encoding - and .csv files, as it is mentioned below.


# Report details
The results presented in the report came from the analysis of a dataset consisting of approximately 13.000 SARS-CoV-2 genome sequences. The total output is stored in my personal [drive](https://drive.google.com/drive/folders/11mT62OMDZwlY3J5LUcFVUbz5ubG6PLY8?usp=sharing).


# In this Repository
For the purpose of this repository, we used a subset of the total dataset consisting of 1.000 SARS-CoV-2 sequences. The matrices stored inside the 'input/' folder are the four-column matrices, which were created from the execution of kmer_godel_numbers.ipynb script, for a k-range 4 to 20.

# Scripts
For a better understanding of the purpose of each script, please checkout the [report](https://docs.google.com/document/d/1NmUVwm7LgNPBs8XDQ6K_F3AxtICaeUjSTDy3h5Sd0Wk/edit?usp=sharing) first.


## hellinger_norm_dist_divergence.R
- **Summary**: For a specified range of k-values and for all the 24 possible encodings, the script calculates the Hellinger divergence between gödel number distributions and the corresponding normal distributions.
- **Input**: Four-column matrices, one for each k-value.
- **Output**: 
 1. A .csv file containing all the hellinger divergence values from normal distribution, which is stored isnide 'plots/hellinger/' directory.
 2. Plots of gödel number PDFs inside the 'plots/sars_{encoding}/' directories.
- **Parameters to specify**: It calculates ...


## jeffreys_norm_dist_divergence.R
- **Summary**: It calculates ...
- **Input**: It calculates ...
- **Parameters to specify**: It calculates ...


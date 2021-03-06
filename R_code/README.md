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
 - **Parameters to specify**: 
   1. Number of processors to work (line 13)
   2. Input directory (line 19, please don't forget to put an '/' at the end)
   3. Range of k-values (lines 25-27)
   4. Input files code name (line 52)
   5. Output filename (line 75)


## jeffreys_norm_dist_divergence.R
 - **Summary**: For a specified range of k-values and for all the 24 possible encodings, the script calculates the Jeffreys divergence between gödel number distributions and the corresponding normal distributions.
 - **Input**: Four-column matrices, one for each k-value.
 - **Output**: 
   1. A .csv file containing all the Jeffreys divergence values from normal distribution, which is stored isnide 'plots/Jeffreys/' directory. 
   2. Plots of gödel number PDFs inside the 'plots/sars_{encoding}/' directories.
 - **Parameters to specify**: 
   1. Number of processors to work (line 14)
   2. Input directory (line 19, please don't forget to put an '/' at the end)
   3. Range of k-values (lines 25-27)
   4. Input files code name (line 52)
   5. Output filename (line 74)


## jsd_norm_dist_divergence.R
 - **Summary**: For a specified range of k-values and for all the 24 possible encodings, the script calculates the JSD divergence between gödel number distributions and the corresponding normal distributions.
 - **Input**: Four-column matrices, one for each k-value.
 - **Output**: 
   1. A .csv file containing all the JSD divergence values from normal distribution, which is stored isnide 'plots/JSD/' directory. 
   2. Plots of gödel number PDFs inside the 'plots/sars_{encoding}/' directories.
 - **Parameters to specify**: 
   1. Number of processors to work (line 14)
   2. Input directory (line 19, please don't forget to put an '/' at the end)
   3. Range of k-values (lines 25-27)
   4. Input files code name (line 54)
   5. Output filename (line 76)


## kld_norm_dist_divergence.R
 - **Summary**: For a specified range of k-values and for all the 24 possible encodings, the script calculates the KLD divergence between gödel number distributions and the corresponding normal distributions.
 - **Input**: Four-column matrices, one for each k-value.
 - **Output**: 
   1. A .csv file containing all the KLD divergence values from normal distribution, which is stored isnide 'plots/KLD/' directory. 
   2. Plots of gödel number PDFs inside the 'plots/sars_{encoding}/' directories.
 - **Parameters to specify**: 
   1. Number of processors to work (line 13)
   2. Input directory (line 18, please don't forget to put an '/' at the end)
   3. Range of k-values (lines 24-26)
   4. Input files code name (line 51)
   5. Output filename (line 74)


## hellinger_two_dists_divergence.R
 - **Summary**: For a specified range of k-values and for all the 24 possible encodings, the script calculates the Hellinger divergence between the gödel number distributions between k-mers that appears "many" times and k-mers that appear "only a few" times (Checkout the [report](https://docs.google.com/document/d/1NmUVwm7LgNPBs8XDQ6K_F3AxtICaeUjSTDy3h5Sd0Wk/edit?usp=sharing)).
 - **Input**: Four-column matrices, one for each k-value.
 - **Output**: 
   1. A .csv file containing all the hellinger divergence values between the two distributions, which is stored isnide 'plots/hellinger/' directory. 
   2. Plots of the two distributions and the k-mers spectrums as well, inside the 'plots/sars_{encoding}/' directories.
 - **Parameters to specify**: 
   1. Number of processors to work (line 14)
   2. Input directory (line 21, please don't forget to put an '/' at the end)
   3. Range of k-values (lines 27-29)
   4. Number of strains (line 32)
   5. Input files code name (line 56)
   6. Cut-off (line 69 -  the default is defined right in the middle)
   7. Output filename (line 83)


## jeffreys_norm_dist_divergence.R
 - **Summary**: For a specified range of k-values and for all the 24 possible encodings, the script calculates the Jeffreys divergence between the gödel number distributions between k-mers that appears "many" times and k-mers that appear "only a few" times (Checkout the [report](https://docs.google.com/document/d/1NmUVwm7LgNPBs8XDQ6K_F3AxtICaeUjSTDy3h5Sd0Wk/edit?usp=sharing)).
 - **Input**: Four-column matrices, one for each k-value.
 - **Output**: 
   1. A .csv file containing all the Jeffreys divergence values between the two distributions, which is stored isnide 'plots/Jeffreys/' directory. 
   2. Plots of the two distributions and the k-mers spectrums as well, inside the 'plots/sars_{encoding}/' directories.
 - **Parameters to specify**: 
   1. Number of processors to work (line 14)
   2. Input directory (line 21, please don't forget to put an '/' at the end)
   3. Range of k-values (lines 27-29)
   4. Number of strains (line 32)
   5. Input files code name (line 56)
   6. Cut-off (line 69 -  the default is defined right in the middle)
   7. Output filename (line 83)


## jsd_norm_dist_divergence.R
 - **Summary**: For a specified range of k-values and for all the 24 possible encodings, the script calculates the JSD divergence between the gödel number distributions between k-mers that appears "many" times and k-mers that appear "only a few" times (Checkout the [report](https://docs.google.com/document/d/1NmUVwm7LgNPBs8XDQ6K_F3AxtICaeUjSTDy3h5Sd0Wk/edit?usp=sharing)).
 - **Input**: Four-column matrices, one for each k-value.
 - **Output**: 
   1. A .csv file containing all the JSD divergence values between the two distributions, which is stored isnide 'plots/JSD/' directory. 
   2. Plots of the two distributions and the k-mers spectrums as well, inside the 'plots/sars_{encoding}/' directories.
 - **Parameters to specify**: 
   1. Number of processors to work (line 14)
   2. Input directory (line 21, please don't forget to put an '/' at the end)
   3. Range of k-values (lines 27-29)
   4. Number of strains (line 32)
   5. Input files code name (line 56)
   6. Cut-off (line 69 -  the default is defined right in the middle)
   7. Output filename (line 83)


## normDist_helping_functions.R
 - **Summary**: A script containing all the necessary functions calculate the divergence of gödel number distributions from the corresponding normal ones.


## two_dists_helping_functions.R
 - **Summary**: A script containing all the necessary functions calculate the divergence between the two gödel number distributions, the one consisting of k-mers that appears "many" times and the second one consisting k-mers that appear "only a few" times (Checkout the [report](https://docs.google.com/document/d/1NmUVwm7LgNPBs8XDQ6K_F3AxtICaeUjSTDy3h5Sd0Wk/edit?usp=sharing)).


## plotting.R
 - **Summary**: A script that creates all the figures related with the divergence-between-distributions stuff.
 - **Input**: A .csv file
 - **Output**: Figures
 - **Parameters to specify**: 
   1. Input file path (line 10)
   2. Output file path (line 13)
   3. Limits of y-axis (line 23)
   4. Title of plot (line 26)


## heatmap.R
- **Summary**: Code related with the construction of heatmap and clustering of encodings. Checkout [this](https://docs.google.com/presentation/d/115eN2muqNJGCIvBslBghr-9Vd1Vuk8JTxrIaJYzttXo/edit?usp=sharing) presentation for more details.

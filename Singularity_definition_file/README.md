# Singularity container
Singularity container with external inputs and outputs. Inputs are given as a full path from the local machine and outputs are placed in the specified path of the local machine.

## Creating the image file
1. Once you clone the total github repository, a 'kmerGodel' directory appears in the current directory.
2. Lets say that the full path of the local repository is /localmachine/path/to/kmerGodel
3. Copy the 

## Runing image file
Singularity run --bind /path/to/hostmachine/input_folder:/opt/home/usr/files,/path/to/hostmachine/output_folder:/opt/home/usr/results kmergodel.sif kmin kmax /path/to/hostmachine/input_folder/input_file.fasta

## Clarifications
1. Create an input_folder in your local machine and place a single input_file.fasta file inside.
2. Create an empty output_folder
3. /path/to/hostmachine/input_folder : the full path of the input folder within your local machine
4. /path/to/hostmachine/output_folder : the full path of the output folder within your local machine
5. /path/to/hostmachine/input_folder/input_file.fasta : the full path of the input_file.fasta within your local machine, which is placed inside the input folder
6. kmin anx kmax are integers

# kmerGodel
The aim of the project is to create a dictionary of all k-mers within an input file, count their multiplicities, calculate their godel numbers and use them as features to create data matrices.

## Inputs
The input of the project should be a single .fasta file.

## Run command from terminal
cd ~/kmerGodel/                                         # Change directory to the project path
python run.py kmin kmax path/to/input_file.fasta        # kmin and kmax are integers

## Singularity definition file folder
Inside the folder there is a .def file that creates a singularity image file for the project.
There is also a README file with instructions on how to create and run it.

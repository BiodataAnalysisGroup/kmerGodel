# kmerGodel
The aim of the project is to create a dictionary of all k-mers within an input file, count their multiplicities, calculate their godel numbers and use them as features to create data matrices.

## Inputs
The input of the project should be a single .fasta file.

## Run command from terminal
`$ cd localmachine/path/to/kmerGodel`

`$ python run.py kmin kmax /localmachine/path/to/input_file.fasta`

## Clarifications
1. localmachine/path/to/kmerGodel : the full path of the local repository
2. kmin and kmax are integers
3. localmachine/path/to/input_file.fasta: the full path of the input .fasta file within your local machine

## Singularity definition file folder
Inside the folder there is a .def file that creates a singularity image file for the project.
There is also a README file with instructions on how to create and run it.

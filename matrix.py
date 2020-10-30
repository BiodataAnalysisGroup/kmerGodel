import numpy as np
import pandas as pd

def create_matrix(file,best_k):
    fastq_filehandle = open(file, "r")
    # Start with an empty dictionary
    counts = {}
    seq=0
    # Loop over each line in the file
    line = ''
    seq_id="seq_{}".format(seq)

    for row in fastq_filehandle:
        # Keep the rows with data
        if ">" not in row:
            line = line + row.strip()
        else:
            if seq != 0:
                counts =count_kmers(seq_id,line,best_k,counts)
            
            seq=seq+1
            seq_id="seq_{}".format(seq)
            counts[seq_id]={}
            line = ''
    
    counts =count_kmers(seq_id,line,best_k,counts)

    matrix_data = pd.DataFrame(counts)
    fastq_filehandle.close
    
    # Create info file
    info = open("results/matrix-{}.txt".format(best_k),'a') 
    info.write(matrix_data.to_string(na_rep='0'))
    info.close()
    
    return



def count_kmers(id,read,k,counts):
 """Count kmer occurrences in a given sequence.

    Parameters
    ----------
	id: number of sequence.
    read : string
        A single DNA sequence.
    k : int
        The value of k for which to count kmers.
	counts : dictionary, {'string': int}
        A dictionary of counts keyed by their individual kmers (strings
        of length k).
    Returns
    -------
    counts : dictionary, {'string': int}
        A dictionary of counts keyed by their individual kmers (strings
        of length k).

    Examples
    --------
    >>> count_kmers("GATGAT", 3)
    {'ATG': 1, 'GAT': 2, 'TGA': 1}
"""

 # Calculate how many kmers of length k there are	
 num_kmers = len(read) - k + 1
 # Loop over the kmer start positions
 for i in range(num_kmers):
 # Slice the string to get the kmer
   kmer = read[i:i+k]
   # Add the kmer to the dictionary if it's not there
   if kmer not in counts[id]:
     counts[id][kmer] = int(0)
	# Increment the count for this kmer
   counts[id][kmer] =int(counts[id][kmer])+ int(1)
 # Return the final counts
 return counts	
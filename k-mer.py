import sys
import numpy as np
import pandas as pd
import math 
import operator
import count_kmers
from OrderedCounter import OrderedCounter as OrderedCounter
import godel_f
from nltk.probability import FreqDist, MLEProbDist
import matrix

if __name__ == "__main__":
    

	# initialize k from the first argument, convert to an integer
	k =int(sys.argv[1])
	print("Analysis for k = {0}".format(k))

	# Creating the .txt file from fasta file
	input_file_handle = open(sys.argv[2], "r")
	# Start with an empty dictionary
	counts = {}
	line = ''

	for row in input_file_handle:
		
		if ">" not in row:
			line = line + row.strip()
		else:
			
			#Use of count_kmers routine
			counts = count_kmers.count_kmers(line.upper(),k,counts)
			line = ''

	counts = count_kmers.count_kmers(line.upper(),k,counts)

	#Close input file
	input_file_handle.close

	# Sort dictionary by value
	sorted_counts = dict(sorted(counts.items(), key=operator.itemgetter(1)))
	del counts
	#Array of the dictionary values
	sorted_data=np.array(list(sorted_counts.values()))
	#Array of the dictionary keys
	sorted_keys=np.array(list(sorted_counts.keys()))

	# Count of the class values
	counter=OrderedCounter(sorted_data)   

	# Count of the frequency of each class
	counter_class=OrderedCounter(counter.keys())

	# Array of the classes
	classes={}
	classes=[count for n,count in counter.items() for i in range(count)]

	# Variables (X,Y) for the machine learning algorithms
	Y = np.array(classes).T

	del classes
	del counter

	#Calculate entropy with nltk library
	freq_dist = FreqDist(sorted_counts)
	prob_dist = MLEProbDist(freq_dist)
	px = [prob_dist.prob(x) for x,n_x in sorted_counts.items()]
	e_x = [-p_x*math.log(p_x,2) for p_x in px]

	del freq_dist
	del prob_dist
	del px

	# Calculate the prime numbers for Godel Numbers
	prime_numbers=[]
	prime_numbers=godel_f.sieve(k)

	# Calculate Godel Numbers
	godel_numbers={}
	godel_numbers=godel_f.godel(sorted_counts,prime_numbers,godel_numbers)
	del prime_numbers

	# Variables (X,Y) for the machine learning algorithms
	X = np.vstack(([np.array(e_x)],[np.array(list( godel_numbers.values()))])).T

	# finding file code
	split_path = str(sys.argv[2]).split('/')[-1]
	filecode = split_path.split('.')[0]

	# Create info file
	info = open("results/" + filecode + "_info_k={0}.txt".format(k),"w")
	df_data = pd.DataFrame({'K-mer':sorted_keys,'Value':sorted_data,'Godel_number':np.array(list(godel_numbers.values())),'Entropy':e_x}) 
	info.write(df_data.to_string())
	info.close()

	# Free memory
	del godel_numbers
	del e_x
	del counter_class
	del sorted_data
	del sorted_keys
	del X
	del Y

	# For print the Sequence matrix
	matrix.create_matrix(sys.argv[2],k)
import numpy as np
import math 


def  godel(read,out_array,godel_numbers):
	"""Count godel numbers in a given read.

    Parameters
    ----------
    read : dictionay
        Dictionary with the DNA sequences.
    out_array : array
        The array with the prime numbers.
	godel_numbers : dictionary
		Dictionary with the godel numbers.
    Returns
    -------
    godel_numbers : dictionary, {'string': float}
        A dictionary of strings keyed by their individual godel numbers (strings
        of length k).
 
    """

	# For every string
	for elem in read.keys():
		point_in_string=0
		# If the key is new
		if elem not in godel_numbers:
			godel_numbers[elem] = 0
		# Calculate the godel number for the key
		for x in elem:
			if x == 'A' or x == 'a':
				godel_numbers[elem]+=out_array[point_in_string]*1
				point_in_string=point_in_string+1
			if x == 'T' or x == 't':
				godel_numbers[elem]+=out_array[point_in_string]*4
				point_in_string=point_in_string+1
			if x == 'G' or x == 'g':
				godel_numbers[elem]+=out_array[point_in_string]*3
				point_in_string=point_in_string+1
			if x == 'C' or x == 'c':
				godel_numbers[elem]+=out_array[point_in_string]*2
				point_in_string=point_in_string+1
			
	return godel_numbers

def sieve(n):
	"""Count the array of prime numbers of k-mer

    Parameters
    ----------
    n : int
        K-mer number.
    
    Returns
    -------
    out_array : array, { float}
        An array with the log prime numbers.
 
    """
	primes=[]
	chkthis = 2
	while len(primes) < n:
		ptest    = [chkthis for i in primes if chkthis%i == 0]
		primes  += [] if ptest else [chkthis]
		chkthis += 1
     
	primes = np.log(primes) 
					
	return primes 


	
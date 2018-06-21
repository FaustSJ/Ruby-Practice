#!/usr/bin/ruby
#Homework 4 for CS 465. Code written by Sarah Faust

#calculates the n'th value of the fibonacci sequence
def fib(n)
	if n==0
		return 0
	end
	if n==1 or n==2
		return 1	
	end 
	
	x = 1
	y = 1
	count = 3
	while count<=n do
		x = x+y
		y = y+x
		count += 2
	end
	
	if (n%2)==0
		return y
	else
		return x
	end
end

##########################################
#returns a reversed version of the given list, xs
def reversed(xs)
	sx = []
	i = xs.size - 1
	while i>=0 do
		sx << xs[i]
		i -= 1
	end
	return sx
end

############################################

def is_prime(n)
	if n==0 or n==1
		return false
	end
	if n<0
		return false
	end
	check = true
	primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53,
		          59, 61, 67, 71, 73, 79, 83, 89, 97101, 103, 107, 109, 113,
		          127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181,
		          191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251,
		          257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317,
		          331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397,
		          401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463,
		          467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557,
		          563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619,
		          631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701,		          
		          709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787,
		          797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863,
		          877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953,
		          967, 971, 977, 983, 991, 997]
	root = n**0.5
	for i in 0..(primes.size-1) do
		if root<primes[i]
			break
		end
		if (n%primes[i])==0
			check = false
			break
		end
	end
	return check
end

#############################################
#returns a version of list xs without multiples of any element	
def nub(xs)
	noDup = Array.new
	found = false
	for i in 0..(xs.size - 1) do
		found = false
		if noDup.size>0
			for k in 0..(noDup.size-1) do
				if xs[i]==noDup[k]
					found = true
				end
			end
		end
		if found==false
			noDup = noDup << xs[i]  #pushed the obj into the array
		end
	end
	return noDup
end

#############################################
#"zips" xs and ys values together with function f
def zipwith(f, xs, ys)
	#check which list is shorter
	indexer = xs.size
	if ys.size<indexer
		indexer = ys.size
	end
	
	#"zip" the lists together
	results = []
	for i in 0...indexer do
		results << f.call(xs[i], ys[i])
	end
	return results
end

#############################################
#creates a sequence of numbers from n to 1 following a set of rules
def collatz(n)
	coList = []
	coList << n
	while n>1 do
		if (n%2)==0
			n = n/2
		else
			n = n*3+1
		end
		coList << n
	end
	return coList
end

###############################################
#used by file_report to return the stored calculations
class Report
	def initialize(mean, median, mode)
		@mean = mean
		@median = median
		@mode = mode
	end
	
	#print return
	def str
		return ("("+ (@mean.to_s) +","+(@median.to_s)+"," +(@mode.to_s)+")")
	end
	
	#getters
	def mean
		@mean
	end
	def median
		@median
	end
	def mode
		@mode
	end
	
	#setters
	def mean=(m)
		@mean = m
	end
	def median=(m)
		@median = m
	end
	def mode=(m)
		@mode = m
	end
end

#finds the mean, median, and mode of a list in a given file
def file_report(filename)
	#reading the file
	storeNum = IO.readlines(filename)
	
	#converting to ints and claculating the mean
	mean = 0.0
	for i in 0..(storeNum.size - 1) do
		storeNum[i] = Integer(storeNum[i])
		mean += storeNum[i]
	end
	mean = mean/storeNum.size
	
	#calculating the median
	storeNum.sort!
	median = 0.0
	if ((storeNum.size)%2)==0
		x = storeNum[storeNum.size/2]
		y = storeNum[(storeNum.size/2)-1]
		median = x+y
		median = median / 2.0
	else
		median = storeNum[Integer(storeNum.size/2)]
	end
	
	#calculating mode	
	noDup = []
	mode = []
	found = false
	for i in 0..(storeNum.size - 1) do
		found = false
		if noDup.size>0:
			for k in 0..(noDup.size - 1) do
			
				if storeNum[i]==noDup[k]
					mode << storeNum[i]
					found = true
				end
			end
		end
		if found==false
			noDup << storeNum[i]
		end
	end
	if mode.size==0
		mode = noDup
	end
	mode = nub(mode)
	mode.sort!
	
	
	#returning the results
	return Report.new(mean, median, mode)

end



##############################################
#checks if the grid is a solved sudoku puzzle
def check_sudoku(grid)
	#checking the rows
	for i in 0..8 do
		checker = nub(grid[i])
		if checker.size<9
			return false
		end
	end
	
	#checking the columns
	for i in 0..8 do               
		curBox = Array.new
		for k in 0..8 do
			curBox << grid[k][i]
		end
		checkBox = nub(curBox)
		if checkBox.size<curBox.size
			return false
		end
	end
		
	
	#checking the 3x3's
	for i in 0..9
		curBox = Array.new
		if i==1
			#check top left
			for j in 0..2 do
				for k in 0..2 do
					curBox << grid[j][k]
				end
			end
		end
		if i==2
			#check top middle
			for j in 0..2 do
				for k in 3..5 do
					curBox << grid[j][k]
				end
			end
		end
		if i==3
			#check top right
			for j in 0..2 do
				for k in 6..8 do
					curBox << grid[j][k]
				end
			end
		end
		if i==4
			#check middle left
			for j in 3..5 do
				for k in 0..2 do
					curBox << grid[j][k]
				end
			end
		end
		if i==5
			#check middle middle
			for j in 3..5 do
				for k in 3..5 do
					curBox << grid[j][k]
				end
			end
		end
		if i==6
			#check middle right
			for j in 3..5 do
				for k in 6..8 do
					curBox << grid[j][k]
				end
			end
		end
		if i==7
			#check bottom left
			for j in 6..8 do
				for k in 0..2 do
					curBox << grid[j][k]
				end
			end
		end
		if i==8
			#check bottom middle
			for j in 6..8 do
				for k in 3..5 do
					curBox << grid[j][k]
				end
			end
		end
		if i==9
			#check bottom right
			for j in 6..8 do
				for k in 6..8 do
					curBox << grid[j][k]
				end
			end
		end
		checkBox = nub(curBox)
		if checkBox.size<curBox.size
			return false
		end
	end
	#if all tests were passed, retur true
	return true
end 

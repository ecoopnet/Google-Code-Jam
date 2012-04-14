#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb

class Solver
	def solve line
		items = line.split " "
		@min = items.shift.to_i
		@max = items.shift.to_i
		@digits = @min.to_s.length
		i = @min
		result = 0
		o={}
		while i <= @max
			#if (i.to_s.index "0") != nil
			#if i%10 == 0
				#i+=1
				#next
			#end
			shiftCount i, 0, o
			i+=1
		end
		#if o.length != 0
			#print (o.keys.join ","), "\n"
		#end
		return o.length
		#return result.to_s;
	end
	def shiftCount(i,n=0, results = {}, depth = 0)
		if n + depth >= @digits
			return 
		end
		# shift
		d = 10 ** (depth + 1)
		i2 = (i % d) * (10 ** (@digits-1-depth)) + (i / d)
		#print i,",",i2,"(n=",n,",r=",results.length,",d=",depth,")"
		if @min <= i && i<i2 && @min <= i2 && i2 <= @max && results[i.to_s + "-" + i2.to_s]==nil
			results[i.to_s + "-" + i2.to_s] = 0
	#		print "!"
		end
	#		print "\n"
		n2 = n + 1
		d2 = depth
		while n + d2 < @digits
			#print i,",",i2,":dp=",depth,"\n"
			d2+=1
			shiftCount i, n, results, d2
		end
		shiftCount i2,n2,results
	end
end

solver = Solver.new
number = ARGF.gets
i = 0
while line = ARGF.gets
	line.strip!
	if line == ""
		next
	end
	i+=1
	print "Case #",i,": ", solver.solve(line),"\n"
end

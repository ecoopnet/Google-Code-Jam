#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb

class Solver
	def solve line
		items = line.split(" ")
		@L = items.shift.to_i
		@M = items.shift.to_i
		@exp = items.sort.reverse
		@exp.delete("0")
		if @exp.length == 0
			return 0
		end
		@exp.each do |i|
			if i.to_i > @L
				return -1;
			end
		end
		min = @exp.pop.to_i
		if @L == 0
			return 0
		end

		#print @exp,min,"/",@M,"/",@L,"\n"
		res = 0
		if @M > 1
			res+=(@M-1)*@L
#			@exp.each do |i|
#				res+= (i.to_i * @L)
#			end
		end
		#print min,"\n"
		if (min > 0)
			res+=min
		end
		return res;
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

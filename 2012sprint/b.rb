#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb

class Solver
	def solve line
		items = line.split(" ")
		@K = items.shift.to_i
		@S = items.shift
		i = 0
		results = []
		while i <= @S.length - @K
			v = @S[i,@K]
			if (@S.rindex v) > i
				results.push v 
			end
			i+=1
		end
		if results.length == 0
			return "NONE"
		end
		return results.sort.uniq.join " "
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

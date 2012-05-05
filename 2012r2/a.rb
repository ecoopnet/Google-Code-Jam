#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb

class Solver
	def solve line
		items = line.split " "
		@N = items.shift.to_i
		@list = []
		sum = 0
		items.each do |i|
			sum += i.to_i
			@list.push i.to_i
		end
		min = sum.to_f * 2 / @N
		res = []
		minItem = @list.sort.shift
		@list.each do |i|
			print "i=", i, ",min=", min, " sum=",sum,"\n"
			t = (min - i) * 100 / sum
			if t < 0
				res.push sprintf("%d", 0)
			else
				res.push sprintf("%#.06f", t)
			end
		end
		#p @list, sum, min
		return( res.join " " );
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

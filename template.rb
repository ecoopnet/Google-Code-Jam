#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb
require "pp"

class Solver
	def solve line
		items = line.split(" ")
		return "";
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

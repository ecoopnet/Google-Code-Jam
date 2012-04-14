#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb

class Solver
	def initialize
		@MIRROR = "#"
		@FLOOR = "."
		@ME = "X"
	end
	def solve lines
		line = lines.shift
		items = line.split(" ")
		return "";
	end
end

solver = Solver.new
number = ARGF.gets.to_i
lines = []
while line = ARGF.gets
	line.strip!
	if line == ""
		next
	end
	lines.push line
end
i = 0
while i < number
	i+=1
	print "Case #",i,": ", solver.solve(lines),"\n"
end

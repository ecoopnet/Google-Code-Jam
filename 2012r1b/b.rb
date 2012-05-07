#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb

class Solver
	def solve lines
		line = lines.shift
		items = line.split(" ")
		@water_h = items.shift.to_i
		@H = items.shift.to_i
		@W = items.shift.to_i
		ceilings = []
		x = 0; y = 0
		while y < @H do
			line = line.shift
			items = line.split(" ")
			y+=1
			row = []
			while x < @W do
				x+=1
				row.push items.shift.to_i
			end
			ceilings.push row
		end
		floors = []
		x = 0; y = 0
		while y < @H do
			line = line.shift
			items = line.split(" ")
			y+=1
			row = []
			while x < @W do
				x+=1
				row.push items.shift.to_i
			end
			floors.push row
		end
		
		# not implemented

		
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

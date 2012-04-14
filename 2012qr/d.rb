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
		@H = items.shift.to_i
		@W = items.shift.to_i
		@D = items.shift.to_i
		@startX = 0
		@startY = 0
		maplines = lines.shift @H
		@map = []
		y=0
		maplines.each do |line|
			row = line.split("")
			@map << row
			if row.index(@ME) != nil
				@startX = row.index(@ME) + 0.5 
				@startY = y + 0.5 
			end
			y+=1
		end
		@map.each do |row|
			print (row.join " "),"\n"
		end
		simulate 0
		return "";
	end
	def simulate rad
		x = @startX
		y = @startY
		d = 0
		while d <= @D
			d+=1
		end
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

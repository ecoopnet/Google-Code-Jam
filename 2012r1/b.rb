#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb

class Solver
	def solve lines
		line = lines.shift
		items = line.split(" ")
		number = items.shift.to_i
		i=0
		# 未実装！
		return "";


		map = []
		while i < number
			line = lines.shift
			items = line.split(" ")
			map.push [items[0].to_i, items[1].to_i]
			i+=1
		end
		mapsort map
		p map
		star = 0
		step = 0
		while map.length > 0
			# LV2がとけないか
			if map[0][1] <= stars
				star+=2
				step+=1
				map.shift
				mapsort map
			end
			# LV1 がとけないか
				i = 0
				while i < map.length
					i+=1
				end
				return "";
			end
		end
	end
	def mapsort map
		map.sort! do |a,b|
			t = a[1] - b[1]
			if t != 0 
				t
			else
				t= a[0] - b[0]
			end
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

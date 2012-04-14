#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb

class Solver
	def solve line
		items = line.split(" ")
		@number = items.shift.to_i
		@surprising = items.shift.to_i
		@threshold = items.shift.to_i
		@points = items
		# 3n+0 => n, n+1
		# 3n+1 => n+1, n+1
		# 3n+2 => n+1, n+2
		# Count without surprizing
		regular_rated = 0
		# Count available when surprising
		surprising_rated = 0
		@points.each do |p|
			p = p.to_i
			div=p./3
			mod=p%3
			sp=0
			if p > 0
				case mod
				when 0
					sp=1
				when 1
					div+=1
				when 2
					div+=1
					sp=1
				end
			end
			if @threshold <= div
				regular_rated+=1
			elsif @threshold <= div+sp
				surprising_rated+=1
			end
			#print p,",div=",div,",mod=",mod,",sp=",sp,",th=",@threshold,",rr=",regular_rated,",sr=",surprising_rated,"\n"
		end
		if @surprising < surprising_rated
			surprising_rated = @surprising
		end
		return (regular_rated + surprising_rated).to_s
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

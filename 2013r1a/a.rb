#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb
# 1cm 円盤一つでpi cm^2
# 1ml で pi cm^2 をぬれる
# 半径rの白円の周りに1cmの黒い円
require "pp"

class Solver
	def solve line
		items = line.split(" ")
		r = items.shift.to_i
		t = items.shift.to_i
		c=0
		i = 1
		imax = 10**18
		imin = 1
		i = (imax+imin)/2
		prev = -1
		loop do
			res = calc_cost2 r, i
			#print  r,",",t,": ", i, " (min:",imin,",max:",imax,")", res,"\n"
			if res > t
				if imax > i
					imax = i 
				end 
				i2 = i
				i = (i - imin) / 2 + imin
				#print "next ",i2," ->", i,",pr:",prev,"\n"
				if i2 == i
					if i - 1 == imin 
						return i
					end
					i= i - 1
				end 
			elsif res < t
				# まだいける
				if imin < i
					imin = i
				end
				i2 = i
				i = (imax - i) / 2 + imax
				#print "next ",i2," ->", i,"\n"
				if i2==i 
					if i + 1 == imax 
						return i
					end 
					i= i + 1
				end 
				if t <( calc_cost2 r, i2 + 1)
					return i2
				end
			else
				#print "match ",i,"\n"
				return i
			end
		end
	end
	def calc_cost(r)
		return -r*r+(r+1)*(r+1)
	end 
	def calc_cost2(r, n)
		init_cost = calc_cost(r)
		return ((n.to_f/2)*(2 * init_cost + (n-1) * 4)).to_i
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

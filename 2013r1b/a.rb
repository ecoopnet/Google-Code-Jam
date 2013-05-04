#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb
require "pp"

class Solver
#	DEBUG = true
	DEBUG = false
	def solve lines
		line = lines.shift
		items = line.split(" ")
		@a = items.shift.to_i
		@n = items.shift.to_i
		line = lines.shift
		items = line.split(" ")
		motes = []
		items.each{ |s|
			i = s.to_i
			motes.push i
		}
		motes.sort!
		@motes = motes

		a=@a
		res=0
		pp a,motes if DEBUG
		#pp motes
		#cost = simple_proc a, motes
		#res = proc2 a, motes, cost
		
		return proc a, 0
	end
	def proc a, pos
		if pos == @motes.length
			return 0
		end
		i = @motes[pos]
		print a," vs ",i," at ",pos,"/",@motes.length,"\n" if DEBUG
		if a > i
			a = a + i
			return proc a, pos + 1
		end
		if ((a + a - 1) > i)
			# append
			print  a," appended ",(a-1)," then absorb ",i,"\n" if DEBUG
			a = a + a - 1
			# i を吸収
			a = a + i
			return 1 + (proc a, pos + 1)
		end
		if a == 1
			return 1 + (proc a, pos + 1)
		end
		# コスト計算
		o = cost? a, i
		cost = o[:cost]
		sum = o[:total]
		print a," to ", i , " cost is ", cost,"\n" if DEBUG
		a2 = sum
		res1 = 1 + (proc a, pos + 1) #remove版
		res2 = cost + (proc a2, pos + 1)
		if DEBUG
			print a, " vs ", i
			if res1 < res2
				print " return simple ",res1," than ", res2, "\n"
			else
				print " return ma(a2=",a2," :cost=",cost,") ",res2," than ", res1, "\n"
			end
		end
		return res1 if res1 < res2
		return res2
	end
	def proc2 a, motes, simple_cost
		res = 0
		for k in 0 ... motes.length 
		       	i = motes[k]
			print  a," next ",i,"\n"  if DEBUG
			if a > i
				a = a + i
				print  a," absorb ",i,"\n" if DEBUG
				next
			end	
			if a == 1 || ((a + a - 1) < i)
				# remove
				c = cost? a,i
				if res < cost 
				end
				print  a," remove ",i,"\n" if DEBUG
				res = res + 1
				next
			end
			# 1つ下を追加
			print  a," appended ",(a-1)," then absorb ",i,"\n" if DEBUG
			a = a + a - 1
			res = res + 1
			# i を吸収
			a = a + i
		end
		return res
	end
	def simple_proc a, motes
		motes.each { |i|
			
			print  a," next ",i,"\n"  if DEBUG
			if a > i
				a = a + i
				print  a," absorb ",i,"\n" if DEBUG
				next
			end	
			if a == 1 || ((a + a - 1) < i)
				# remove
				print  a," remove ",i,"\n" if DEBUG
				res = res + 1
				next
			end
			# 1つ下を追加
			print  a," appended ",(a-1)," then absorb ",i,"\n" if DEBUG
			a = a + a - 1
			res = res + 1
			# i を吸収
			a = a + i
		}
		return res 
	end
	def cost? a,b
		if a > b
			return 0
		end
		t = a 
		res = 0
		while t <= b
			t = t * 2 - 1
			res=res+1
		end
		return {:cost => res, :total => t + b}
	end
	def can_absorb? a, motes, from, length
		t = a
		for i in from ... (from + length)
			if a > i
				a = a + i
				next
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

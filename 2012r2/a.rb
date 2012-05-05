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
		@sublist = @list.clone
		tmin = min
		while true
			@sublist.delete_if { |i|
				t = (tmin - i) * 100 / sum
				t < 0
			}
			#recalculate
			subsum = 0
			@sublist.each do |i|
				subsum+=i
			end
			submin = (sum + subsum.to_f) / @sublist.length
			tmin = submin
			needRetry = false
			@sublist.each do |i|
				t2 = (submin - i) * 100 / sum
				if t2<0
					needRetry = true
					break
				end
			end
			if needRetry
				next
			else
				break
			end
		end
		#print "sum=",sum, ", subsum=", subsum , ",min=",min, ", submin=", submin,"\n"
		res = []
		@list.each do |i|
			#print "i=", i, ",min=", min, " sum=",sum,"\n"
			t = (min - i) * 100 / sum
			if t < 0
				#res.push sprintf("%d", 0)
				res.push sprintf("%#.09f", 0)
			else
				t2 = (submin - i) * 100 / sum
				if t2 < 0
					t2 = 0
				end
				res.push sprintf("%#.09f", t2)
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

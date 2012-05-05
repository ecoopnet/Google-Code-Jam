#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb

class Solver
	def solve line
		items = line.split " "
		@N = items.shift.to_i
		@numbers = []
		items.each do |i|
			@numbers.push i.to_i
		end 
		@numbers.sort!
		n = 2
		while n < @N
			# N文字の組み合わせと一致する数値がないかを探す
			tsum = 0
			# 選択位置の配列
			selected = []
			(0...n).each do |i|
				selected.push i
			end 
			i = n - 1
			while i >= 0
				sum = sumOf(selected[i])
				pair = find sum, selected 
				if pair
					return "\n" + stringOf(selected) + "\n" +  stringOf(pair)
				end 
				i-=1
			end 
			n+=1
		end
		return "\nimpossible";
	end
	def sumOf(indexes)
		res = 0
		indexes.each do |i|
			res+=@numbers[i]
		end 
		return res
	end 
	def stringOf(indexes)
		res = []
		indexes.each do |i|
			res.push @numbers[i].to_s
		end 
		return res.join " "
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

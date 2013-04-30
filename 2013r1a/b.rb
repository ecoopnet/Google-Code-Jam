#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb
# エネルギー活動
# E=最大エネルギー(＆初期値)
# R=活動後に回復するエネルギー 
# N=活動数
# activities=活動一覧(順番に処理され価値をあらわす)
# 任意の力で仕事ができる。
# スコアは使ったエネルギー☓価値 
require "pp"

class Solver
	def solve lines
		line = lines.shift
		items = line.split(" ")
		@e = items.shift.to_i
		@r = items.shift.to_i
		@n = items.shift.to_i
		line = lines.shift
		items = line.split(" ")
		@activities = [] 
		for i in 0...@n
			@activities.push items.shift.to_i
		end
		pp @activities
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

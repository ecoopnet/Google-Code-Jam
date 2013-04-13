#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb
# マルバツゲームの勝敗判定
# tic-tac-toe-tomak
# 4x4のボードゲーム
# Tが１マスある
# プレイヤーX, Oがいて、それぞれX,Oというシンボルを動かす
# Xから始まる
# 
require "pp"
class Solver
	def solve lines
		#items = line.split(" ")
		has_not_completed = false
		square = []
		#pp lines.length
		while line = lines.shift 
			if line == ""
				break
			end
			col = []
			line.each_char { |chr|
				case chr
				when "."
					has_not_completed = true
					col.push 0
				when "O"
					col.push 1
				when "X"
					col.push 2
				when "T"
					col.push 3
				end
			}
			square.push col
		end
	#	pp square,";\n"
		# 横チェック
		square.each { |e| 
			res = check e 
			if res > 0
				return to_response res
			end
		}
		# 横チェック
		for i in 0...4
			res = check [square[0][i], square[1][i], square[2][i], square[3][i]]
			if res > 0
				return to_response res
			end
		end
		# ななめ
		res = check [square[0][0], square[1][1], square[2][2], square[3][3]]
		if res > 0
			return to_response res
		end
		res = check [square[0][3], square[1][2], square[2][1], square[3][0]]
		if res > 0
			return to_response res
		end

		if has_not_completed
			return "Game has not completed"
		end
		return "Draw";
	end
	def to_response res
		case res
		when 1
			return "O won"
		when 2
			return "X won"
		end
	end
	# 勝敗判定
	def check square
		i = 3
		square.each {  |t|
			i&=t
		 }

		 t = (i <= 2? i: 0)
	#	 print "check:",square,"=",i,"\n"
		 return t
	end
end

solver = Solver.new
number = ARGF.gets.to_i
lines = []
while line = ARGF.gets
	line.strip!
	#if line == ""
	#	next
	#end
	lines.push line
end
i = 0
while i < number
	i+=1
	print "Case #",i,": ", solver.solve(lines),"\n"
end

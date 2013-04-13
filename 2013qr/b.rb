#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb
# 芝刈り問題
# NxMメーターの芝生
# 自動芝刈り機の設定:
#   高さ 1<=h<=100 ミリ  hミリ以上の全部をカットする
#   設定は芝生外でだけ行い、1m幅で垂直、直線に進む
# 芝生は全部高さ 100mm で揃っているとする
# 特定のパターンの芝を作ることが可能かどうかを調べる
#
# 個別のますについて判定
# 上下、左右のペアで、自分のますより大きいものは壁になる。
# 上下左右すべて壁ならNG
# 端は必ず実現可能
# 
require "pp"
class Solver
	YES = "YES"
	NO = "NO"
	
	DEBUG= false

	def solve lines
		line = lines.shift
		items = line.split(" ")
		n = items.shift.to_i
		m = items.shift.to_i

	square = []
		for y in 0 ... n
			line = lines.shift
			items = line.split(" ").map { |e| e.to_i }
			square.push items
		end
		#debug_pp square
		# 1列は確実に実現可能
		if n <= 1 || m <= 1
			return YES
		end
		# 列単位の判定
		for y in 0 ... n
			for x in 0 ... m
				if check_line x, square[y]
					next
				end
				if check_line y, row(square, x)
					next
				end
				# だめだった
				return NO
			end
		end
		return YES;
	end

	def debug msg
		if DEBUG
			print msg,"\n"
		end
	end
	def debug_pp obj
		if DEBUG
			pp obj 
		end
	end
	def check c, up, down, left, right
	end
	# 指定したインデックスの高さはこの行で実現可能か
	def check_line index, line
		for i in 0 ... line.length
			if line[i] > line[index]
				return false
			end
		end
		return true
	end
	def row square, x
		res = []
		for i in 0 ... square.length
			res.push square[i][x]
		end
		return res
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

#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb
#ダイヤモンドテトリス
# ランダムにずれ落ちる@n個のダイヤが@x,@yに落ちる確率
require "pp"

class Solver
#	DEBUG = true
	DEBUG = false
	def solve line
		items = line.split(" ")
		@n = items.shift.to_i
		@x = items.shift.to_i
		@y = items.shift.to_i
		# 方形
		n = (@x.abs + @y)/2 + 1
		# min (これ未満は0%) .5, .75 ...
		min =peak_max(n - 1) + 1 + @y
		# max (これ以上は100%)
		max = peak_max(n - 1) + 2 * n - 1 + @y
		print "times=",@n," (",@x,", ",@y,") n=",n," min=",min," max=",max,"\n"  if DEBUG
		# ピークだけは特別
		if @x == 0
			pp "peak" if DEBUG
			if @n < peak_max(n)
				return 0.0
			end
			return 1.0
		end
		if @n < min
			return 0.0
		end
		if @n >= max
			return 1.0
		end
		t = @n - min + 1 
		#res = 0.0
		#for i in 1..t
		#	res = res + 1.0 / (2 ** t)
		#end
		res = combinate_over(t + @y, @y + 1) / 2**(t + @y)
		return sprintf("%.7f",res) 
	end
	# 方形の頂点の到達に必要な個数
	def peak_max n
		return (2 * n - 1 ) * n
	end
	# nCr の計算
	def combinate n,r
		a = 1.0
		b = 1.0
		for i in 0...r
			a = a * (n - i)  
			b = b * (1 + i)
		end
		return a/b
	end
	# r以上nまでのnCrの計算
	def combinate_over n,r
		res = 0
		for i in r..n
			res = res + combinate(n,i)
		end
		return res
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

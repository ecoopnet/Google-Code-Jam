#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb

class Solver
	def solve lines
		line = lines.shift
		items = line.split(" ")
		typed = items.shift.to_i
		total = items.shift.to_i
		line = lines.shift
		items = line.split(" ")
		p = []
		items.each do |f|
			p.push f.to_f
		end
		result = 0
		# 打鍵数表
		map = []
		fpos = 0 # 失敗の位置(最後から数える).0はミスなし
		while fpos <= typed 
			record = []
			# bs
			i=0
			while i <= typed
				if i < fpos
					record.push(total - typed + 1 + i*2 + total + 1 )
				else
					record.push(total - typed + 1 + i*2)
				end
				i+=1
			end
			# enter
			record.push(total + 2)
			map.push record
			fpos+=1
		end
		# 最初に間違えたのが後ろからfpos文字目の時の期待値計算
		fpos = 0
		probs = []
		while fpos <= typed 
			t = 1
			i = 0
			while i < typed - fpos
				t = t * p[i]
				i+=1
			end
			if fpos > 0
				t*= 1-p[typed - fpos]
			end
			probs.push t
			fpos+= 1
		end
		i = 0
		expects = []
		expects.fill(0, map[0].length){ 0  }
		while i < map.length
			record = map[i]
			c = 0
			while c < record.length
				expects[c] += probs[i]*record[c]
				c+=1
			end
			i+=1
		end
		#p probs
		#p map
		#p expects
		return sprintf("%#.06f", expects.sort[0])
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

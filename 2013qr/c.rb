#!/usr/bin/env ruby-1.9.3-p125 -Ku
# Usage: cat problems | program.rb
# A~Bの間で回文かつ２乗になっている数値の数を求める A <= t <= B
require "pp"

if "a"[0]  != "a"
	throw "ruby 1.9 required."
end

class Solver
	def solve line
		items = line.split
		a = items.shift.to_i
		b = items.shift.to_i

		count = 0
		min=Math.sqrt(a).ceil
		max=Math.sqrt(b).floor

		#print  "min:", min," max:",max,"\n"

		# 12321
		# 40000 ~ 100000000

		build_palindromes(min, max){|i| 
			if is_palindromes?(i**2)
			#	print  "match:"+(i**2).to_s+"\n"
				count+=1
			#else
			#	print i,",\n"
			end
		}
		return count;
	end

	def build_palindromes min,max
		min_s = min.to_s
		max_s = max.to_s
		min_len = min_s.length
		max_len = max_s.length
		min_half_pal = min_s[0, min_len/2].to_i
		max_half_pal = max_s[0, max_len/2].to_i
		#min_half_pal_odd = min_s[0, min_len/2+1].to_i
		#max_half_pal_odd = max_s[0, max_len/2+1].to_i
		min_center = min_s[min_len/2].to_i
		max_center = max_s[max_len/2].to_i

#		print "min:"+min_s+", half:",min_half_pal,",max:"+max_s+", half:",max_half_pal,"\n"

		for n in min_len..max_len
			# n 文字の回文
			is_odd = (n % 2 == 1)
			if !is_odd
				first = ((n > min_len)? (10**((n-1)/2)): min_half_pal)
				last = ((n < max_len)? ((10**(n/2))-1): max_half_pal)
			else
				first = ((n > min_len)? (10**((n-2)/2)): min_half_pal)
				last = ((n < max_len)? ((10**((n-1)/2))-1): max_half_pal)
				if n == 1 && n < max_len
				end
			end
			#print "loop(",n,"):f=",first,",l=",last,"\n"
			# n=2
			# i=0~9, v=0~9
			# n=3
			# i=0~9, v=0~9
			# n=4
			# i=10~99
			if n == 1
				for v in 0..9
					if v >= min && v <= max
						yield v
					end
				end
			elsif !is_odd
				for i in first..last
					num = (i.to_s + i.to_s.reverse).to_i
					if num >= min && num <= max 
						yield num
					end
				end
			else
				for i in first..last
					for v in 0..9
						num=(i.to_s + v.to_s + i.to_s.reverse).to_i
						if num >= min && num <= max
							yield num
						end
					end
				end
			end
		end
	end
	def is_palindromes? num 
		# 回分か
		s = num.to_s
		#print  "check" + s + ": "
		for i in 0...(s.length/2)
			#print "["+s[i] + ","+s[-i-1]+"]"
			if s[i] != s[-i-1]
				#print "\n"
				return false
			end
		end
		#print "\n"
		return true
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

#!/usr/bin/env ruby -Ku
# Usage: cat problems | a.rb
class GTrans
	def initialize
		@alphabets = "abcdefghijklmnopqrstuvwxyz"
		@chars = {}
		remap!({"y"=>"a","e"=>"o","q"=>"z"})
	end
	def remap! (chars)
		@chars.merge! chars
		guess!
	end
	def guess!
		if @chars.length != @alphabets.length - 1
			# cannot guess!
			return
		end
		target_char = ""
		@alphabets.chars do |c|
			if !@chars[c]
				target_char = c
				break
			end
		end
		availables = {}
		@alphabets.chars do |c|
			availables[c] = 0;
		end
		@chars.values.each do |c|
			availables.delete(c)
		end
		#print availables.keys.join+"\n"
		#print target_char," = ",availables.keys[0],"\n"
		@chars[target_char] = availables.keys[0]
	end
	def sample(source, result)
		i = 0
		map = {}
		while i < source.length
			if source[i,1] != " "
				map[source[i,1]] =result[i,1]
			end
			i+=1
		end
		remap! map
	end
	def translate (str)
		s=""
		str.strip.each_char do |i|
			if i == " "
				s+=" "
				next
			elsif @chars[i] 
				s += @chars[i]
			else
				print "unknown input: "+i+"\n"
				exit
			end
		end
		return s
	end
	def printmap
		@chars.sort.each do |i,v|
			print i + "->"+v+"\n"
		end
	end
end

trans = GTrans.new
samples = [
	"ejp mysljylc kd kxveddknmc re jsicpdrysi",
	"rbcpc ypc rtcsra dkh wyfrepkym veddknkmkrkcd",
	"de kr kd eoya kw aej tysr re ujdr lkgc jv"
]
sample_results = [
	"our language is impossible to understand",
	"there are twenty six factorial possibilities",
	"so it is okay if you want to just give up"

]
i = 0
while i < samples.length
	trans.sample samples[i], sample_results[i]
	i+=1
end
#print trans.translate("y qee"),"\n"
#trans.printmap;exit
number = ARGF.gets
i = 0
while line = ARGF.gets
	line.strip!
	if line == ""
		next
	end
	i+=1
	print "Case #",i,": ", trans.translate(line),"\n"
end

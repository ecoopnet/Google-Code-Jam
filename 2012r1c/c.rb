#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb
class KeyValue
	attr_reader :key
	attr_accessor :value
	def initialize (k,v)
		@key = k
		@value = v
	end
	def to_s
		return "["+@key.to_s+":"+@value.to_s+"]"
	end
end
class Solver
	def solve lines
		line = lines.shift
		items = line.split(" ")
		@N = items.shift.to_i
		@M = items.shift.to_i
		# As = 2*@N
		line = lines.shift
		items = line.split(" ")
		@boxes = []
		for i in 0...items.length
			t = items[i].to_i
			if i % 2 == 0
				value = t
			else
				key = t
				@boxes.push KeyValue.new(key,value)
			end
		end
		# Bs = 2*@M
		line = lines.shift
		items = line.split(" ")
		@toys = []
		for i in 0...items.length
			t = items[i].to_i
			if i % 2 == 0
				value = t
			else
				key = t
				@toys.push KeyValue.new(key,value)
			end
		end
		boxes_sum = {}
		@boxes.each { |o|
			boxes_sum[o.key] = 0 if boxes_sum[o.key] == nil
			boxes_sum[o.key]+= o.value
	       	}
		toys_sum = {}
		@toys.each { |o|
			toys_sum[o.key] = 0 if toys_sum[o.key] == nil
			toys_sum[o.key]+= o.value
	       	}
		mixed_sum = {}
		(boxes_sum.keys + toys_sum.keys).uniq.each {|k|
			a= boxes_sum[k]
		       b = toys_sum[k]
		       if a == nil || b == nil
			mixed_sum[k] = nil
		       elsif a>b
			mixed_sum[k] = b
		       else 
			       mixed_sum[k]= a
		       end
		}
		mixed_sum.delete_if {|k,v| v==nil}
		mixed_sum = mixed_sum.sort_by {|k,v| -v }
		p "mixed:",mixed_sum
		p "boxes:"
		p boxes_sum
		@boxes.each {|o| p o.to_s; }
		p "toys:"
		p toys_sum
		@toys.each {|o| p o.to_s; }
		return ""
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

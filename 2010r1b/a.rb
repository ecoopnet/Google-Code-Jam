#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb [-v]
require "pp"
require 'optparse'

class Node
	attr_reader :parent
	attr_accessor :children
	def initialize parent
		@parent = parent
		if parent != nil
			parent.children.push self
		end
		@children = []
	end
end
class Solver
	@debug = false
	def solve lines
		line = lines.shift
		items = line.split(" ")
		@n = items.shift.to_i
		@m = items.shift.to_i
		@tree = {}
		for i in 0 ... @n
			line = lines.shift
			current = @tree
			line.split("/").each { |o|
				if o == ""
					# root
					next
				end
				if current[o] != nil
					current = current[o]
					next
				end
				# node = Node.new current
				current[o] = {}
				current = current[o]
				next
			}
		end
		res = 0
		pplog @tree 
		for i in 0 ... @m
			line = lines.shift
			current = @tree
			line.split("/").each { |o|
				if o == ""
					# root
					next
				end
				if current[o] == nil
					res = res + 1
					logln "[",line,"] mkdir ",o
					current[o] = {}
				end
				current = current[o]
			}
		end
		return res;
	end 
	def debug!
		@debug = true
	end

	# -v オプション付与時のみ出力するログ(改行なし)
	def log *args
		print args.join() if @debug
	end
	# -v オプション付与時のみ出力するログ(改行付き)
	def logln *args
		print args.join(),"\n" if @debug
	end
	# -v オプション付与時のみppで出力するログ
	def pplog *args
		pp *args if @debug
	end
end

solver = Solver.new

opt = OptionParser.new
opt.on('-v') {|v| solver.debug! }
opt.parse!(ARGV)

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

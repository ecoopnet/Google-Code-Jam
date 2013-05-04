#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb [-v]
require "pp"
require 'optparse'

class Solver
	@debug = false
	def solve line
		items = line.split(" ")
		# todo implement
		return "";
	end

	# デバッグフラグ有効化
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

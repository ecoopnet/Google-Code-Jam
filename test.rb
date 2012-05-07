#!/usr/bin/env ruby -Ku
## Usage: this.rb solver.rb sample.txt expected.txt
#
p ARGV
cmd = ARGV.shift
input = ARGV.shift
expected = ARGV.shift
res = open "|" + cmd + " " + input

lines_in = []
while !res.eof
	lines_in.push res.gets
end
res.close
res = open expected
lines_exp = []
while !res.eof
	lines_exp.push res.gets
end
res.close
if lines_in == lines_exp 
	print "OK\n"
	exit
end

#t = lines_in - lines_exp
m = lines_in.length
m = lines_exp.length if m < lines_exp.length
for i in 0...m
	a = lines_in[i]
	b = lines_exp[i]
	if a != b
		print "- " + a if a
		print "+ " + b if b
	end
end

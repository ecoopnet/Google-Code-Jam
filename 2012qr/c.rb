#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb
require "date"
class Solver
	def solve line
		items = line.split " "
		@min = items.shift.to_i
		@max = items.shift.to_i
		@digits = @min.to_s.length
		@pows = []
		for t in 0..(@digits+2)
			@pows[t] = 10**t
		end

		i = @min
		o=[]
		result = 0

		while i <= @max
			#	if i % 10000 == 0
			#		print ">>",DateTime.now,": ",i,"\n"
			#	end
			t = i % pow(@digits) / pow(@digits-1)
			#t = i % (10 ** @digits) / (10 ** (@digits - 1))
			begin
				d=0
				valid=true
				while d < @digits
					fig = pow d
					#fig = 10**d
					n = (i % (fig * 10)) / fig
					if n != 0 && n < t
						#print "aa",i,":",n,"<",t,"\n"
						vaid=false
						break
					end
					d+=1
				end
				if !valid
					next
				end
				result += shiftCount i,i
			ensure	
				i+=1
			end
		end
		#if o.length != 0
			#print (o.keys.join ","), "\n"
		#end
		return result.to_s;
	end
	def shiftCount(istart,i=nil,n=0, depth = 0,buf={})
		if n + depth >= @digits 
			return 0 
		end
		#print "["
		#if i == nil
		#	i = istart
		#end
		# shift
		count=0
		d = pow(depth + 1)
		#d = 10 ** (depth + 1)
		i2 = (i % d) * pow(@digits-1-depth) + (i / d)
		#i2 = (i % d) * (10 ** (@digits-1-depth)) + (i / d)
		#print i,",",i2,"(n=",n,",r=",results.length,",d=",depth,")"
		if @min <= i && i<i2 && @min <= i2 && i2 <= @max && buf[i.to_s+"-"+i2.to_s]==nil
			buf[i.to_s+"-"+i2.to_s] = 0
			count+=1
			#print "[",istart,"]",i,"-",i2,"(n=",n,",depth=",depth,")\n"
	#		print "!"
		end
	#		print "\n"
		d2 = 0
		n2=n+1
		#print "w"
		while n + d2 < @digits - 1
			#print "."
			#print i,",",i2,"n=",n,":depth=",depth,"/d2=",d2,"\n"
			d2+=1
			count += shiftCount istart,i, n2, d2,buf
		end
			#print ";\n"
		return count #+(shiftCount istart,i2,n2)
	end

	def pow (n)
		return @pows[n]
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
	$stdout.flush
end

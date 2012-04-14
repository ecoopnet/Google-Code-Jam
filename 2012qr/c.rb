#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb

class Solver
	def solve line
		items = line.split " "
		@min = items.shift.to_i
		@max = items.shift.to_i
		@digits = @min.to_s.length
		i = @min
		o=[]
		result = 0
		while i <= @max
			t = i % (10 ** @digits) / (10 ** (@digits - 1))
			#print t,"-",(10**(@digits)),":"
			begin
				d=0
				valid=true
				while d < @digits
					fig = 10**d
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
				result += shiftCount i
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
		#if i == istart
		#	return 0
		#end
		if i == nil
			i = istart
		end
		# shift
		count=0
		d = 10 ** (depth + 1)
		i2 = (i % d) * (10 ** (@digits-1-depth)) + (i / d)
		#print i,",",i2,"(n=",n,",r=",results.length,",d=",depth,")"
		if @min <= i && i<i2 && @min <= i2 && i2 <= @max && buf[i.to_s+"-"+i2.to_s]==nil
			buf[i.to_s+"-"+i2.to_s] = 0
			count+=1
			#print "[",istart,"]",i,"-",i2,"(n=",n,",depth=",depth,")\n"
	#		print "!"
		end
	#		print "\n"
		n2 = n + 1
		d2 = 0
		#print "w"
		while n + d2 < @digits 
			#print "."
			#print i,",",i2,"n=",n,":depth=",depth,"/d2=",d2,"\n"
			d2+=1
			count += shiftCount istart,i, n+1, d2,buf
		end
			#print ";\n"
		return count #+(shiftCount istart,i2,n2)
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

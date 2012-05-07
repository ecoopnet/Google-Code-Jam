#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb
# ダイヤモンド継承(3ルートから同じ親にたどり着く)を探す
# X -> Y に継承するなら Y -> X への継承はない
# 自身には継承しない
class Leaf
	attr_reader :number,:children, :parents
	def initialize (n)
		@number = n
		@children = []
		@parents = []
	end 
	def setParents (parents)
		@parents = parents
	end
	def to_s
		s = "n=" +  @number.to_s +  ", parents=["
		for l in @parents
			s+=l.number.to_s + ","
		end
		s+="]"
		return s
		#print "n=", @number, ", children=", @children, ", parents=",@parents
	end 
	def addChild c
		@children.push c
	end
	def rootParent
		if @parents.length == 0
			return self
		end
		return @parents[0].rootParent
	end
	def rootParents
		if @parents.length == 0
			return [self]
		end
		res = []
		for p in @parents 
			t = p.rootParents
			res += t
			res.uniq!	
			# stop calc!?
			return res
		end
		return res
	end
	def rootChild
		if @children.length == 0
			return self
		end
		return @children[0].rootChild
	end
	def getPathsTo root
		if self == root 
			return [[self]]
		end
		path = [self]
		paths = []
		for p in @parents
		#	print @number,": ", p.number," == ", root.number,"\n"
			begin
			t = p.getPathsTo root 
			rescue 
				next
			end
			if t != nil 
				for pp in t
					if @parents.length == 1
						paths.push(pp) # shorten!
					else
						paths.push(path + pp)
					end
					#stop calc!
					if paths.length >= 2
						paths.sort!
						return paths
					end
					#paths.push(path + pp)
				end
			end
		end
		if paths.length == 0
			return nil
		end
		paths.sort!
		return paths
	end
	def  <=> (b)
		return b.number - @number
	end
end
class Solver
	def printLeaves leaves
		a = []
		for l in leaves
			next if l == nil
			a.push l.number
		end
		print(a.join(" "), "\n")
	end

	def solve lines
		line = lines.shift
		@N = line.to_i
		tree = []
		tree.push nil
		for i in 0...@N
			leaf = Leaf.new(i+1)
			tree.push leaf
		end
		for i in 0...@N
			line = lines.shift
			items = line.split(" ")
			n = items.shift.to_i
			parents = []
			items.each {|p| parents.push tree[p.to_i] }
			tree[i + 1].setParents parents
			parents.each{|p| 
				tree[p.number].addChild tree[i+1]
			}
		end

#		for i in 1..@N
#			p tree[i].to_s
#		end
		#printLeaves tree
		parents = []
		for p in tree
			next if p == nil
			parents.push p if p.children.length > 0 && p.parents.length == 0
		end
		for i in 1...tree.length
			next if tree[i].children.length >= 1
			#parents =  tree[i].rootParents
			for p in parents
				paths = tree[i].getPathsTo p
				if paths !=nil && paths.length >= 2
					return "Yes"
					#for p in paths
					#	printLeaves p
					#			for i in 0...paths.length
					#				for j in j...paths.length
					#					if paths[i] == paths[j]
					#						return "Yes"
					#					end
					#					p1 = paths[i]
					#					p2 = paths[j]
					#					if p1.last 
					#				end
					#			end
				end
			end
		end
		#p tree[1].rootParents
		return "No";
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

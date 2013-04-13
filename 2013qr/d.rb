#!/usr/bin/env ruby -Ku
# Usage: cat problems | program.rb
require "pp"
# 
class Solver
	def solve lines
		STDERR.puts("-------\n")
		line = lines.shift
		items = line.split(" ")
		@K = items.shift.to_i
		@N = items.shift.to_i
		# keys
		keys = [0]
		max_key = 0

		line = lines.shift
		items = line.split(" ")
		items.each { |s|
			i = s.to_i
			keys[0]+=1 # 総数
			if keys[i]
				keys[i] += 1
			else
				keys[i] = 1
			end
			if max_key < i
				max_key = i
			end
		}
		# chests
		chests = [nil]
		@chests_map_content = {}
		@chests_map_required = {}
		for i in 1..@N
			line = lines.shift
			items = line.split(" ")
			n = items.shift.to_i
			items.shift # content length
			contents = []
			items.each { |c| 
				ci = c.to_i
				contents.push ci
				if !@chests_map_content[ci] 
					@chests_map_content[ci] = {}
					@chests_map_content[ci][i] = 1
				elsif !@chests_map_content[ci][i]
					@chests_map_content[ci][i] = 1
				else
					@chests_map_content[ci][i] += 1
				end
			}
			if !@chests_map_required[n]
				@chests_map_required[n] = {}
				@chests_map_required[n][i] = 1
			elsif !@chests_map_required[n][i]
				@chests_map_required[n][i] = 1
			else
				@chests_map_required[n][i] += 1
			end
			contents.each{|t|
				if max_key < t 
					max_key=t
				end
			}
			chests.push({:key=>n, :content=>contents})
		end

		for t in 0..max_key
				if !keys[t]
					keys[t] = 0
				end
				if !@chests_map_required[t]
					@chests_map_required[t] = {}
				end
				if !@chests_map_content[t]
					@chests_map_content[t] = {}
				end


		end

		STDERR.print "keys", keys.join(" "), "chests\n",chests.map { |e|
			if e == nil
				"nil"
			else
				"k="+(e[:key].to_s)+", {"+e[:content].join(" ")+"},\n" 
			end
}
		#pp "keys", keys, "chests",chests
		# 鍵がない箱は最後にもってくる
		# 複数のルートでクリアできるなら辞書順最小
		@keys = deep_copy(keys)
		@chests = deep_copy(chests)
		rest_chests = (1..@N).to_a

		res = open_chest nil, keys, rest_chests
		if res
			return res.join(" ")
		end
		return "IMPOSSIBLE"
	end
	def deep_copy arr
		return Marshal.load(Marshal.dump(arr))
	end

	def open_chest index, keys, rest_chests
		if rest_chests.length == 0
			return [index]
		end
		if keys[0] == 0
			# failure
			return nil
		end
		# 詰んでるかチェック
		if !is_continuable(keys, rest_chests)
			return nil
		end
		# 順番にあけてみる
		opened = []
		i = 1
		while i <=@N
			# 重要なのから
			if !rest_chests.include?(i)|| opened.include?(i) || !is_important(i,keys,rest_chests) 
				i+=1
				next
			end
			opened.push i
			res = try_opening i, keys,rest_chests
			if res
				if index != nil
					return res.insert(0, index)
				else
					return res
				end
			end
			i = 1
		end

		for i in 1..@N
			if !rest_chests.include?(i) || opened.include?(i)
				next
			end
			res = try_opening i, keys,rest_chests
			if res
				if index != nil
					return res.insert(0, index)
				else
					return res
				end
			end
		end
		# あけられるものがない
		return nil
	end
	def try_opening i, keys, rest_chests
		if !can_open(@chests[i], keys)
			return nil
		end
		rest_chests.delete i
		use_key(@chests[i],keys)
		STDERR.print "[",keys.join(" "),"] open ",i, "[",rest_chests.join(" "),"]\n";
		res = open_chest i, keys, rest_chests
		if res 
			return res
		end
		# だめだった
		rest_chests.push(i)
		STDERR.print "back ",i,"(rest=",rest_chests.join(" "),")","\n";
		rollback_key @chests[i],keys
		return nil
	end
	def is_continuable keys, rest_chests
		for k in 1...(keys.length)
			extra = count_extra_key_without_required k, keys, rest_chests
			if extra < 0
				#pp keys, rest_chests, @chests
				STDERR.puts "missing key",k,"(extr:",extra,")"
				return false
			end
		end
		return true
	end
	def count_extra_key_without_required k, keys, rest_chests
		required=0
		for i in @chests_map_required[k].keys
			if rest_chests.include?(i)
				required+= @chests_map_required[k][i]
			end
		end
		rest = keys[k]
		#pp @chests_map_content, k, @chests

		for i in @chests_map_content[k].keys
			if rest_chests.include?(i)
				rest += @chests_map_content[k][i]
			end
		end
		#STDERR.print "(rest:"+rest.to_s+",req:"+required.to_s+") "
		return rest - required
	end
	def is_important index, keys, rest_chests
		chest = @chests[index]
		if chest[:content].include?(chest[:key]) && (count_extra_key_without_required(chest[:key], keys, rest_chests) == 0)
			#pp "important:"+index.to_s, chest[:key], keys, rest_chests, chest
			# 余裕がないキーで開け、同じキーが手に入るものは先に開けておく
			return true

		end
		return false
	end
	def can_open chest, keys
		#pp "ch:",chest[:key]
		#pp "k:",keys
		return (keys[chest[:key]] && keys[chest[:key]] > 0)
	end
	def use_key chest, keys
		keys[0]-=1
		keys[chest[:key]]-=1
		for i in chest[:content]
			STDERR.print "+k",i
			keys[0]+=1
			if !keys[i]
				keys[i] = 1
			else
				keys[i]+=1
			end
		end
	end
	def rollback_key chest, keys
		keys[0]+=1
		keys[chest[:key]]+=1
		for i in chest[:content]
			STDERR.print "-k",i
			keys[0]-=1
			keys[i]-=1
		end
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
	print "Case #",i,": ", Solver.new.solve(lines),"\n"
end

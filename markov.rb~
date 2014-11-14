require 'sqlite3'


class MarkovGenerator
	def initialize(corpus = "names.db",deepness = 2, unique = false )
		Random.new_seed 
		@unique = unique
		corpus = "names.db"
		puts "file not found!" if not File.exist?(corpus)
		db = SQLite3::Database.new corpus
		stm = db.prepare "SELECT Names.Value FROM Names JOIN Orign ON Names.Value = Orign.Value WHERE Pays LIKE '%greek%' AND Female <= 0 AND Male > 0"
		rs = stm.execute
		@names = []
		rs.each do |row|
			@names.push("^"+row[0].to_s+"$")
		end
		@nuplet = []
		for i in 1..deepness
			@nuplet.push(nupletGenerator(i))
		end
	end

	def nupletGenerator(n)
		uplet = {}
		@names.each do |name|
			for i in 0..(name.length-(n+1))
				tr =""
				for j in i..(i+n-1)
					tr+=name[j]
				end
				if not uplet.include?(tr)
					uplet.merge!({tr => {}})
				end
				if not uplet[tr].include?(name[i+(n)])
					uplet[tr].merge!({name[i+(n)] => 1})
				else
					uplet[tr][name[i+(n)]] = uplet[tr][name[i+(n)]]+1
				end
			end
		end
		return uplet
	end

	def nextNuplet(state,deepness)
		sommeTotal = 0
		sommePartielle = 0
		if @nuplet[deepness][state].nil? then
			puts "Rien a faire..."
			return "$"
		end
		@nuplet[deepness][state].each_value {|value| sommeTotal+=value }
		nextState = Random.rand(sommeTotal)
		@nuplet[deepness][state].each do |key,value|
			sommePartielle+=value
			if sommePartielle >= nextState then
				return key
			end
		end
	end

	def generateNewWord()
		word = "^"
		for i in 0..@nuplet.length-1
			word+=nextNuplet(word,i)
			if word.include?("$") then
				return word[1..word.length-2]
			end
		end
		begin
			word+=nextNuplet(word[word.length-@nuplet.length..word.length-1],@nuplet.length-1)
		end until word.include?("$")
		return word[1..word.length-2]
	end

	def unique?(word)
		t = @names.include?("^"+word+"$")
		return (not t)
	end
end

mg = MarkovGenerator.new
for i in 0..10
	w = mg.generateNewWord

	print w.capitalize + " \t : "
	puts "unique" if mg.unique?(w)
	puts "existe" if not mg.unique?(w)
end
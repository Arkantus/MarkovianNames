#encoding: utf-8
require 'sqlite3'

class DatabaseManager
	@db = 0
	def initialize(file = "names.db")
		@db = SQLite3::Database.new file
	end

	def createFromList(lst)
		begin
			@db.execute "CREATE TABLE IF NOT EXISTS Names(Value TEXT PRIMARY KEY, Female INTEGER, Male INTEGER, Freq REAL)"
			@db.execute "CREATE TABLE IF NOT EXISTS Orign(Value TEXT, Pays TEXT)"
			corpus = File.open(lst, 'r')
			lang = []
			corpus.each do |line|
				words = line.split("\t".encode'utf-8')
				lg = words[2].split(",".encode"utf-8")
				value = {:nom => words [0], :female => "f" <=> words[1], :male => "m" <=> words[1], :fq => words[3]}
				lg.each do |l| 
					c = {:nom => words[0], :origin => l.strip}
					@db.execute "INSERT INTO Orign VALUES(:nom,:origin)",c
				end
				@db.execute "INSERT INTO Names VALUES(:nom,:female,:male,:fq)", value
			end
		rescue SQLite3::Exception => e
			puts e
		end
	end

	def getCountryList()
		@db = SQLite3::Database.open "names.db"
		stm = @db.prepare "SELECT Pays FROM Orign GROUP BY Pays"
		rt = stm.execute
		rt.each {|country| puts country[0].to_s}
	end
end

t = DatabaseManager.new
#t.createFromList("Prenomss.txt")
t.getCountryList

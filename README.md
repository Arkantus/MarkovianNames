#Markovian Name Generator

name database : http://www.lexique.org/public/Prenoms100.zip

Ruby class to generate name based on markovian processes, n-gram size is selectable


##Dependencies :
* sqlite3
* colorize

( > sudo gem install sqlite3)

##Usage

* \> irb
 * \> require './markov.rb'

 Or
* \> irb -I . -r markov.rb

Then

* m = MarkovGenerator.new
* m.generateNewWord

##Complements

For now to change name's origon you have to modify the sql request inside the initiliaze method of MarkovGenerator.
You can use databaseGenerator's getContryList to obtain the usable origins

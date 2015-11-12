# Mastermind

An implementation of the MasterMind game. See http://https://en.wikipedia.org/wiki/Mastermind for details.

## Installation

Download files as zip here - https://github.com/andela-toduah/tobi-mastermind/archive/master.zip
Then unzip all files to same directory.
Once unzipped, change directory into the tobi-mastermind-master folder

    $ cd tobi-mastermind-master

Then run 

    $ rake install

After installation is completed, run 

    $ mastermind 

to start game.

## Usage

Once game starts, a random code is generated and you're asked to guess what the code is.
Every code is a four/five/six digit word made up by the letters [r, g, b, y]/[r, g, b, y, o]/[r, g, b, y, o, v] 
depending on difficulty levels beginner/intermediate/advanced levels. You have twelve guesses per game.
On every guess, you are presented with a message identifying the number of elements you got correctly, and in what positions.
To view entry history, enter h or history at any time
To view sequence generated, enter c or cheat at any time
To quit the game at any point enter q or quit.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tobi-mastermind. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


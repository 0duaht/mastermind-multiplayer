# Mastermind
[![Build Status](https://semaphoreci.com/api/v1/projects/ef8e6334-3304-466e-99f5-b97fd2d3fc7c/603618/badge.svg)](https://semaphoreci.com/tobi-oduah/tobi-mastermind-2)
[![Code Climate](https://codeclimate.com/repos/564635d51787d724da000013/badges/ff2bde449c8b59444530/gpa.svg)](https://codeclimate.com/repos/564635d51787d724da000013/feed)
<a href="https://codeclimate.com/repos/564635d51787d724da000013/coverage"><img src="https://codeclimate.com/repos/564635d51787d724da000013/badges/ff2bde449c8b59444530/coverage.svg" /></a>

An implementation of the classic MasterMind game in Ruby.
See http://https://en.wikipedia.org/wiki/Mastermind for details.

## Installation

Run

    $ gem install tobi-mastermind

After installation is completed, run 

    $ mastermind 

to start game.

## Usage

Once game starts, a random code is generated and you're asked to guess what the code is.

Every code is a four/five/six digit word made up by the letters [r, g, b, y]/[r, g, b, y, o]/[r, g, b, y, o, v] 
depending on difficulty levels beginner/intermediate/advanced levels. 

You have twelve guesses per game.

On every guess, you are presented with a message identifying the number of elements you got correctly, and in what positions.

To view entry history, enter h or history at any time.
To view sequence generated, enter c or cheat at any time
To quit the game at any point enter q or quit.

On guessing successfully, you're presented with an analysis of your performance, along with statistics for top scores.

##  Development

After checking out the repo, run mastermind for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run bundle exec rake install. To release a new version, update the version number in the GemSpec file, and then run bundle exec rake release to create a git tag for the version, push git commits and tags, and push the .gem file to rubygems.org.


## Contributing

1. Fork it by visiting - https://github.com/andela-toduah/tobi-mastermind/fork

2. Create your feature branch

        $ git checkout -b new_feature
    
3. Contribute to code

4. Commit changes made

        $ git commit -a -m 'descriptive_message_about_change'
    
5. Push to branch created

        $ git push origin new_feature
    
6. Then, create a new Pull Request

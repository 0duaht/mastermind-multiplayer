# Tobi::Mastermind

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/`. To experiment with that code, run `bin/console` for an interactive prompt.

An implementation of the MasterMind game. See http://https://en.wikipedia.org/wiki/Mastermind for details.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tobi-mastermind'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tobi-mastermind

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


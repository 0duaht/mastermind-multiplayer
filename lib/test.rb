require_relative 'player'
require 'yaml'

top_ten_list = YAML.load_stream(File.open('store.yaml')).sort{|player1, player2|
  by_guess = player2.guesses <=> player1.guesses
  if by_guess == 0
    player1.time <=> player2.time
  else
    by_guess
  end
}[0..10]  if File.file?('store.yaml')

puts top_ten_list
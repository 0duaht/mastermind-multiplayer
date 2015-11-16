require 'ui'
require 'gamehelper'
module MasterMind
  module Tobi
    class GameMethods
      def average_string(top_ten_list, current_player)                                    # generates user's performance compared to average
        time_diff, guess_diff = difference(top_ten_list, current_player)
        
        "That's %s %s and %s %s %s the average\n" % [time_convert(time_diff.abs), time_diff < 0 ? "slower" : "faster",
          guess_diff.abs, guess_diff.abs == 1 ? "guess" : "guesses", guess_diff < 0 ? "more" : "fewer"]
      end
      
      def difference(top_ten_list, current_player)
        total_time = 0
        total_guess = 0
        
        diff_hash = top_ten_list.each do |player| 
          total_time += player.time
          total_guess += player.guesses 
        end
        
        average_time = (total_time.to_f/top_ten_list.length).round - current_player.time
        average_guess = (total_guess.to_f/top_ten_list.length).round - current_player.guesses
        
        return average_time, average_guess
      end
      
      def print_top_ten(current_player)
        top_ten_list = get_top_ten
        
        puts average_string(top_ten_list, current_player) if top_ten_list.length > 1     # print out user's performance compared to average
        
        # print out top ten results
        if !top_ten_list.nil?
          puts ""
          puts UI::TOP_TEN                                                                  
          top_ten_list.each_with_index{ |player, index| puts "#{index+1}. " + player.to_s }
        end
      end
      
      def get_top_ten
        YAML.load_stream(File.open(UI::DB_STORE)).sort do |player1, player2|  # load player objects from db and sort by guesses/time
          by_guess = player1.guesses <=> player2.guesses                                  # first sort by guesses
          by_guess == 0 ? player1.time <=> player2.time : by_guess                        # then sort by time
        end[0...10]  if File.file?(UI::DB_STORE)                                            # pick out top ten
      end
      
      def store_game(sequence, guesses, time)      #get player name and store details to file  
        print UI::NAME_MESSAGE
        name = get_name
        current_player = Player.new(name, sequence, time, guesses)  # create new player object
        
        # write player object to file if file does not exist, or verify whether to add record from user, and write if it exists
        File.open(UI::DB_STORE, 'a'){ |file| file.write(YAML.dump(current_player)) } if user_permits_store?
         
        current_player
      end
      
      def user_permits_store?                    # confirm from user to add record to top-scores if file exists
        return true if !File.exist?(UI::DB_STORE)    # if file does not exist, return true
        print UI::OVERWRITE_MESSAGE
        print UI::INPUT_PROMPT
        option_chosen = false
        
        return yes_or_no?
      end
      
      def yes_or_no?
        option_chosen = false
        
        while !option_chosen
          option_chosen = true                              # assume user selects valid option so as to quit loop
          
          input = gets.chomp.downcase
          case input                                        
          when "y", "yes" then return true
          when "n", "no" then return false
          else                                               # user selects an invalid option
            print UI::INVALID_MESSAGE
            option_chosen = false
          end  
        end
      end
      
      def get_name
        name = ""
        
        while name.eql?("")
          name = gets.chomp.capitalize
          print UI::INVALID_MESSAGE if name.eql?("")  
        end
        
        name
      end
         
      def print_history(history)
        if history.empty?
          print "No history yet. Enter a guess"  + UI::INPUT_PROMPT
        else
          puts ""
          puts history
          print UI::INPUT_PROMPT 
        end
      end
    end
  end
end
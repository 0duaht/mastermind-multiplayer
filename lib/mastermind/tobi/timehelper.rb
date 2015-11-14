module MasterMind
  module Tobi
    module TimeHelper
      SINGULAR = [' hour', ' minute', ' second']
      PLURAL = [' hours', ' minutes', ' seconds']
      def time_convert(time_int)
        hours = time_int / 3600
        minutes = (time_int % 3600) / 60
        seconds = (time_int % 3600) % 60
        time_string = construct_string(hours, minutes, seconds)
      end
      
      def construct_string(hours, minutes, seconds)
        time_string = ''
        time_string = hour_minute_helper(hours, minutes, time_string, 0)
        time_string = hour_minute_helper(minutes, seconds, time_string, 1)
        time_string = second_helper(seconds, time_string)
        time_string
      end
      
      def hour_minute_helper(greater, lesser, time_string, position)
        if greater >= 1
          time_string << (greater.to_s + (greater == 1 ? SINGULAR[position] : PLURAL[position]))
          time_string << ', ' if lesser > 0
        end
        time_string
      end
      
      def second_helper(seconds, time_string)
        if seconds >= 1
          time_string << (seconds.to_s + (seconds == 1 ? ' second' : ' seconds'))
        elsif seconds == 0 && time_string == ''
          time_string << '0 seconds'
        end
        time_string
      end
    end
  end
end
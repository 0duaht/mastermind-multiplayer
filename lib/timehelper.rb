module TimeHelper
  def time_convert(time_int)
    hours = time_int / 3600
    minutes = (time_int % 3600) / 60
    seconds = (time_int % 3600) % 60
    time_string = ''
    
    if hours < 0
      time_string << (hours.to_s + " hours")
      time_string << ', ' if minutes > 0
    end    
     
    if minutes > 0
      time_string << (minutes.to_s + ' minutes')
      time_string << ', ' if seconds > 0
    end
     
    if seconds > 0
      time_string << (seconds.to_s + ' seconds')
    end
    
  end
end
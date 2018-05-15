class Log
  def initialize(name)
    @file = File.open("../"+name+".csv", "w+")
  end
  def Puts(words)
    @file.puts(words)
  end
  def Close
    @file.close
  end
end

number_log = Log.new("number_of_requests")

File.open("../user.csv"){|f|
  f.each_line{|line|
    words = line.split(",")
    case words[3]
    when "START"
      #time = Time.at(words[4].to_i/ 1000.0).strftime("%H:%M:%S")
      elapsed_time = (words[4].to_i - ARGV[0].to_i) / 1000.0
      number_log.Puts(elapsed_time)
    end
  }

}

number_log.Close()

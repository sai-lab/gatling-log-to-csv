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

active_log = Log.new("number_of_active_users")

active_users = 0
File.open("../user.csv"){|f|
  f.each_line{|line|
    words = line.split(",")
    case words[3]
    when "START"
      elapsed_time = (words[4].to_i - ARGV[0].to_i) / 1000.0
      active_users = active_users + 1
      data = [elapsed_time, active_users]
      active_log.Puts(data.join(","))
    when "END"
      elapsed_time = (words[5].to_i - ARGV[0].to_i) / 1000.0
      active_users = active_users - 1
      data = [elapsed_time, active_users]
      active_log.Puts(data.join(","))
    end
  }
}

active_log.Close()

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

response_time_group_log = Log.new("response_time_group")
end_time = 0

File.open("../group.csv"){|f|
  f.each_line{|line|
    words = line.split(",")
    if words[0].match("GROUP") then
      end_time = words[2].to_i
    elsif words[0].match("USER") then
      start = (words[4].to_i - ARGV[0].to_i) / 1000.0
      time = (end_time - words[4].to_i) / 1000.0
      data = [start, time.to_s].join(",")
      response_time_group_log.Puts(data)
    end
  }
}

response_time_group_log.Close()

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

response_time_ok_log = Log.new("response_time_ok")
response_time_ko_log = Log.new("response_time_ko")

File.open("../request.csv"){|f|
  f.each_line{|line|
    words = line.split(",")
    start = (words[5].to_i - ARGV[0].to_i) / 1000.0
    time = (words[6].to_i - words[5].to_i) / 1000.0
    data = [start, time.to_s].join(",")
    case words[7]
    when "OK"
      response_time_ok_log.Puts(data)
    when "KO"
      response_time_ko_log.Puts(data)
    end
  }
}

response_time_ok_log.Close()
response_time_ko_log.Close()

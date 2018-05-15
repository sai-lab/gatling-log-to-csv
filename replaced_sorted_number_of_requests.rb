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

number_log = Log.new("replaced_sorted_number_of_requests")

File.open("../sorted_number_of_requests.csv"){|f|
  f.each_line{|line|
    words = line.split(" ")
    for i in 0..10
      if words[i] != ""
        break
      end
    end
    replaced_words = [words[i+1], words[i]]
    number_log.Puts(replaced_words.join(","))
  }
}

number_log.Close()

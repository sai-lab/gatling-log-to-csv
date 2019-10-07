# ruby client_merge.rb 結果が入ったディレクトリ名 クライアント1の総リクエスト数 クライアント2の総リクエスト数 ...
# 各クライアントの総リクエスト数はgatlingのhtmlなどから持ってきて下さい
# simulation.logのtail -1でも取れるかも

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

accesses = []
arg_index = 0
ARGV.each do |arg|
  if arg_index == 0
    arg_index = arg_index + 1
    next
  end
  accesses.push(arg.to_i)
  arg_index = arg_index + 1
end

# リクエスト番号の競合を避けるためにクライアント2以降のリクエスト番号を
# クライアント1からのリクエスト番号に合わせる
(1..arg_index-2).each{|j|
  accesses[j] = accesses[j] + accesses[j-1]
}

user_log = Log.new("user")
request_log = Log.new("request")
group_log = Log.new("group")

directories = `ls #{ARGV[0]}`
user_num = 0
index = 0
for dir in directories.split("\n")
  File.open(ARGV[0] + '/' + dir + "/simulation.log"){|f|
    p ARGV[0] + dir + "/simulation.log"
    f.each_line{|line|
      words = line.split("\t")
      if words[0] == "RUN"
        next
      end
      edited_words = words
      case edited_words[0]
      when "USER"
        # USERのログならuser.csvに追加
        if index > 0
          # クライアント2以降なら、これまでの総リクエスト数を加算
          if words[2] == ""
            p words
          end
          access_num = words[2].to_i + accesses[index - 1]
          edited_words[2] = access_num.to_s
        end
        user_num = edited_words[2].to_i
        user_log.Puts(edited_words.join(","))
      when "REQUEST"
        # REQUESTのログならrequest.csvに追加
        if index > 0
          # クライアント2以降なら、これまでの総リクエスト数を加算
          if words[2] == ""
            p words
          end
          access_num = words[2].to_i + accesses[index - 1]
          edited_words[2] = access_num.to_s
        end
        request_log.Puts(edited_words.join(","))
      when "GROUP"
        # GROUPのログならgroup.csvに追加
        group_log.Puts(edited_words.join(","))
      end
    }
  }
  index = index + 1
end

user_log.Close()
request_log.Close()
group_log.Close()

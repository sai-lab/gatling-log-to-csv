#!/bin/zsh
# 引数：各クライアントの結果を全て入れたディレクトリ名 クライアント1の総リクエスト数 クライアント2の総リクエスト数 ...

# user.csvとrequest.csvを生成
ruby client_merge.rb $@
# number_of_requests.csvを生成
ruby number_of_requests.rb
# 重複する時間を統合、集計
sort ../number_of_requests.csv | uniq -c > ../sorted_number_of_requests.csv
rm ../number_of_requests.csv
# 並び替え
ruby replaced_sorted_number_of_requests.rb
rm ../sorted_number_of_requests.csv
mv replaced_sorted_number_of_requests.csv number_of_requests.csv

#!/bin/zsh
# 引数：各クライアントの結果を全て入れたディレクトリ名 クライアント1の総リクエスト数 クライアント2の総リクエスト数 ...

# 開始時間をbench.csvに出力
dir=`ls $1 | head -1`
start=`head -1 $1/$dir/simulation.log | cut -f5`
echo $start > ../start_time.csv

# user.csvとrequest.csvを生成
echo "run client_merge.rb"
ruby client_merge.rb $@

# --- リクエスト数のcsvを生成 ----
# number_of_requests.csvを生成
echo "run number_of_requests.rb"
ruby number_of_requests.rb $start

# 重複する時間を統合、集計
sort -g ../number_of_requests.csv | uniq -c > ../sorted_number_of_requests.csv
rm ../number_of_requests.csv

# 並び替え
echo "run replaced_sorted_number_of_requests.rb"
ruby replaced_sorted_number_of_requests.rb
rm ../sorted_number_of_requests.csv
mv ../replaced_sorted_number_of_requests.csv ../number_of_requests.csv

# --- 応答時間のcsvを生成 ---
# 成功したリクエストの応答時間をresponse_time_ok.csvに
# 失敗したリクエストの応答時間をresponse_time_ko.csvに出力
echo "run response_time.rb"
ruby response_time.rb $start
sort -g ../response_time_ok.csv > ../sorted_response_time_ok.csv
sort -g ../response_time_ko.csv > ../sorted_response_time_ko.csv
rm ../response_time_ok.csv ../response_time_ko.csv
mv ../sorted_response_time_ok.csv ../response_time_ok.csv
mv ../sorted_response_time_ko.csv ../response_time_ko.csv

# --- アクティブユーザ数のcsvを生成 ---
echo "run number_of_active_users.rb"
ruby number_of_active_users.rb $start
sort -g ../number_of_active_users.csv > ../sorted_number_of_active_users.csv
rm ../number_of_active_users.csv
mv ../sorted_number_of_active_users.csv ../number_of_active_users.csv

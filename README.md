# gatling-log-to-csv
gatlingのlogからリクエスト数、応答時間、アクティブユーザ数のcsvを生成します。

# 準備

gatlingを実行したクライアントのログディレクトリをclient-requestsディレクトリに格納.  
client-requestsと同じ階層にgatling-log-to-csvをclone.
各クライアントの総リクエスト数をgatlingの結果などからメモ.

```
dir/
  gatling-log-to-csv/
  client-requests/
    gatling-result-01/
      simulation.log
      ...
    gatling-result-02/
      simulation.log
      ...
    ...
```

# 実行例

```
./log2csv.sh ../client-requests 399000 299000 199000
```

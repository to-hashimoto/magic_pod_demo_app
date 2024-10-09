#!/bin/bash -e
# (-eで、コマンドがエラーになった行で処理を終了させる)

# magicpod-apiクライアントの最新版を現在のディレクトリにダウンロード・解凍
# セキュリティのため、MAGICPOD_API_TOKENはCircleCIの環境変数で設定
OS=mac 　# Windowsマシン上でのビルドの場合はwindows、Linuxはlinuxを指定
FILENAME=magicpod-api-client 　# 任意のファイル名
curl -L "https://app.magicpod.com/api/v1.0/magicpod-clients/api/${OS}/latest/" -H "Authorization: Token ${MAGICPOD_API_TOKEN}" --output ${FILENAME}.zip
unzip -fq ${FILENAME}.zip

# MagicPodで使う各種環境変数を設定
export MAGICPOD_ORGANIZATION=th_test
export MAGICPOD_PROJECT=mobile_demo_test

# app/ipa/apkファイルをMagicPodにアップロードして、FILE_NOを取得
FILE_NO=5 #$(./magicpod-api-client upload-app -a アプリファイルへのパス)

# 先ほどアップロードしたアプリと、設定番号の設定を使ってテスト一括実行
./magicpod-api-client batch-run -S 1 -s "{\"app_file_number\":\"${FILE_NO}\"}"

# テストが成功した場合はアップロードしたアプリは削除(任意)
if [ $? = 0 ]; then
  ./magicpod-api-client delete-app -a ${FILE_NO}
fi
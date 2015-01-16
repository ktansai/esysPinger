# EsysPinger
## 概要
tkb大学のesysの計算機室のPCに対してに対してPingを送るRubyスクリプトです。  

## インストール
### git clone
	$ git clone git@github.com:ktansai/esysPinger.git

### gem
	$ sudo gem install bundler
	$ bundle install --path=vendor/bundle

## 例
以下のスクリプトはexamplesディレクトリに含まれています。  

### simple.rb
単純に起動しているか否かを調べることができます。  

### judge_os.rb
起動しているOSまで判断したい場合、sshの公開鍵を設定し、StrictHostKeyCheckingをno とする必要があります。これは機室の席順に表示する例です。(esys生のみ利用可能です)  
これを使用する場合  

```ruby
ssh={
  username:"", # ユーザーネームを入れる
  opt:{
    password:"", # パスワードを入れる
    port:22
  }
}
```

judge_os.rb内の上記の箇所にユーザネームとパスワードを入れてください。  
  
  
This software is released under the MIT License, see LICENSE.txt.  
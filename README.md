# esysPinger
## 概要
tkb大学のesysの計算機室のPCに対してに対してPingを送るRubyスクリプトです。  

## インストール
### git clone
	git clone git@github.com:ktansai/esysPinger.git

### gem
以下のgemのインストールが必要です。
- net-ping
- net-ssh

## 例
以下のsampleスクリプトはsampleディレクトリに含まれています。
### 1.Simple use(on/off)
```ruby
require "../lib/esysPinger.rb"
require "pp"

room = PCroom.new(2..91,timeout:5)
pp room.get_status # 全マシンのステータスを配列で取得
puts "on #{room.count(:on)}"
puts "off #{room.count(:off)}"
```

### 2.Judge OS (windows/linux/off)
起動しているOSまで判断したい場合、sshの公開鍵を設定し、StrictHostKeyCheckingをno とする必要があります。(esys生のみ利用可能です)  
```ruby
require "../lib/esysPinger.rb"
require "pp"

ssh={
	username:"ユーザーネーム",
	password:"パスワード", #sshの公開鍵を設定している場合は不要
	opt:{
		port:22
	}
}

room = PCroom.new(2..91,timeout:5,ssh:ssh)
pp room.get_status
puts "linux #{room.count(:linux)}"
puts "windows #{room.count(:windows)}"
puts "off #{room.count(:off)}"
```
This software is released under the MIT License, see LICENSE.txt.
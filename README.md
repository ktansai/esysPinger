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
### 1 simple.rb
単純に起動しているか否かを調べることができます。  

```ruby
require "../lib/esysPinger.rb"
require "pp"

room = PCroom.new(2..91,timeout:5)
pp room.get_status # 全マシンのステータスを配列で取得
puts "on #{room.count(:on)}"
puts "off #{room.count(:off)}"
```

### 2 judge_os.rb
起動しているOSまで判断したい場合、sshの公開鍵を設定し、StrictHostKeyCheckingをno とする必要があります。これは機室の席順に表示する例です。(esys生のみ利用可能です)  

```ruby
require "../lib/esysPinger.rb"

ssh={
	username:"", # ユーザーネームを入れる
	opt:{
		password:"", # パスワードを入れる
		port:22
	}
}

def set_room(line = 0,*ar)
	10.times do |i|
		print ar[i]
	end
	puts ""
end

room = PCroom.new(2..91,timeout:5,ssh:ssh)
nodes = room.get_status
blank = "         "
pc_num = []; os = []; user = []; threads = []

2.upto(91) do |i|
	case i.to_s.size
		when 1
			pc_num << "   #{i}     "
		when 2
			pc_num << "   #{i}    "
	end
end

90.times do |i|
	case nodes[i]
		when :windows
			os << " #{nodes[i]} "
			user[i] = blank
		when :linux
			os << " #{nodes[i]}   "
			threads << Thread.new{
				pc = PCnode.new(i+2,timeout:5,ssh:ssh)
				user[i] = pc.user ? "#{pc.user} " : blank
			}
		when :off
			os << "   #{nodes[i]}   "
			user[i] = blank
	end
end
threads.each {|job| job.join}

9.times do |line|
	set_room((line*10),*pc_num[(line*10),10])
	set_room((line*10),*os[(line*10),10])
	set_room((line*10),*user[(line*10),10])
end

puts ""
puts "linux #{room.count(:linux)}"
puts "windows #{room.count(:windows)}"
puts "off #{room.count(:off)}"
```

This software is released under the MIT License, see LICENSE.txt.
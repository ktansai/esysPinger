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

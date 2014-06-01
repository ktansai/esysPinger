require "../lib/esysPinger.rb"
require "pp"

room = PCroom.new(2..91,timeout:5) # 検索対象のPCナンバー
pp room.get_status # 全マシンのステータスを配列で取得
puts "on #{room.count(:on)}"
puts "off #{room.count(:off)}"

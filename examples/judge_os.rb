#!/usr/bin/env ruby
# coding: utf-8

$:.unshift File.expand_path '../lib', File.dirname(__FILE__)
require 'esys_pinger'

ssh = {
  username:"", # ユーザーネームを入れる
  opt:{
    password:"", # パスワードを入れる
    port:22
  }
}

room = EsysPinger::PCroom.new(2..91, timeout:5, ssh:ssh)
nodes = room.get_status
blank = "         "
pc_num = []; os = []; user = []; threads = []

90.times do |i|
  case (i + 2).to_s.size
  when 1 then pc_num << "   #{i + 2}     "
  when 2 then pc_num << "   #{i + 2}    "
  end

  case nodes[i]
  when :windows
    os << " #{nodes[i]} "
    user[i] = blank
  when :linux
    os << " #{nodes[i]}   "
    threads << Thread.new do
      pc = EsysPinger::PCnode.new(i+2, timeout:5, ssh:ssh)
      user[i] = pc.user ? "#{pc.user} " : blank
    end
  when :off
    os << "   #{nodes[i]}   "
    user[i] = blank
  end
end
threads.each {|job| job.join}

9.times.map{ |e| e * 10 }.each do |line|
  puts pc_num[line..(line + 9)].join
  puts os[line..(line + 9)].join
  puts user[line..(line + 9)].join
end

puts ""
puts "linux #{room.count(:linux)}"
puts "windows #{room.count(:windows)}"
puts "off #{room.count(:off)}"

#!/usr/bin/env ruby
# coding: utf-8

$:.unshift File.expand_path '../lib', File.dirname(__FILE__)
require 'esys_pinger'
require "pp"

# 検索対象のPCナンバーを指定
room = EsysPinger::PCroom.new(2..91, timeout:5)

# 全マシンのステータスを配列で取得
pp room.get_status_list

# それぞれの状態のマシンをカウント
puts "on #{room.count(:on)}"
puts "off #{room.count(:off)}"

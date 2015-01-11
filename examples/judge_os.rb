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

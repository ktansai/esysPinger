require "net/ping"
require "net/ssh"
require "pp"

class PCnode
	attr_accessor :node_num, :addr, :node_num_str,:ssh
	def initialize(num,timeout:1,ssh:nil)
		@node_num = num
		@ssh      = ssh

		case @node_num.to_s.size
			when 1
				@node_num_str = '00'+ @node_num.to_s
			when 2
				@node_num_str = '0' + @node_num.to_s
			else
				raise SyntaxError.new('invalid node_num')
		end
		@addr = "esys-pc#{@node_num_str}.edu.esys.tsukuba.ac.jp"
		@pinger = Net::Ping::External.new(@addr,nil,timeout)

		if @ssh
			@ssh[:opt][:timeout]=timeout
		end
	end

	def on?
		return @pinger.ping?
	end

	def linux?
		if ssh.nil?
			raise SyntaxError.new('no ssh option')
		end

		begin
			return true if Net::SSH.start(@addr,ssh[:username],ssh[:opt])
		rescue
			return false
		end
	end

	def windows?
		return !self.linux? && self.on?
	end

	def get_status
		#status = :Linux :windows :off
		return :linux if self.linux?
		return :windows if self.on?
		return :off 
	end

end

ssh={
	username:"",
	opt:{
		port:22
	}
}

hoge = PCnode.new(ARGV[0],timeout:3,ssh:ssh)
puts  "#{ARGV[0]} : #{hoge.get_status}"

require 'socket'
require 'logger'

class WebServerWrapper
	attr_accessor :server

	def initialize
		@server = TCPServer.new('localhost', 3000)
		@logger = Logger.new('log.txt')
	end

	def start!
		loop do
			session = server.accept
			session.print "HTTP/1.1 200 OK\n"
			
			id = get_id(session)

			cookie_line = ""
			while((line = session.gets) != "\r\n")
				cookie_line = line if line =~ /^Cookie/
			end

			if id.empty?
				session.print "\n#{cookie_line}" if !cookie_line.empty?
			else
				segments_array = find_segments(cookie_line)
				segments_array << id
				session.print "Set-Cookie: segments=#{segments_array.join(",")} Expires=Wed, 01-Jan-2020 12:12:12 GMT;\n\n"
			end
			
			session.close
		end		
	end

	def close_session(session)
		session.close
	end

	def get_id(session)
		session.gets.split[1].gsub('/','')
	end

	def find_segments(cookie_line)
		segments_str = cookie_line.scan(/\ssegments=[a-zA-z1-9,]*\s{1}/).first
		if segments_str 
			segments_str.gsub!('segments=','')
			array = segments_str.split(',')
			array.each { |a| a.strip! }
		else
			[]
		end
	end
end

ws = WebServerWrapper.new
ws.start!
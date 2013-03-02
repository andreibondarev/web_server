require 'socket'
require 'logger'

class WebServerWrapper
	def initialize
		@server = TCPServer.new('localhost', 3000)
		@logger = Logger.new('log.txt')
	end

	def start!
		loop do
			session = @server.accept
			session.print "HTTP/1.1 200 OK\n"
			
			id = get_id(session)

			cookies_line = ""
			while((line = session.gets) != "\r\n")
				cookies_line = line if line =~ /^Cookie/
				print line
			end

			if id.empty?
				session.print "\n#{cookies_line}" if !cookies_line.empty?
			else
				segments_value = find_segments_value(cookies_line) if !cookies_line.empty?
				
				session.print "Set-Cookie: segments=#{segments_value},#{id} Expires=Wed, 01-Jan-2020 12:12:12 GMT;\n\n" #FIXME
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

	def find_segments_value(request_line)
		segments_str = request_line.scan(/\ssegments=[a-zA-z1-9,]*\s{1}/).first
		segments_str.gsub('segments=','')
	end
end

ws = WebServerWrapper.new
ws.start!



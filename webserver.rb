require 'socket'
require 'logger'

logger = Logger.new('log.txt')

server = TCPServer.new('localhost', 3000)

loop do
	session = server.accept
	session.print "HTTP/1.1 200 OK\n"
	
	resource = session.gets.split[1].gsub('/','')

	if resource.empty?
		request_line = session.gets while !(request_line =~ /^Cookie/)
		session.print "\n#{request_line}"
	else
		session.print "Set-Cookie: segments=#{resource} Expires=Wed, 01-Jan-2020 12:12:12 GMT;\n\n"
	end
	
	logger.info "#{session.gets}#{session.gets}"
	session.close
end
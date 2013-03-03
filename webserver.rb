require 'socket'
require 'logger'
require 'csv'

class WebServerWrapper
	attr_accessor :server, :lookup_hash

	def initialize
		@server = TCPServer.new('localhost', 3000)
		@logger = Logger.new('log.txt') # For debugging purposes
		@lookup_hash = load_csv('lookup.csv')
	end

	# Parse the CSV file and set a hash of keys and values
	def load_csv(file) 
		hash = {}
		CSV.foreach(file) { |row| hash[row[0]] = row[1] } 
		hash
	end

	def start!
		loop do
			session = server.accept
			session.print "HTTP/1.1 200 OK\n"
			
			id = extract_id(session)

			cookie_line = ""
			while((line = session.gets) != "\r\n") # Iterate over the request line-by-line
				cookie_line = line if line =~ /^Cookie/ # Set the cookie_line if any cookies were sent as part of the request
			end

			if id.empty?
				session.print("\nsegments=" + find_segments(cookie_line).join(',')) if !cookie_line.empty? # Print the 'segments' value
			else
				segments_array = find_segments(cookie_line)
				segments_array << id # Append the new value to 'segments'

				session.print "Set-Cookie: segments=#{segments_array.join(",")} Expires=Wed, 01-Jan-2020 12:12:12 GMT;\n\n"
				
				if lookup_hash.key?(id) # If the ID was present in the CSV file - display the value
					session.print "#{id} => #{lookup_hash[id]}"
				end
			end
			
			session.close
		end		
	end

	def close_session(session)
		session.close
	end

	# Extract the path/ID/resource
	def extract_id(session)
		session.gets.split[1].gsub('/','')
	end

	# Parse the cookie_line and return an array of 'segments' cookie values
	def find_segments(cookie_line)
		segments_str = cookie_line.scan(/\ssegments=[a-zA-z1-9,]*\s{1}/).first # Scan the string for segments= and comma-separated values
		if segments_str 
			segments_str.gsub!('segments=','')
			array = segments_str.split(',')
			array.each { |a| a.strip! } # Remove any extra spaces
		else
			[]
		end
	end
end

ws = WebServerWrapper.new
ws.start!
require 'socket'
require './lib/request_handler'
require './lib/response_handler'
require 'pry'

class Server
  attr_reader :server, :client
  attr_accessor :count
  def initialize(port)
    @server = TCPServer.new(port)
    @count = 1
  end

  def listen
    loop do
      puts "Listening for requests..."
      @client = server.accept
      # send a request to the server
      request_handler = RequestHandler.new
      sent_request = request_handler.send_request(@client)
      puts "recieved request:\n#{request_handler.request_lines.join("\n")}"

      #server sends back a response
      response_handler = ResponseHandler.new(sent_request, count)
      client.puts response_handler.send_output
      client.puts response_handler.request_info
      # client.puts response.send_response
      client.close
      @count += 1
      # binding.pry
    end
  end
end

Server.new(9292).listen







# tcp_server = TCPServer.new(9292)
# count = 0
#
# while
#   client = tcp_server.accept
#   request_lines = []
#
#   while line = client.gets and !line.chomp.empty?
#     request_lines << line.chomp
#   end
#
#   response = "<pre>" + request_lines.join("\n") + "</pre>"
#   output = "<html><head>Hello, World! (#{count})</head><body>#{response}</body></html>"
#   headers = ["http/1.1 200 ok",
#             "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
#             "server: ruby",
#             "content-type: text/html; charset=iso-8859-1",
#             "content-length: #{output.length}\r\n\r\n"].join("\r\n")
#   client.puts headers
#   client.puts output
#   count += 1
#   client.close
# end

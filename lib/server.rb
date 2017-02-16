require 'socket'
require './lib/request_handler'
require './lib/response_handler'
require 'pry'

class Server
  attr_reader :server, :client
  attr_accessor :total_count, :hello_count, :server_close
  def initialize(port)
    @server = TCPServer.new(port)
    @total_count = 1
    @hello_count = 1
  end

  def listen
    loop do
      puts "Listening for requests..."
      @client = server.accept
      request_handler = RequestHandler.new
      request_hash = request_handler.retrieve_request_header(@client)

      response_handler = ResponseHandler.new(request_hash, total_count, hello_count, @client)
      response = response_handler.parsed_response

      output = "<html><head></head><body>#{response}</body></html>"
      headers = response_handler.headers(output)

      client.puts headers
      client.puts output
      if response_handler.close_server == true
        break
      end

      if request_hash[:path].include? ("hello")
        @hello_count += 1
      end
      @total_count += 1
      client.close
    end
  end
end

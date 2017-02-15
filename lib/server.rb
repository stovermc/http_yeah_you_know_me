require 'socket'
require './lib/request_handler'
require './lib/response_handler'
require 'pry'

class Server
  attr_reader :server, :client
  attr_accessor :total_count, :server_close
  def initialize(port)
    @server = TCPServer.new(port)
    @total_count = 1

  end

  def listen
    loop do
      puts "Listening for requests..."
      @client = server.accept
      # send a request to the server
      request_handler = RequestHandler.new
      request_lines = request_handler.send_request(@client)
      response_handler = ResponseHandler.new(total_count)
      client.puts response_handler.headers(request_lines)
      client.puts response_handler.parsed_response(request_lines)
      if response_handler.close_server == true
        break
      end

      #binding.pry
      @total_count += 1
      client.close
    end
    puts "outside the loop!"
  end
end



# puts "recieved request:\n#{request_handler.request_lines.join("\n")}"

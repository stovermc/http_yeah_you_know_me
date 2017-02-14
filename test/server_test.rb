require 'minitest/autorun'
require 'minitest/pride'
require './lib/server.rb'
require 'faraday'

class ServerTest < Minitest::Test
  def test_server_exists
    response = Faraday.get "http://127.0.0.1:9292"
    assert_equal "<html><head>Hello, World! (#{count})</head><body>#{response}</body></html>",
    response.body 
  end
end

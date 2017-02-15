require 'minitest/autorun'
require 'minitest/pride'
require './lib/request_handler'
require 'faraday'

class RequestHandlerTest < Minitest::Test
  attr_reader :response
  # i_suck_and_my_tests_are_order_dependent!
  def setup
    @response = Faraday.get "http://127.0.0.1:9292"
  end

  def test_request_handler_exists
    skip
    assert_instance_of RequestHandler, RequestHandler.new
  end

  def test_request_is_sent
    response
    assert_equal  ["GET /hello HTTP/1.1",
 "Host: 127.0.0.1:9292",
 "Connection: keep-alive",
 "Cache-Control: no-cache",
 "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
 "Postman-Token: a9f574f0-f15a-9b10-ecb4-af6d696ea09c",
 "Accept: */*",
 "DNT: 1",
 "Accept-Encoding: gzip, deflate, sdch, br",
 "Accept-Language: en-US,en;q=0.8"], response.headers
  end

end

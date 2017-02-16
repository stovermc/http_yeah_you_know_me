require 'minitest/autorun'
require 'minitest/pride'
require './lib/request_handler'
require 'faraday'

class RequestHandlerTest < Minitest::Test
  attr_reader :request,
              :response,
              :get_request_lines,
              :post_request_lines,
              :get_request_hash,
              :post_request_hash
  def setup
    @request = RequestHandler.new
    # @server = TCPServer.new(port)
    # @client = server.accept
    @response = Faraday.get "http://127.0.0.1:9292/hello"
    @get_request_lines =["GET /hello HTTP/1.1",
                         "Host: 127.0.0.1:9292",
                         "Connection: keep-alive",
                         "Cache-Control: no-cache",
                         "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
                         "Postman-Token: 5531eda7-bee4-25b3-cf81-ec05a2a4c830",
                         "Accept: */*",
                         "DNT: 1",
                         "Accept-Encoding: gzip, deflate, sdch, br",
                         "Accept-Language: en-US,en;q=0.8"]

  @post_request_lines = ["POST /game?guess=2 HTTP/1.1",
                         "Host: 127.0.0.1:9292",
                         "Connection: keep-alive",
                         "Content-Length: 0",
                         "Cache-Control: no-cache",
                         "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
                         "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
                         "Postman-Token: c8c386bc-3068-f515-0f9d-91b8e674cb43",
                         "Accept: */*",
                         "DNT: 1",
                         "Accept-Encoding: gzip, deflate, br",
                         "Accept-Language: en-US,en;q=0.8"]

@get_request_hash = {:verb=>"GET",
                     :path=>"/hello",
                     :protocol=>"HTTP/1.1",
                     :host=>"127.0.0.1:9292",
                     :port=>"9292",
                     :origin=>"127.0.0.1:9292",
                     :accept=>" */*"}

  @post_request_hash = {:verb=>"POST",
                       :path=>"/game?guess=2",
                       :protocol=>"HTTP/1.1",
                       :host=>"127.0.0.1:9292",
                       :port=>"9292",
                       :origin=>"127.0.0.1:9292",
                       :content_length=>" 0",
                       :accept=>" Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36"}
  end

  def test_request_handler_exists
    # skip
    assert_instance_of RequestHandler, RequestHandler.new
  end

  def test_determine_request_get
    response
  end

end
assert_equal get_request_lines, request.determine_request()

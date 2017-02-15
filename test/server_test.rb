require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'
require 'faraday'

class ServerTest < Minitest::Test
  attr_reader :response
  i_suck_and_my_tests_are_order_dependent!
  def setup
    @response = Faraday.get "http://127.0.0.1:9292/hello"
  end

  def test_server_exists
    skip
    assert_instance_of Server, Server.new(9292)
  end

  def test_a_hello_world
    # skip
    assert_equal "Hello, World! (1)", response.body
  end

  def test_b_hello_world_increments
    response
    assert_equal "Hello, World! (2)", response.body
  end
end

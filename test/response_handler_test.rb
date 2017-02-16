require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'
require './lib/response_handler'
require 'faraday'

class ResponseHandlerTest < Minitest::Test
  # i_suck_and_my_tests_are_order_dependent!

  def test_a_hello_world
    skip
    response = Faraday.get "http://127.0.0.1:9292/hello"
    assert_equal "Hello, World! (1)", response.body
  end

  def test_b_hello_world_increments
    skip
    response = Faraday.get "http://127.0.0.1:9292/hello"
    assert_equal "Hello, World! (2)", response.body
  end

  def test_date_time
    skip
    response = Faraday.get "http://127.0.0.1:9292/datetime"
    time = Time.now.strftime('%l:%M%p on %A, %B %e, %Y')

    assert_equal "<html><head></head><body>#{time}</body></html>", response.body
  end

  def test_shutdown
    skip
    response = Faraday.get "http://127.0.0.1:9292/shutdown"

    assert_equal "<html><head></head><body>Total Requests: 1\n" + "Shutting down server, see you next time!</body></html>",
    response.body
  end

  def test_word_search_real_word
    skip
    response = Faraday.get "http://127.0.0.1:9292/word_search?word=fluffy"

    assert_equal "<html><head></head><body>Yep, FLUFFY is a known word</body></html>",
    response.body

  end

  def test_word_search_fake_word
    skip
    response = Faraday.get "http://127.0.0.1:9292/word_search?word=schlop"

    assert_equal "<html><head></head><body>Hmmm, SCHLOP is not a known word</body></html>",
    response.body
  end

  def test_new_game
    skip
    response = Faraday.get "http://127.0.0.1:9292/start_game"

    assert_equal "<html><head></head><body>May the odds be ever in your favor.</body></html>",
    response.body
  end
end

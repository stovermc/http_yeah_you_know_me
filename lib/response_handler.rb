
require './lib/game'

class ResponseHandler
  attr_reader :request_hash, :close_server, :game, :count, :hello_count
  # attr_accessor
  def initialize(request_hash, total_count, hello_count, client)
    @request_hash = request_hash
    @count = total_count
    @hello_count = hello_count
    @close_server = false
    @client = client
  end


  def parsed_response
    return parsed_path       if request_hash[:path] == "/"
    return hello_path        if request_hash[:path] == "/hello"
    return date_time_path    if request_hash[:path] == "/datetime"
    return shutdown          if request_hash[:path] == "/shutdown"
    return word_seach        if request_hash[:path].include? ("word=")
    return new_game          if request_hash[:path] == ("/start_game")
    return times_guessed     if request_hash[:path] == ("/game") && request_hash[:verb] == "GET"
    return make_guess        if request_hash[:path] == ("/game") && request_hash[:verb] == "POST"

  end

  def parsed_path
    "<pre>\n" +
    "Verb: #{request_hash[:verb]}\n" +
    "Path: #{request_hash[:path]}\n" +
    "Protocol: #{request_hash[:protocol]}\n" +
    "Host: #{request_hash[:host]}\n" +
    "Port: #{request_hash[:port]}\n" +
    "Origin: #{request_hash[:origin]}\n" +
    "Accept:#{request_hash[:accept]}\n" +
    "</pre>"
  end

  def hello_path
    "Hello, World! (#{hello_count})"
  end

  def date_time_path
    "#{Time.now.strftime('%l:%M%p on %A, %B %e, %Y')}"
  end

  def shutdown
    @close_server = true
    "Total Requests: #{count}\n" +
    "Shutting down server, see you next time!"
  end

  def word_seach
    search_word = request_hash[:path].split("=")[1]
    dictionary = File.open("/usr/share/dict/words", "r").read.split("\n")
    if dictionary.include? (search_word)
      "Yep, #{search_word.upcase} is a known word"
    else
      "Hmmm, #{search_word.upcase} is not a known word"
    end
  end

  def new_game
    @game = Game.new
    "May the odds be ever in your favor."
  end

  def make_guess
    guess = client.read(request_hash[:content_length]).to_i
    binding.pry
    game.guess = guess
    game.compare_guess
  end

  def times_guessed
    if game.count > 0
    "#{game.count} guesses have been taken. \n" +
    "#{game.compare_guess}"
    end
  end

  def headers(output)
    ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def redirect_header
    ["http/1.1 302 Page Has Moved.",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "Location: http://127.0.0.1:9292/game",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

end



# verb = request_lines[0].split(" ")[0]
# path = request_lines[0].split(" ")[1]
# protocol = request_lines[0].split(" ")[2]
# host = request_lines[1].split(" ")[1]
# port = request_lines[1].split(":")[2]
# origin = request_lines[1].split(" ")[1]
# accept = request_lines[6].split(":")[1]
# accept = ""


# elsif verb == "POST" && path == "/start_game"
#   #start game
#   puts "May the odds be ever in your favor!"
# elsif verb == "GET" && path == "/game"
#   #puts game.guesses
#   #puts if a guess was made, what the guess was adn too high or low
# elsif verb == "POST" && path == "/game"
#   guess = path.split("=")[1]
#   game.make_guess(guess)

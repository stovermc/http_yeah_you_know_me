
class ResponseHandler
  attr_reader :request_lines, :close_server
  attr_accessor :count
  def initialize(total_count)
    @count = total_count
    @close_server = false
  end

  def original_response
   "<pre>" + request_lines.join("\n") + "</pre>"
  end

  def headers(output)
     ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def parsed_response(request_lines)
    verb = request_lines[0].split(" ")[0]
    path = request_lines[0].split(" ")[1]
    protocol = request_lines[0].split(" ")[2]
    host = request_lines[1].split(" ")[1]
    port = request_lines[1].split(":")[2]
    origin = request_lines[1].split(" ")[1]
    # accept = request_lines[6].split(":")[1]
    accept = ""
    if path == "/"
      "<pre>\n" +
      "Verb: #{verb}\n" +
      "Path: #{path}\n" +
      "Protocol: #{protocol}\n" +
      "Host: #{host}\n" +
      "Port: #{port}\n" +
      "Origin: #{origin}\n" +
      "Accept:#{accept}\n" +
      "</pre>"
    elsif path == "/hello"
      "Hello, World! (#{count})"
    elsif path == "/datetime"
      "#{Time.now.strftime('%l:%M%p on %A, %B %e, %Y')}"
    elsif path == "/shutdown"
      @close_server = true
      "Total Requests: #{count}"
    elsif path.include? ("word=")
      search_word = path.split("=")[1]
      dictionary = File.open("/usr/share/dict/words", "r").read.split("\n")
      if dictionary.include? (search_word)
        "#{search_word} is a known word"
      else
        "#{search_word} is not a known word"
      end
    elsif verb == "POST"

    end
  end
end

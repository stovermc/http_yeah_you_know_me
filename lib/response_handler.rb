
class ResponseHandler
  attr_reader :request_lines
  attr_accessor :count
  def initialize(request_lines, count)
    @request_lines = request_lines
    @count = count
  end

  def send_response
   "<pre>" + request_lines.join("\n") + "</pre>"
  end

  def send_output
    "<html><head></head><body>Hello, World!(#{count})</body></html>"
  end

  def send_headers
     ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def request_info
    verb = request_lines[0].split(" ")[0]
    path = request_lines[0].split(" ")[1]
    protocol = request_lines[0].split(" ")[2]
    host = request_lines[1].split(" ")[1]
    port = request_lines[1].split(":")[2]
    origin = request_lines[1].split(" ")[1]
    accept = request_lines[6].split(":")[1]
    "<pre>\n" +
    "Verb: #{verb}\n" +
    "Path: #{path}\n" +
    "Protocol: #{protocol}\n" +
    "Host: #{host}\n" +
    "Port: #{port}\n" +
    "Origin: #{origin}\n" +
    "Accept:#{accept}\n" +
    "</pre>"
  end



  #
  # def request_info(request_lines)
  #   "<pre>
  #   Verb: POST
  #   Path: /
  #   Protocol: HTTP/1.1
  #   Host: 127.0.0.1
  #   Port: 9292
  #   Origin: 127.0.0.1
  #   Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
  #   </pre>"
  # end

end

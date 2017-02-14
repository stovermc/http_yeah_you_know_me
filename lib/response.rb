
class Response
  attr_reader :request_lines
  attr_accessor :count
  def initialize(request_lines, count)
    @request_lines = request_lines
    @count = count
  end

  def send_response
    @response = "<pre>" + request_lines.join("\n") + "</pre>"
  end

  def send_output
    @output = "<html><head></head><body>Hello, World!(#{count})</body></html>"
  end

  def send_headers
    @headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end
end

class RequestHandler
  attr_reader :request_lines
  def initialize
  @request_lines = []
  end

  def send_request(client)
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end
end

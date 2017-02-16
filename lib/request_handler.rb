class RequestHandler
  attr_reader :request_lines, :request_hash
  def initialize
  @request_lines = []
  @request_hash ={}
  end

  def send_request(client)
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end

  def determine_request(request_lines)
    if request_lines[0].split(" ")[0] == "GET"
      get_request
    elsif
      request_lines[0].split(" ")[0] == "POST"
      post_request
    end
  end

  def get_request
    request_hash[:verb] = request_lines[0].split(" ")[0]
    request_hash[:path] = request_lines[0].split(" ")[1]
    request_hash[:protocol] = request_lines[0].split(" ")[2]
    request_hash[:host] = request_lines[1].split(" ")[1]
    request_hash[:port] = request_lines[1].split(":")[2]
    request_hash[:origin] = request_lines[1].split(" ")[1]
    # request_hash[:accept] = request_lines[6].split(":")[1]
    request_hash
  end

  def post_request
    request_hash[:verb] = request_lines[0].split(" ")[0]
    request_hash[:path] = request_lines[0].split(" ")[1]
    request_hash[:protocol] = request_lines[0].split(" ")[2]
    request_hash[:host] = request_lines[1].split(" ")[1]
    request_hash[:port] = request_lines[1].split(":")[2]
    request_hash[:origin] = request_lines[1].split(" ")[1]
    request_hash[:content_length] = request_lines[3].split(":")[1]
    request_hash[:accept]  = request_lines[6].split(":")[1]
    request_hash
  end

  def retrieve_request_header(client)
    request_header = send_request(client)
    request_header_hash = determine_request(request_header)
  end
end

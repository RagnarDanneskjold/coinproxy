require 'sinatra'
require 'json'
require 'net/http'

# require './conf.rb'
require './conf_dev.rb'

set :port, 8332

post '/' do
  # Unpack the request
  request.body.rewind
  data = JSON.parse request.body.read
  puts "Client IP: #{request.ip}"
  puts "RPC Method: #{data['method']}"
  puts "RPC Arguments: #{data['params']}"

  api_list = JSON.parse(IO.read("./api_controller.json"))

  case api_list[data['method']]
  when nil
    error_msg = "Method not found"
    puts error_msg
    # Bitcoin RPC error codes: https://github.com/bitcoin/bitcoin/blob/master/src/rpcprotocol.h#L34
    {"error" => {"code" => -32601, "message" => error_msg}}.to_json
  when "enabled"
    # Repack and forward the request
    @post_ws = "/"
    @payload = {"method" => data['method'], "params" => data['params']}.to_json

    req = Net::HTTP::Post.new(@post_ws, initheader = {'Content-Type' => 'application/json'})
    req.basic_auth settings.rpcusername, settings.rpcpassword
    req.body = @payload

    # Accept the response from bitcoind
    res = Net::HTTP.new(settings.host, settings.port).start {|http| http.request(req)}
    puts "#{res.code} #{res.message} #{res.body}"
    
    # Forward the response to the original client
    res.body
  else
    error_msg =  "This API is not enabled!"
    puts error_msg
    # The error code -32800 here is NOT an official error code
    {"error" => {"code" => -32800, "message" => error_msg}}.to_json
  end
end

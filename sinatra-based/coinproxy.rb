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
end
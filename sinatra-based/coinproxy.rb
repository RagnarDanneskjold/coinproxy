require 'sinatra'
require 'json'

set :port, 8332

post '/' do
  request.body.rewind
  data = JSON.parse request.body.read
  puts "Client IP: #{request.ip}"
  puts "RPC Method: #{data['method']}"
  puts "RPC Arguments: #{data['params']}"
end

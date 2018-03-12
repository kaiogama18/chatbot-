
require 'sinatra'

get '/webhook' do
  params['hub.challenge'] if ENV["VERIFY_TOKEN"] == params['hub.verify_token']
end

get "/" do
  "Teste"
end
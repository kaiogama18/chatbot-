require './app'

require 'facebook/messenger'
include Facebook::Messenger

map("/webhook") do
  run Sinatra::Application
  run Facebook::Messenger::Server
end

run Sinatra::Application
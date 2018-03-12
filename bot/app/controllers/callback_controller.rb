class CallbackController < ApplicationController
  def index
    if params["hub.verify_token"] == "home1942"
      render text: params["hub.challenge"]
    end
  end
  
  def recieved_data
  end
end

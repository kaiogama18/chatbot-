module Commands
  API_URL = 'https://maps.googleapis.com/maps/api/geocode/json?latlng='.freeze

  # Pesquisa baseada em dados de localização do dispositivo do usuário
  def lookup_location
    if message_contains_location?
      handle_user_location
    else
      say("Por favor, tente novamente usando o botão 'Enviar localização'")
    end
    stop_thread
  end

  def handle_user_location
    coords = message.attachments.first['payload']['coordinates']
    lat = coords['lat']
    long = coords['long']
    message.typing_on
    parsed = get_parsed_response(API_URL, "#{lat},#{long}")
    address = extract_full_address(parsed)
    say "Coordenadas da sua localização: Latitude #{lat}, Longitude #{long}. " \
        "Parece que você está em #{address}"
    message.typing_off
  end

  # Talk to API
  def get_parsed_response(url, query)
    response = HTTParty.get(url + query)
    parsed = JSON.parse(response.body)
    parsed['status'] != 'ZERO_RESULTS' ? parsed : nil
  end

  def extract_full_address(parsed)
    parsed['results'].first['formatted_address']
  end
end

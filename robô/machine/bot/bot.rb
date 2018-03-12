require 'rubotnik'
Rubotnik::Autoloader.load('bot')

Rubotnik.subscribe(ENV['ACCESS_TOKEN'])

Rubotnik.set_profile(
  Profile::START_BUTTON, Profile::START_GREETING, Profile::SIMPLE_MENU
)

LOCATION_PROMPT = UI::QuickReplies.location

####################### Campo de Perguntas ##############################

Rubotnik.route :message do
  # Frase que servem para as três perguntas
  bind 'oi', 'fala', 'eai' do
    say 'Bem vindo(a) sou uma máquina que gosta de falar'
  end
  
  # Inicie uma discussão (e forneça uma mensagem de abertura com respostas rápidas opcionais).
  # Você precisa definir o método denominado como símbolo dentro de um módulo de comando
  # e trate a resposta do usuário para sua mensagem "reply_with" lá.
  # commands / commands.rb já possui esse método start_conversation
  # definido como um exemplo.

  bind 'como', 'você', 'está', all: true, to: :start_conversation, reply_with: {
     text: "Eu estou bem! Você?",
     quick_replies: [['De Boa!', 'OK'], ['Não muito bem', 'NOT_OK']]
   }

   # Comando 'All' é utilizado quando todas as palavras estivem no campo
   bind 'Qual', 'meu', 'nome', all: true do
     info = get_user_info(:first_name) 
     say info[:first_name]
   end

   bind 'Onde', 'eu', 'estou', all: true, to: :lookup_location, reply_with: {
      text: 'Deixe-me saber a sua localização',
      quick_replies: LOCATION_PROMPT
    }

    
    # Rubotnik atualmente suporta Imagem, Modelo de Botão e Carrossel
    bind 'image', to: :show_image

   # Quando não tem resposta ou não entendeu
   default do
     say "Desculpe, eu não entendi"
   end
end

####################### HANDLE ENTRADA POSTBACKS ##############################

Rubotnik.route :postback do
  # Postback do botão "Começar"
  bind 'START' do
    say "Bem vindo!"
  end
end

####################### HANDLE OUTROS PEDIDOS (NON-FB) #########################

get '/' do
  'Eu sou o Index do localhost'
end

####################### CPF #########################
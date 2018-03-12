module Commands
  # Você pode escrever todos os seus comandos como métodos aqui

  def cpf
    message.typing_on
    case message.quick_reply
    when 'OK'
      say "Informe o numero!"
      next_command :appear_nice2
    when 'NOT_OK'
      say "Continue"
      
      stop_thread
    else
      say "Obrigado"
      # Boa Prática ter outar pergunta
      stop_thread
    end
    message.typing_off
  end

  def appear_nice2
    validar = message.typing_on
    total = validar.size
    aux = message.typing_on
    if validar.size == 35 
      say "Cpf válido!"
      stop_thread
    else
      say "Cpf inválido"
      stop_thread
    end 
  end
  
  # Se o comando estiver vinculado com reply_with especificado,
  # você precisa lidar com a resposta do usuário para a última mensagem e reagir nela.
  def start_conversation
    # As respostas rápidas são acessíveis através da propriedade quick_reply do objeto de mensagem,
    # por padrão é o texto de resposta rápida em TODOS OS CAPS
    # você também pode reagir no próprio texto
    message.typing_on
    case message.quick_reply
    when 'OK'
      say "Fico feliz que esteja bem!"
      stop_thread
    when 'NOT_OK'
      say "Que pena. O que aconteceu?"
      next_command :appear_nice  #Resposta para pergunta 
    else
      say "Pode informar o seu cpf?"
      # Boa Prática ter outar pergunta
      stop_thread
    end
    message.typing_off
  end

  def appear_nice
    message.typing_on
    case message.text
    when /job/i then say "Minhas sinceras condolências 😥"
    when /family/i then say "Isso é apenas a vida"
    else
      say "Deve passar 😱"
    end
    message.typing_off
    stop_thread # futuras mensagens do usuário serão manipuladas a partir de ligações de nível superior
  end
end

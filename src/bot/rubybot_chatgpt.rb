require 'discordrb'
require_relative '../config/config_loader'
require_relative 'rubybot_openai'

DISCORD_MAX_LEN = 2000

class RubybotChatgpt < Discordrb::Bot
  def initialize
    super(token: ConfigLoader.discord_token)
    @openai_engine = ConfigLoader.openai_engine
    @client = RubybotOpenAI.new
  end

  def run
    message(start_with: '/chatgpt ') do |event|
      handle_message(event)
    end
    
    super
  end

  def handle_message(event)
    message = event.content.sub("/chatgpt", "")
    response = generate_chat_response(message)

    if response.nil?
      puts response
      event.respond('ChatGPT is currently unavailable. Please try again later.')
    else
      split_message_chunks(response).each do |chunk|
        puts chunk
        event.respond(chunk)
      end
    end
  end

  def generate_chat_response(message)
    begin
      response = @client.chat(
        parameters: {
            model: @openai_engine, # Required.
            messages: [{ role: "user", content: message}], # Required.
            temperature: 0.5,
            max_tokens: 2000,
        })

      response.dig("choices", 0, "message", "content")
    rescue StandardError => e
      puts "An error occurred while interacting with ChatGPT: #{e.message}"
    end
  end

  def split_message_chunks(message)
    words = message.split(' ')
    chunks = []
    current_chunk = ''
  
    words.each do |word|
      if current_chunk.empty? || (current_chunk.length + word.length + 1) <= DISCORD_MAX_LEN
        current_chunk << (current_chunk.empty? ? word : " #{word}")
      else
        chunks << current_chunk
        current_chunk = word
      end
    end
  
    chunks << current_chunk unless current_chunk.empty?
    chunks
  end
end

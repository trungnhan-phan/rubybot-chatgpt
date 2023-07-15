require "ruby/openai"
require_relative '../config/config_loader'

class RubybotOpenAI < OpenAI::Client
  def initialize
    OpenAI.configure do |config|
      config.access_token = ConfigLoader.openai_api_key
      config.organization_id = ConfigLoader.openai_organization_id
    end

    super()
  end
end

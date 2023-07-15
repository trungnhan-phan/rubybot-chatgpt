# discordbot-chatgpt
A simple Discord Bot in Python interacting with ChatGPT API

# Setup

Modify the config.json with the following instruction.

## OpenAI
Visit OpenAI [keys settings](https://platform.openai.com/account/api-keys) and follow the steps to create your API key. Remember to save your keys.

Next add your [organization id](https://platform.openai.com/account/org-settings).

## Discord

1. Visit https://discordapp.com/developers/applications/
2. Create an Application and give it a name.
3. Go to the Bot tab, and create one by clicking the Add Bot button.
4. Copy your bot token into the config.json

## GPT Model

Refere to [this documentation](https://platform.openai.com/docs/models) on which model is best for you. Default in the configuration is set to text-davinci-003.


# How to Run

bundle install
ruby src/main.rb

In the discord channel type /chatgpt to ask ChatGPT questions.
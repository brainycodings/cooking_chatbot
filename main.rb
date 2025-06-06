require_relative 'lib/scraper'
require_relative 'lib/recette'
require_relative 'lib/assistant'
require_relative 'lib/voice_input'

require 'dotenv/load'


search_url = get_request
doc = scraping(search_url)

recette = Recette.new(
  title: doc.at_css('h1')&.text&.strip,
  ingredients: get_ingredients(doc),
  utensils: get_utensils(doc),
  steps: get_instructions(doc)
)

recette.display_recipee
prompt = recette.generate_prompt
chatbot_conversation(prompt)

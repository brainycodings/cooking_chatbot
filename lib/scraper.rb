require 'nokogiri'
require 'open-uri'
require 'http'
require 'json'
require 'dotenv/load'
require_relative 'recette'

def get_request
  puts "quelle recette désires-tu ?"
  query = gets.chomp
  while query.strip.empty?
    puts "Tu dois entrer un nom de recette."
    query = gets.chomp
    end
  url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{query}"
  return url
end

def scraping(url)
    doc = Nokogiri::HTML(URI.open(url))
    begin
        doc = Nokogiri::HTML(URI.open(url))
    rescue OpenURI::HTTPError => e
        puts "Erreur lors du chargement de la page : #{e.message}"
        exit
    end

    cards = doc.css('div.recipe-card-algolia').first
    if cards.nil?
        puts "Aucune recette trouvée pour cette recherche."
        exit
    end
    link = cards.at_css('a.recipe-card-link')['href']
    if link.nil?
        puts "Le lien de la recette est introuvable."
        exit
    end
    Nokogiri::HTML(URI.open(link))
end


def get_ingredients(doc)
    ingredients = []
    cards = doc.css('div.card-ingredient')
    cards.each do |card|
        quantity = card.css('span.count').text.strip
        unit = card.css('span.unit').text.strip
        ingredient_name = card.css('span.ingredient-name').text.strip
        
        ingredients << {
            quantity: quantity,
            unit: unit,
            ingredient: ingredient_name
    }
    end
    ingredients
end
#temps

def get_utensils(doc)
    utensiles = []

    tools = doc.css('div.card-utensil-quantity')
    tools.each do |utensil|
    utensiles << utensil.text.strip.gsub(/\s+/, ' ')
     end
    utensiles
end

def get_instructions(doc)
    instructions = []

    steps = doc.css('div.recipe-step-list__container')
    #puts "Il y a #{steps.count} étapes :"
    steps.each do |step|
        instructions << step.css('p').text.strip    
    end
    instructions
end    





search_url = get_request
doc = scraping(search_url)
plat = Recette.new(
title: doc.at_css('h1')&.text&.strip,
  ingredients: get_ingredients(doc),
  utensils: get_utensils(doc),
  steps: get_instructions(doc)
)

plat.display_recipee
plat.generate_prompt





 system_prompt = plat.generate_prompt

# messages = [
#   { role: "system", content: system_prompt },
#   { role: "assistant", content: "Prêt pour la première étape ?" }
# ]


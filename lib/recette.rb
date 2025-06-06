class Recette
    attr_reader :title, :ingredients, :utensils, :steps

    def initialize(title:, ingredients:, utensils:, steps:)
        @title = title
        @ingredients = ingredients
        @utensils = utensils
        @steps = steps
    end

    def display_ingredients
        @ingredients.each do |item|
            quantite = item[:quantity]
            unite = item[:unit].to_s.strip
            nom = item[:ingredient]

            if unite.empty?
            puts "- #{quantite} #{nom}"
            else
            puts "- #{quantite}#{unite} de #{nom}"
            end
        end
    end


    def display_utensils
        @utensils.each do |utensil|
        puts "- #{utensil}"
        end
    end

    def display_instructions
        @steps.each_with_index do |step, i|
        puts "- Étape #{i + 1} : #{step}"
        end
    end

    def display_recipee
        puts "Pour faire #{@title.downcase}, vous aurez besoin de :"
        display_ingredients
        puts "\nUstensiles nécessaires :"
        display_utensils
        puts "\nInstructions :"
        display_instructions
        end

     def generate_prompt
        prompt = []

        prompt << "Tu es un assistant culinaire. Voici la recette à suivre :"
        prompt << ""
        prompt << "Nom : #{@title}"
        prompt << ""

        prompt << "Ingrédients :"
        @ingredients.each do |item|
            quantite = item[:quantity]
            unite = item[:unit].to_s.strip
            nom = item[:ingredient]

            if unite.empty?
                prompt << "- #{quantite} #{nom}"
            else
                prompt << "- #{quantite}#{unite} de #{nom}"
            end

        end

        unless @utensils.empty?
        prompt << "Ustensiles : #{@utensils.join(', ')}"
        prompt << ""
        end

        prompt << "Étapes :"
        @steps.each_with_index do |etape, i|
        prompt << "#{i + 1}. #{etape}"
        end
        prompt << ""

        prompt << "Ton rôle : guider l'utilisateur étape par étape, répondre à ses questions, et adapter tes réponses à ce qu'il dit. Garde toujours le contexte de la conversation et tiens en compte. Donne une seule instruction à la fois et précise les quantité à chaque étape."

        prompt.join("\n")
    end

end
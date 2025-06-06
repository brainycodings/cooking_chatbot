require 'http'
require 'json'

def chatbot_conversation(prompt)
    system_prompt = prompt

    messages = [
    { role: "system", content: system_prompt },
    { role: "assistant", content: "Prêt pour la première étape ?" }
    ]

    puts "Tu peux maintenant parler au bot (ex: 'je suis prêt'). Tape 'stop' pour quitter."
    loop do
    print "Vous : "
    user_input = listen
break if user_input.strip.downcase == "stop"

    messages << { role: "user", content: user_input }

    response = HTTP.auth("Bearer #{ENV['OPENAI_API_KEY']}").post(
    "https://api.openai.com/v1/chat/completions",
    json: {
        model: "gpt-3.5-turbo",
        messages: messages
    }
    )
    parsed = JSON.parse(response.body.to_s)

    if parsed["error"]
        puts "❌ Erreur API : #{parsed["error"]["message"]}"
        break
    end

    reply = JSON.parse(response.body.to_s)["choices"][0]["message"]["content"]
    messages << { role: "assistant", content: reply }

    puts "\nAssistant : #{reply}"
    speak(reply)
    end

    puts "\n👋 À bientôt, bon appétit !"

end

    def speak(text)
  system("powershell -Command \"Add-Type –AssemblyName System.Speech; " \
         "$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer; " \
         "$speak.Speak('#{text.gsub("'", '')}')\"")
end





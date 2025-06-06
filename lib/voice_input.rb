# lib/voice_input.rb

def listen
  puts "Je t'écoute..."
  output = `python listener.py`
    last_line = output.split("\n").last || ""
  puts "Tu as dit : #{last_line}"
  last_line
end

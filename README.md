# Simple Cooking Assistant Chatbot

A voice-enabled cooking assistant that helps users prepare meals by scraping top-rated recipes from Marmiton, guiding them step-by-step with voice instructions, and providing smart suggestions and alternatives using OpenAI's API.

---

## Features

- **Recipe Search**: Ask what you want to cook; the bot fetches the best-rated recipe from [Marmiton](https://www.marmiton.org).
- **Voice Instructions**: Recipes are spoken out loud using Text-to-Speech (TTS).
- **Voice Interaction**: The assistant listens to your voice via Vosk and responds accordingly.
- **Contextual AI**: The assistant understands recipe context and answers follow-up questions.
- **Dynamic Suggestions**: Proposes ingredient substitutions or tips based on your needs (e.g., vegetarian, gluten-free).

---

## How It Works

1. User says what they want to cook.
2. The chatbot scrapes the top-rated recipe from Marmiton.
3. The assistant reads the recipe step-by-step.
4. User can ask questions or request alternatives during cooking.

---

## Technologies Used

- **Ruby 3.4.2** — Main chatbot logic and flow.
- **Nokogiri gem** Scraping
- **Vosk** — Offline speech recognition.
- **OpenAI API** — Natural language understanding and dynamic interaction.

---

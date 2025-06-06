# listener.py
import sys
import sounddevice as sd
import vosk
import queue
import json

# Optionnel : affiche la liste des devices pour choisir
# print(sd.query_devices())
# device = 1  # ← Active si tu veux forcer un micro précis

model = vosk.Model("vosk-model-small-fr-0.22")
q = queue.Queue()

def callback(indata, frames, time, status):
    if status:
        print(status, file=sys.stderr)
    q.put(bytes(indata))

with sd.RawInputStream(samplerate=16000, blocksize=8000, dtype='int16',
                       channels=1, callback=callback):  # ← tu peux ajouter device=device si besoin
    rec = vosk.KaldiRecognizer(model, 16000)
    print("Parlez... (Ctrl+C pour quitter)")

    while True:
        data = q.get()
        if rec.AcceptWaveform(data):
            result = json.loads(rec.Result())
            if result.get("text"):
                print(result["text"])
                break

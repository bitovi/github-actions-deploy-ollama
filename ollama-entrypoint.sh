#!/bin/sh
set -e

#MODELS="mistral"  # Change this to your models (comma-separated)

# Start Ollama in the background
ollama serve &

# Wait a few seconds to ensure the server is up
sleep 5

# Convert MODELS into an array and loop through each model
IFS=','  # Set comma as the delimiter
for MODEL in $MODELS; do
    MODEL=$(echo "$MODEL" | xargs)  # Trim spaces
    if ! ollama list | grep -q "$MODEL"; then
        echo "Model $MODEL not found, pulling it now..."
        ollama pull "$MODEL"
    else
        echo "Model $MODEL is already available."
    fi
done

# Bring Ollama back to the foreground
wait
#!/bin/bash

# Ensure at least one file is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 file1.json [file2.json ...]"
    exit 1
fi

# Define the output file
OUTPUT_FILE="combined.json"

# Start the JSON array
echo "[" > "$OUTPUT_FILE"

FIRST=true
for file in "$@"; do
    if [ ! -f "$file" ]; then
        echo "Error: File '$file' not found. Skipping..."
        continue
    fi

    # Read JSON array and remove surrounding brackets
    CONTENT=$(jq -c '.[]' "$file")
    if [ -n "$CONTENT" ]; then
        if [ "$FIRST" = true ]; then
            FIRST=false
        else
            echo "," >> "$OUTPUT_FILE"
        fi
        echo "$CONTENT" | sed 's/^/    /' >> "$OUTPUT_FILE"
    fi

done

# End the JSON array
echo "]" >> "$OUTPUT_FILE"

echo "Combined JSON saved to $OUTPUT_FILE"

# Run the rake task
rake db:generate_seeds JSON_FILE="$OUTPUT_FILE"

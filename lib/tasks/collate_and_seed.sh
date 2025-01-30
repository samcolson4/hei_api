#!/bin/bash

# Ensure at least one file is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 file1.json [file2.json ...]"
    exit 1
fi

# Generate a timestamp
TIMESTAMP=$(date +"%Y_%m_%d_%H_%M_%S")
OUTPUT_DIR="lib/seed_json"
OUTPUT_FILE="${OUTPUT_DIR}/combined_seed_data_${TIMESTAMP}.json"

# Ensure the directory exists
mkdir -p "$OUTPUT_DIR"

# Start the JSON array
echo "[" > "$OUTPUT_FILE"

FIRST=true
for file in "$@"; do
    if [ ! -f "$file" ]; then
        echo "Error: File '$file' not found. Skipping..."
        continue
    fi

    # Extract JSON objects from the array
    while read -r line; do
        if [ "$FIRST" = true ]; then
            FIRST=false
        else
            echo "," >> "$OUTPUT_FILE"  # ✅ Add a comma before new objects
        fi
        echo "$line" >> "$OUTPUT_FILE"
    done < <(jq -c '.[]' "$file")
done

# End the JSON array
echo "]" >> "$OUTPUT_FILE"

# Validate the final JSON
if ! jq empty "$OUTPUT_FILE"; then
    echo "❌ Error: Combined JSON is invalid!"
    exit 1
fi

echo "✅ Combined JSON saved to $OUTPUT_FILE"

# Run the rake task with the timestamped file
rake db:generate_seeds JSON_FILE="$OUTPUT_FILE"

# Seed the db
rails db:seed

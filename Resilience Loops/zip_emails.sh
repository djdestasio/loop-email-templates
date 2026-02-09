#!/bin/bash

# Define paths relative to the script location
SRC_DIR="./emails"
DEST_DIR="./dist"

# 1. Cleanup: Ensure the dist folder is fresh
rm -rf "$DEST_DIR"
mkdir -p "$DEST_DIR"

# 2. Check if the emails directory actually exists
if [ ! -d "$SRC_DIR" ]; then
    echo "❌ Error: Directory $SRC_DIR not found."
    exit 1
fi

echo "🚀 Starting compression from $SRC_DIR..."

# 3. Loop through each subfolder in the emails directory
for dir in "$SRC_DIR"/*/; do
    # Strip the path to get just the folder name
    folder_name=$(basename "$dir")

    echo "📦 Packaging: $folder_name"

    # Enter the directory, zip the contents, and output to dist
    # Using (cd ...) ensures the zip doesn't contain the 'emails/' parent path
    (cd "$dir" && zip -rq "../../$DEST_DIR/$folder_name.zip" .)

done

echo "---"
echo "✅ Done! Your zips are ready in $DEST_DIR"
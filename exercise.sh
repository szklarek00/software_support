#!/bin/bash
dir="/path/to/directory"

if [ ! -d "$dir" ]; then
    echo "Directory $dir not found"
    exit 1
fi

declare -A files_by_key

find "$dir" -type f -print0 | while IFS= read -r -d "" file; do
    if [ -f "$file" ]; then
        size=$(stat -c "%s" "$file" 2>/dev/null)
        if [ $? -eq 0 ]; then
            name=$(basename "$file")
            name="${name%.*}"
            key="${size}_${name}"
            if [ -n "${files_by_key[$key]}" ]; then
                echo "Possible duplicate found: ${files_by_key[$key]} and $file"
            else
                files_by_key[$key]="$file"
            fi
        fi
    fi
done

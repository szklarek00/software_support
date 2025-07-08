#!/bin/bash

dir="/path/to/directory"
 
find "$dir" -type f -print0 | xargs -0 md5sum | sort > /tmp/checker.txt

checksum1=""
file1=""

while read -r checksum file; do
    if [[ "$checksum" == "$checksum1" ]]; then
        echo "Possible duplicate found:"
        echo "    1) $file1"
        echo "    2) $file"
        echo
        read -p "Do you want to delete file 2? (y/n) " answer
        if [[ "$answer" == [Yy] ]]; then
            rm "$file"
            echo "Deleted: $file"
        else
            echo "Skipped deletion."
        fi
        echo
    fi
    checksum1="$checksum"
    file1="$file"
done < /tmp/checker.txt

rm /tmp/checker.txt

#!/bin/bash

EXTENSIONS=("tex" "cls" "sty")

# Reformat files
# -l: Local yaml settings
# -w: Overwrite files
# -s: Silent mode (no output)
for extension in "${EXTENSIONS[@]}";do
    paths=$(find . -name "*.$extension" -type f)
    for path in  $paths; do
        echo "Reformatting $path"
        latexindent -l -w -s "$path"
    done
done

# Clean up files
find . -name "*.bak*" -type f -delete
find . -name "indent.log" -type f -delete

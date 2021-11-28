#!/bin/bash

PATH_BASE="$PWD"
DIRECTORY_BASE=$(basename "$PATH_BASE")
DIRECTORY_PARENT=$(dirname "$PATH_BASE")

TEXMF=$(kpsewhich -var-value=TEXMFHOME)
PATH_TEXMF="${TEXMF}/tex/latex"

mv "$PATH_BASE" "${PATH_TEXMF}/$DIRECTORY_BASE"
texhash ~/texmf

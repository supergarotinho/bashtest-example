#! /bin/bash

# Function to process a string/array: 
#   * Remove binary characters
#   * Converts any sequence of symbols, spaces or tabs into a single space 
#   * Does a trim
#
# Sintax: trataVarcleanVariableiavel variavel
function cleanVariable() {
    ## The first pipe with tr remove binary characters
    ## The second pipe: Converts any sequence of ".,;|", spaces or tabs into a single space.
    ## The third pipe does a trim
    local variable="$1"
    echo "$variable" | tr -cd '\11\12\15\40-\176' | perl -pe 's/[.,;|\s]+/ /g' | perl -pe 's/(^\s+|\s+$)//g'
}

# Logging stuff.
function e_header()   { echo -e "\\n\\033[1m$*\\033[0m"; }
function e_success()  { echo -e " \\033[1;32m✔\\033[0m  $*"; }
function e_error()    { echo -e " \\033[1;31m✖\\033[0m  $*"; }
function e_arrow()    { echo -e " \\033[1;34m➜\\033[0m  $*"; }
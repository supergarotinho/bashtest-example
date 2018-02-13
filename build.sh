#!/bin/sh

# Measure time
start=$SECONDS

# Add color if not
export TERM=xterm-256color

# Removes the coverage folder
rm -rf testes/coverage 2>/dev/null
mkdir testes/coverage

docker run --rm \
  --security-opt seccomp=unconfined \
  -v $(pwd):/source \
  -e "TERM=xterm-256color" supergarotinho/bashtest ./tests.sh

echo "\nRunning spellcheck...\n"

docker run -v "$PWD:/mnt" koalaman/shellcheck ./script.sh

# Para gerar um json e depois juntar no build
# shellcheck -f json myscript myotherscript

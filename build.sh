#!/bin/sh

# Measure time
start=$SECONDS

# Add color if not
export TERM=xterm-256color
# Logging stuff.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $@"; }

# Removes the coverage folder
rm -rf test/coverage 2>/dev/null
mkdir test/coverage

failed=false

kcov="kcov --exclude-path=/root/shunit2,/source/build.sh,/source/test"
coverage_dir="$( dirname "${BASH_SOURCE[0]}")/test/coverage"
kcov_cmd="${kcov} ${coverage_dir}"

e_header "Running unit tests"
# Running unit tests
e_arrow "Running: ./test/unit-tests.sh"
docker run --rm \
  --security-opt seccomp=unconfined \
  -v $(pwd):/source \
  -e "TERM=xterm-256color" supergarotinho/bashtest ./test/unit-tests.sh
result=$?
[ $result -eq 0 ] && e_success "./test/unit-tests.sh passed!"
[ ! $result -eq 0 ] && e_error "./test/unit-tests.sh failed!" && failed=true

for file in ./test/*unit-tests.sh
do
  echo ${file}
done

for file in ./test/*functional-tests.sh
do
  echo ${file}
done

e_header "Running spellcheck..."
for file in ./*.sh
do
  e_arrow "Running spellcheck on: ${file}"
  docker run -v "$PWD:/mnt" koalaman/shellcheck ${file}
  result=$?
  [ $result -eq 0 ] && e_success "${file} passed!"
  [ ! $result -eq 0 ] && e_error "${file} failed!" && failed=true
done

# TO generate a json and then put somewhere in the build
# shellcheck -f json myscript myotherscript

total=$((SECONDS - start))
minutes=$((total / 60))
seconds=$((total % 60))
printf "%d minutes and %02d seconds" ${minutes} ${seconds}

[ ${failed} == "true" ] && exit 1
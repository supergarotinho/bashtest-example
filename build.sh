#!/bin/bash
# Disable:
# * Not following sources
# shellcheck disable=SC1090
# shellcheck disable=SC1091

# Measure time
start=$SECONDS

# Add color if not
export TERM=xterm-256color
# Logging stuff.
function e_header()   { echo -e "\\n\\033[1m$*\\033[0m"; }
function e_success()  { echo -e " \\033[1;32m✔\\033[0m  $*"; }
function e_error()    { echo -e " \\033[1;31m✖\\033[0m  $*"; }
function e_arrow()    { echo -e " \\033[1;34m➜\\033[0m  $*"; }

# Removes the coverage folder
rm -rf test/coverage 2>/dev/null
mkdir -p test/coverage

failed=false

kcov_cmd=(kcov "--exclude-path=/root/shunit2,/source/build.sh,/source/test")
if [[ ! -z "${TRAVIS_JOB_ID}" ]]
then
    kcov_cmd+=("--coveralls-id=${TRAVIS_JOB_ID}")
fi
echo "${kcov_cmd[@]}"
actual_dir=$( dirname "${BASH_SOURCE[0]}")
coverage_dir="${actual_dir}/test/coverage"
kcov_cmd+=("${coverage_dir}")

e_header "Running unit tests"
for file in ./test/*unit-tests.sh
do
    # Running unit tests
    e_arrow "Running: ${file}"
    docker run --rm \
      --security-opt seccomp=unconfined \
      -v "$(pwd)":/source \
      -e "TERM=xterm-256color" supergarotinho/bashtest "${kcov_cmd[@]}" "${file}"
    result=$?
    [ $result -eq 0 ] && e_success "${file} passed!"
    [ ! $result -eq 0 ] && e_error "${file} failed!" && failed=true
done

if [[ ${failed} == "false" ]]
then
    e_header "Running functional tests"
    for file in ./test/*functional-tests.sh
    do
        # Running unit tests
        e_arrow "Running: ${file}"
        docker run --rm \
          --security-opt seccomp=unconfined \
          -v "$(pwd)":/source \
          -e "TERM=xterm-256color" supergarotinho/bashtest "${file}"
        result=$?
        [ $result -eq 0 ] && e_success "${file} passed!"
        [ ! $result -eq 0 ] && e_error "${file} failed!" && failed=true
    done
fi

e_header "Running spellcheck..."
while read -r -u 9
do
    file="${REPLY}"
    e_arrow "Running spellcheck on: ${file}"
    docker run -v "$(pwd)":/mnt koalaman/shellcheck "${file}"
    result=$?
    [ $result -eq 0 ] && e_success "${file} passed!"
    [ ! $result -eq 0 ] && e_error "${file} failed!" && failed=true
done 9< <(find . -type f -not -path "*/coverage/*" -iname "*.sh")

# TO generate a json and then put somewhere in the build

#  -f json myscript myotherscript

total=$((SECONDS - start))
minutes=$((total / 60))
seconds=$((total % 60))
printf "%d minutes and %02d seconds\\n" ${minutes} ${seconds}

if [ "${failed}" == "true" ]
then
  exit 1
fi

#!/bin/bash

printUsage() {
    cat <<EOT
    Uso: ./script [OPTIONS] 
    -h|--help                               - Show this help

    Options:
    [--directory|-d] <path>             - Some required argument
                                          REQUIRED
    [--space-arg|-s] "<arg with spsces> - Some argument with spaces.
                                          Something like, eg: "XML JSON"
                                          OPTIONAL
    [--boolean-arg|-b]                  - Some optional boolean arg
                                          Default: false

EOT
}

#---------------------------------------------------------------------------------------
# This help function displays a pameter invalid error
# Sintax: parametroInvalido "Error message"
invalidParam() {
    echo "$1"
    echo ""
    printUsage
    exit 1    
}

# Default and initial values
EXECUTION_DIR="$( dirname "${BASH_SOURCE[0]}")"
BOOLEAN_ARG=false

# Faz os imports
source "${EXECUTION_DIR}/other-functions.sh"

# Copy the arguments to a new array, to avoid problems with spaces
arguments=()
for argument in "$@"; do
    arguments+=("${argument}")
done

i=0
while [[ $i -lt ${#arguments[@]} ]]
do
    argument="${arguments[$i]}"
    case $argument in
        -d|--directory)
            DIRECTORY="${arguments[$((i+1))]}"
            i=$((i+2))
        ;;
        -b|--boolean-arg)
            BOOLEAN_ARG=true
            i=$((i+1))
        ;;
        -s|--space-arg)
            # This var treatment is optional
            SPACE_ARG="$(cleanVariable "${arguments[$((i+1))]}")"
            i=$((i+2))
        ;;
        -h|--help)
            printUsage
            exit 0
        ;;
        *)
            echo "Unknown option: $argument"
            exit -1
        ;;
    esac
done

# Check for required parameters here.
# If required parameters are not found, display help
if [ -z "${DIRECTORY// }" ]
then
    invalidParam "DIRECTORY not set"
else
    echo "Arguments given:"
    echo "--------------------------------------------"
    e_arrow "DIRECTORY: ${DIRECTORY}"
    e_arrow "BOOLEAN_ARG: ${BOOLEAN_ARG}"
    e_arrow "SPACE_ARG: ${SPACE_ARG}"
    echo "--------------------------------------------"
    echo ""
    e_arrow "[.....] Initiating something..."
    echo
fi

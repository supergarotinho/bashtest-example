#! /bin/bash

# Disable:
# * Not following sources
# shellcheck disable=SC1090
# shellcheck disable=SC1091

testCleanVariable() {
    local expected returned
    expected="test abc qwe"
    returned=$(cleanVariable "   ,test,     abc qwe       . ")

    assertEquals "Expected \"${expected}\", but returned ${returned}" "${expected}" "${returned}"
# Regex optins
#    assertTrue "Expected \"${expected}\", but returned ${returned}" \
#        "[[ ${retorno} =~ ^${SOME_VAR}/\\.\\./${SOME_VAR} ]]"
}

oneTimeSetUp() {
    #source ${DIRETORIO_EXECUCAO}/testes-common.sh
  
    # Inclui o arquivo com as funcões
    local script_dir
    script_dir=$( dirname "${BASH_SOURCE[0]}")
    source "${script_dir}/../src/other-functions.sh"
}

#oneTimeTearDown() {
#    
#}

# Pega o diretório de execução para encontrar e executar o shunit2
. /root/shunit2/shunit2
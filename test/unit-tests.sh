#! /bin/sh

testCleanVariable() {
    local expected="test abc qwe"
    local returned=$(cleanVariable "   ,test,     abc qwe       . ")

    assertEquals "Expected \"${expected}\", but returned ${returned}" "${expected}" "${returned}"
# Regex optins
#    assertTrue "Expected \"${expected}\", but returned ${returned}" \
#        "[[ ${retorno} =~ ^${PADRAO_FONTE}/\\.\\./${PADRAO_REGEX_ARQ_TMP} ]]"
}

oneTimeSetUp() {
    #source ${DIRETORIO_EXECUCAO}/testes-common.sh
  
    # Inclui o arquivo com as funcões
    source $( dirname "${BASH_SOURCE[0]}")/../src/other-functions.sh
}

#oneTimeTearDown() {
#    
#}

# Pega o diretório de execução para encontrar e executar o shunit2
. /root/shunit2/shunit2
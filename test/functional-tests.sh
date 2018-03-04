#!/bin/bash
# vim:et:ft=sh:sts=2:sw=2

# Disable:
# * Not following sources
# shellcheck disable=SC1090
# shellcheck disable=SC1091

# This is called once before any tests are run
oneTimeSetUp()
{
    local coverage_dir kcov_cmd
    kcov_cmd=(kcov "--exclude-path=/root/shunit2,/source/build.sh,/source/test")
    coverage_dir="/source/test/coverage"
    kcov_cmd+=("${coverage_dir}")

    script="${kcov_cmd[*]} /source/src/script.sh"
}

#-----------------------------------------------------------------------------
# suite tests
# All tests should check:
#  return value
#  stdout, stderr
#  and any files created

testRunWithNoParameters()
{
    ${script} >/dev/null
    rtrn=$?

    assertTrue "Expected returned value of 1, but got ${rtrn}." "[ ${rtrn} -eq 1 ]"
}

testInvalidOption()
{
    ${script} -a >/dev/null
    rtrn=$?

    assertTrue "Expected 255, but got ${rtrn}." "[ ${rtrn} -eq 255 ]"
}

testWithDir()
{
    ${script} -d directory >/dev/null
    rtrn=$?

    assertTrue "Expected 0, but got ${rtrn}." "[ ${rtrn} -eq 0 ]"
}

testWithHelp()
{
    ${script} --help >/dev/null
    rtrn=$?

    assertTrue "Expected 0, but got ${rtrn}." "[ ${rtrn} -eq 0 ]"
}

testParameterCombinations() {
    while read -r description with_dir with_space_args with_boolean_arg ok; do
        local arguments=()
        [[ ${with_sdir} -eq ${SHUNIT_TRUE} ]] && arguments+=("-d") && arguments+=("./directory")
        [[ ${with_space_args} -eq ${SHUNIT_TRUE} ]] && arguments+=("-s") && arguments+=("space arg")
        [[ ${with_boolean_arg} -eq ${SHUNIT_TRUE} ]] && arguments+=("-b")

        ${script} "${arguments[@]}" > /dev/null
        local return=$?

        # Teste se o retorno bate com o retorno esperado para o cenário
        assertEquals "$description: expected ${ok}. Received: ${return}" "${ok}" "${return}"
    done << EOF
With_dir_and_boolean ${SHUNIT_TRUE} ${SHUNIT_FALSE} ${SHUNIT_TRUE} 0
With_dir_and_space ${SHUNIT_TRUE} ${SHUNIT_TRUE} ${SHUNIT_FALSE} 0
Without_dir_and_boolean ${SHUNIT_FALSE} ${SHUNIT_FALSE} ${SHUNIT_TRUE} 1
Without_dir_and_space ${SHUNIT_FALSE} ${SHUNIT_TRUE} ${SHUNIT_FALSE} 1
Without_dir_and_wiht_space_and_boolean ${SHUNIT_FALSE} ${SHUNIT_TRUE} ${SHUNIT_TRUE} 1
EOF
    # limpa as variáveis locais
    #unset fonte extensoes extensoes_teste
}


# load and run shUnit2
#[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. /root/shunit2/shunit2

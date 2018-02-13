#!/bin/sh
# vim:et:ft=sh:sts=2:sw=2

# Disable:
# * Not following sources
# shellcheck disable=SC1090
# shellcheck disable=SC1091

# This is called once before any tests are run
oneTimeSetUp()
{
    # Coverage is on the build.sh because we can have multiple test scripts to run
    #rm -rf coverage 2>/dev/null
    #mkdir coverage
    kcov_cmd=(kcov "--exclude-path=/root/shunit2,/source/build.sh,/source/test")
    coverage_dir="/source/test/coverage"
    kcov_cmd+="${coverage_dir}"

    script="${kcov_cmd[@]} /source/script.sh"
    unset coverage_dir kcov_cmd
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

    assertTrue "Expected returned value of 0, but got ${rtrn}." "[ ${rtrn} -eq 0 ]"
}

testInvalidOption()
{
    ${script} -a >/dev/null
    rtrn=$?

    assertTrue "Expected 255, but got ${rtrn}." "[ ${rtrn} -eq 255 ]"
}

testSample()
{
    ${script} -d directory >/dev/null
    rtrn=$?

    assertTrue "Expected 0, but got ${rtrn}." "[ ${rtrn} -eq 0 ]"
}

# load and run shUnit2
#[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. /root/shunit2/shunit2

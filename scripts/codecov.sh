#!/bin/bash
set -eEuo pipefail
cd "$(dirname "$(readlink -f "$0")")"

source bash-buddy/lib/trap_error_info.sh
source bash-buddy/lib/common_utils.sh

################################################################################
# prepare
################################################################################

# shellcheck disable=SC2034
PREPARE_JDKS_INSTALL_BY_SDKMAN=(
    8.322.06.2-amzn
    11.0.14-ms
    17.0.2.8.1-amzn
)

source bash-buddy/lib/prepare_jdks.sh

source bash-buddy/lib/java_build_utils.sh

################################################################################
# codecov logic
################################################################################

cd ..

export DCM_AGENT_SUPRESS_EXCEPTION_STACK=true

prepare_jdks::switch_java_home_to_jdk 11
jvb::mvn_cmd -Pgen-code-cov clean test jacoco:report

prepare_jdks::switch_java_home_to_jdk 8
# use -Dmaven.main.skip option fix below problem of jacoco-maven-plugin:report :
#
# [WARNING] Classes in bundle 'Java Dns Cache Manipulator(DCM) Lib' do not match with execution data.
#           For report generation the same class files must be used as at runtime.
# [WARNING] Execution data for class com/alibaba/xxx/Yyy does not match.
jvb::mvn_cmd -Pgen-code-cov -Dmaven.main.skip test jacoco:report coveralls:report

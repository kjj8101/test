#!/bin/sh

# Change IS_DIR and JVM_DIR to reflect their locations on your system
# Note: The JVM must have the JCE extension
# 
# --- LOCATION OF WEBMETHODS INTEGRATION SERVER ---

DIRNAME=`dirname $0`

ROOT_DIR=$DIRNAME/../../../../../..

IS_DIR=$ROOT_DIR/IntegrationServer
JVM_DIR=$ROOT_DIR/jvm/jvm
IS_INSTANCE_DIR=$DIRNAME/../../..
DEP_INSTANCE_PACKAGE=$DIRNAME/..

export IS_DIR
export JVM_DIR
export IS_INSTANCE_DIR
export DEP_INSTANCE_PACKAGE

if [ -z "$1" ]
then
	echo "Please provide an input XML file. For information on how to create the XML file please refer to documentation"
else
${JVM_DIR}/bin/java -Dserver.install.dir=${IS_INSTANCE_DIR} -classpath "${IS_DIR}/lib/wm-isserver.jar:${DEP_INSTANCE_PACKAGE}/lib/CLI.jar:${DEP_INSTANCE_PACKAGE}/lib/projectautomator.jar:${DEP_INSTANCE_PACKAGE}/code/classes:${IS_DIR}/../common/lib/ext/commons-cli.jar:${IS_DIR}/../common/lib/wm-isclient.jar:${IS_DIR}/../common/lib/glassfish/gf.javax.mail.jar:${IS_DIR}/../common/lib/ext/xml-apis.jar:${IS_DIR}/../common/lib/ext/xercesImpl.jar:${IS_DIR}/../common/lib/ext/log4j.jar:${IS_DIR}/../common/lib/ext/enttoolkit.jar:${IS_DIR}/../common/lib/wm-scg-security.jar:${IS_DIR}/../common/lib/wm-scg-core.jar:${IS_DIR}/../common/lib/wm-g11nutils.jar" com.softwareag.webm.deployer.automation.MainClass "$@" "${DEP_INSTANCE_PACKAGE}/config/ProjectAutomatorForRuntime.xsd" "${DEP_INSTANCE_PACKAGE}/config/ProjectAutomatorForRepository.xsd" "$DIRNAME/log4j.properties" 0
fi


returnValue=$?
if [ $returnValue -ne 0 ];
then 
  echo Error Code = $returnValue
fi  

exit $returnValue
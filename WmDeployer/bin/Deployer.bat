@echo off

set DIRNAME=%~dp0
set ROOT_DIR=%DIRNAME%\..\..\..\..\..\..

set IS_DIR=%ROOT_DIR%\IntegrationServer
set JVM_DIR=%ROOT_DIR%\jvm\jvm
set DEP_INSTANCE_PACKAGE=%DIRNAME%\..

IF [%1]==[] ( "%JVM_DIR%\bin\java" -classpath "%IS_DIR%\..\common\lib\wm-scg-security.jar;%IS_DIR%\..\common\lib\wm-scg-core.jar;%DEP_INSTANCE_PACKAGE%/lib/CLI.jar;%DEP_INSTANCE_PACKAGE%/code/classes;%IS_DIR%/../common/lib/ext/commons-cli.jar;%IS_DIR%\..\common\lib\wm-isclient.jar;%IS_DIR%\..\common\lib\glassfish\gf.javax.mail.jar;%IS_DIR%\..\common\lib\ext\log4j.jar;%IS_DIR%/../common/lib/ext/enttoolkit.jar;%DIRNAME%\log4j.properties;%IS_DIR%\packages\WmDeployer\bin" com.wm.deployer.CLI.MainClass "--usage" ) ELSE ( "%JVM_DIR%\bin\java" -classpath "%IS_DIR%\..\common\lib\wm-scg-security.jar;%IS_DIR%\..\common\lib\wm-scg-core.jar;%DEP_INSTANCE_PACKAGE%/lib/CLI.jar;%DEP_INSTANCE_PACKAGE%/code/classes;%IS_DIR%/../common/lib/ext/commons-cli.jar;%IS_DIR%\..\common\lib\wm-isclient.jar;%IS_DIR%\..\common\lib\glassfish\gf.javax.mail.jar;%IS_DIR%\..\common\lib\ext\log4j.jar;%IS_DIR%/../common/lib/ext/enttoolkit.jar;%DEP_INSTANCE_PACKAGE%\bin;%DIRNAME%\log4j.properties" com.wm.deployer.CLI.MainClass %* )

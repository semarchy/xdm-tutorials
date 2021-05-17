CATALINA_OPTS="$CATALINA_OPTS -Dxdm.show.stacktrace.jsp.error=true -server -XX:+UseG1GC -Dorg.apache.cxf.Logger=org.apache.cxf.common.logging.Slf4jLogger -Duser.language=en -Duser.country=US -Djava.awt.headless=true"

#Configuration file
CATALINA_OPTS="$CATALINA_OPTS -Dxdm.config.file=../conf/config.properties"

#JAVA_HOME
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.11.jdk/Contents/Home

#Setup Token (initial setup only)
export SEMARCHY_SETUP_TOKEN=mySetupToken
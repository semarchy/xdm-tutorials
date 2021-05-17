set "CATALINA_OPTS=%CATALINA_OPTS% -Xmx512M -server -XX:+UseG1GC"
set "CATALINA_OPTS=%CATALINA_OPTS% -Dorg.apache.cxf.Logger=org.apache.cxf.common.logging.Slf4jLogger -Dorg.ops4j.pax.logging.DefaultServiceLog.level=WARN -Duser.language=en -Duser.country=US -Djava.awt.headless=true"

rem Configuration file
set "CATALINA_OPTS=%CATALINA_OPTS% -Dxdm.config.file=..\conf\config.properties"

rem JAVA_HOME
set "JAVA_HOME=C:\Program Files\Java\jdk-11.0.5"

rem Setup Token (initial setup only)
set SEMARCHY_SETUP_TOKEN=mySetupToken
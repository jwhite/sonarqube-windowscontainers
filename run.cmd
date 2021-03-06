set SONARQUBE_CE_OPTS=-Dsonar.cs.javaAdditionalOpts="%SONARQUBE_CE_OPTS%"
set SONARQUBE_WEB_JVM_OPTS=-Dsonar.web.java.AdditionalOpts="%SONARQUBE_WEB_JVM_OPTS%"
set SONAR_SCANNER_OPTS=%SONAR_SCANNER_OPTS%


if not "%SONARQUBE_JDBC_URL%" == "http://foo.com" ( 
java -jar lib/sonar-application-%SONAR_VERSION%.jar -Dsonar.log.console=true -Dsonar.jdbc.username="%SONARQUBE_JDBC_USERNAME%" -Dsonar.jdbc.password="%SONARQUBE_JDBC_PASSWORD%" -Dsonar.jdbc.url="%SONARQUBE_JDBC_URL%" %SONARQUBE_WEB_JVM_OPTS% %SONARQUBE_CE_OPTS% -Djava.security.egd=file:/dev/./urandom" 
) else (	
java -jar lib/sonar-application-%SONAR_VERSION%.jar -Dsonar.log.console=true %SONARQUBE_WEB_JVM_OPTS% %SONARQUBE_CE_OPTS% -Djava.security.egd=file:/dev/./urandom" 
)

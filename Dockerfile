FROM nilleb/openjdk-for-windows

MAINTAINER Jeremy White <sail.madeline@gmail.com>

ENV SONAR_CPPVERSION 0.9.7
ENV SONAR_VERSION 6.2
 
ENV	SONARQUBE_HOME c:\\sonarqube 
    # Database configuration
    # Defaults to using H2
ENV SONARQUBE_JDBC_USERNAME sonar 
ENV SONARQUBE_JDBC_PASSWORD sonar 
ENV SONARQUBE_JDBC_URL http://foo.com

# Http port
EXPOSE 9000

RUN powershell Invoke-WebRequest -outfile sonarqube.zip -uri https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-%SONAR_VERSION%.zip 
RUN powershell "Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('sonarqube.zip', 'c:\')" 
RUN powershell  move sonarqube-%SONAR_VERSION% sonarqube && del sonarqube.zip \
    && del %SONARQUBE_HOME%\\data\\README.txt \
    && for /d %x in (%SONARQUBE_HOME%\\bin\\*) do @rd /s /q "%x" 
	
	# install C++ plugin
RUN powershell Invoke-WebRequest -outfile sonar-cxx.jar -uri https://github.com/SonarOpenCommunity/sonar-cxx/releases/download/cxx-%SONAR_CPPVERSION%/sonar-cxx-plugin-%SONAR_CPPVERSION%.jar
RUN powershell mkdir sonarqube/extensions/downloads
RUN powershell cp sonar-cxx.jar sonarqube/extensions/downloads/sonar-cxx.jar


WORKDIR C:/sonarqube
COPY run.cmd C:/sonarqube/bin/
ENTRYPOINT ["C:\\sonarqube\\bin\\run.cmd"]
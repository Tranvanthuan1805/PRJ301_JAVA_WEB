@echo off
set JAVA_HOME=C:\Program Files\Java\jdk-17
set CATALINA_HOME=C:\apache-tomcat-10.1.50
set JRE_HOME=%JAVA_HOME%
set CATALINA_OPTS=-Dfile.encoding=UTF-8 -Dfile.io.encoding=UTF-8
set JAVA_OPTS=-Dfile.encoding=UTF-8
call C:\apache-tomcat-10.1.50\bin\startup.bat
echo Tomcat started! http://localhost:8080/DaNangTravelHub

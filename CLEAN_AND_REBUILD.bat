@echo off
echo ========================================
echo Cleaning Maven Build and Tomcat Cache
echo ========================================

echo.
echo [1/4] Cleaning Maven build...
call mvn clean

echo.
echo [2/4] Deleting target directory...
if exist target rmdir /s /q target

echo.
echo [3/4] Rebuilding project...
call mvn package -DskipTests

echo.
echo [4/4] Done!
echo.
echo IMPORTANT: Now you need to:
echo 1. Stop Tomcat server
echo 2. Delete Tomcat work directory: [TOMCAT_HOME]\work\Catalina\localhost\DaNangTravelHub
echo 3. Delete deployed WAR: [TOMCAT_HOME]\webapps\DaNangTravelHub.war
echo 4. Delete deployed folder: [TOMCAT_HOME]\webapps\DaNangTravelHub
echo 5. Copy new WAR from target\DaNangTravelHub.war to [TOMCAT_HOME]\webapps\
echo 6. Start Tomcat server
echo.
pause

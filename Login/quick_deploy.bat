@echo off
echo ========================================
echo Quick Deploy Explore Module
echo ========================================

set JAVA_HOME=C:\Program Files\Java\jdk-17
set TOMCAT_HOME=C:\Program Files\Apache Software Foundation\Tomcat 10.1
set PROJECT_DIR=%~dp0
set DEPLOY_DIR=%TOMCAT_HOME%\webapps\Login

echo.
echo Creating directories...
if not exist "%DEPLOY_DIR%\WEB-INF\classes\controller" mkdir "%DEPLOY_DIR%\WEB-INF\classes\controller"
if not exist "%DEPLOY_DIR%\jsp" mkdir "%DEPLOY_DIR%\jsp"

echo.
echo Compiling ExploreServlet.java...
"%JAVA_HOME%\bin\javac" -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;%DEPLOY_DIR%\WEB-INF\classes" -d "%DEPLOY_DIR%\WEB-INF\classes" "%PROJECT_DIR%src\java\controller\ExploreServlet.java"

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to compile ExploreServlet.java
    pause
    exit /b 1
)

echo.
echo Compiling TourDetailServlet.java...
"%JAVA_HOME%\bin\javac" -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;%DEPLOY_DIR%\WEB-INF\classes" -d "%DEPLOY_DIR%\WEB-INF\classes" "%PROJECT_DIR%src\java\controller\TourDetailServlet.java"

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to compile TourDetailServlet.java
    pause
    exit /b 1
)

echo.
echo Copying JSP files...
copy /Y "%PROJECT_DIR%web\explore.jsp" "%DEPLOY_DIR%\"
copy /Y "%PROJECT_DIR%web\jsp\tour-detail.jsp" "%DEPLOY_DIR%\jsp\"

echo.
echo ========================================
echo Deploy complete!
echo ========================================
echo.
echo Tomcat will auto-reload the changes
echo Try accessing: http://localhost:8080/Login/explore
echo.
pause

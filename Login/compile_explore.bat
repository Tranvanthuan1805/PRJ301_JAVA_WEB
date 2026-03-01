@echo off
echo ========================================
echo Compiling Explore Module
echo ========================================

set JAVA_HOME=C:\Program Files\Java\jdk-17
set TOMCAT_HOME=C:\Program Files\Apache Software Foundation\Tomcat 10.1
set PROJECT_DIR=%~dp0

echo.
echo Compiling ExploreServlet.java...
"%JAVA_HOME%\bin\javac" -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;%PROJECT_DIR%build\web\WEB-INF\classes" -d "%PROJECT_DIR%build\web\WEB-INF\classes" "%PROJECT_DIR%src\java\controller\ExploreServlet.java"

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to compile ExploreServlet.java
    pause
    exit /b 1
)

echo.
echo Compiling TourDetailServlet.java...
"%JAVA_HOME%\bin\javac" -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;%PROJECT_DIR%build\web\WEB-INF\classes" -d "%PROJECT_DIR%build\web\WEB-INF\classes" "%PROJECT_DIR%src\java\controller\TourDetailServlet.java"

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to compile TourDetailServlet.java
    pause
    exit /b 1
)

echo.
echo ========================================
echo Compilation successful!
echo ========================================
echo.
echo Now copying to Tomcat...

xcopy /Y /Q "%PROJECT_DIR%build\web\WEB-INF\classes\controller\ExploreServlet.class" "%TOMCAT_HOME%\webapps\Login\WEB-INF\classes\controller\"
xcopy /Y /Q "%PROJECT_DIR%build\web\WEB-INF\classes\controller\TourDetailServlet.class" "%TOMCAT_HOME%\webapps\Login\WEB-INF\classes\controller\"

echo.
echo Copying JSP files...
xcopy /Y /Q "%PROJECT_DIR%web\explore.jsp" "%TOMCAT_HOME%\webapps\Login\"
xcopy /Y /Q "%PROJECT_DIR%web\jsp\tour-detail.jsp" "%TOMCAT_HOME%\webapps\Login\jsp\"

echo.
echo ========================================
echo Deploy complete!
echo ========================================
echo.
echo Please restart Tomcat or wait for auto-reload
pause

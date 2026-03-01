@echo off
setlocal enabledelayedexpansion

set TOMCAT=C:\Program Files\Apache Software Foundation\Tomcat 10.1
set CLASSES=%TOMCAT%\webapps\Login\WEB-INF\classes

echo Compiling ExploreServlet...
javac -cp "%TOMCAT%\lib\servlet-api.jar;%CLASSES%" -d "%CLASSES%" src\java\controller\ExploreServlet.java

if %ERRORLEVEL% EQU 0 (
    echo SUCCESS: ExploreServlet compiled
) else (
    echo FAILED: ExploreServlet compilation failed
    pause
    exit /b 1
)

echo.
echo Compiling TourDetailServlet...
javac -cp "%TOMCAT%\lib\servlet-api.jar;%CLASSES%" -d "%CLASSES%" src\java\controller\TourDetailServlet.java

if %ERRORLEVEL% EQU 0 (
    echo SUCCESS: TourDetailServlet compiled
) else (
    echo FAILED: TourDetailServlet compilation failed
    pause
    exit /b 1
)

echo.
echo Copying JSP files...
copy /Y web\explore.jsp "%TOMCAT%\webapps\Login\"
copy /Y web\jsp\tour-detail.jsp "%TOMCAT%\webapps\Login\jsp\"

echo.
echo ========================================
echo DEPLOYMENT COMPLETE!
echo ========================================
echo.
echo Access at: http://localhost:8080/Login/explore
echo.
pause

@echo off
chcp 65001 >nul
echo ========================================
echo XÓA CACHE TOMCAT - FIX LOGIN
echo ========================================
echo.
echo Bước 1: Dừng Tomcat
echo ----------------------------------------
echo Trong NetBeans:
echo 1. Click tab "Services"
echo 2. Expand "Servers"
echo 3. Click chuột phải vào "Apache Tomcat"
echo 4. Chọn "Stop"
echo.
pause
echo.
echo Bước 2: Xóa cache
echo ----------------------------------------
echo Tìm thư mục Tomcat của bạn, thường ở:
echo C:\Program Files\Apache Software Foundation\Tomcat 10.1\
echo.
echo Xóa các thư mục sau:
echo 1. Tomcat\work\Catalina\localhost\Login\
echo 2. Tomcat\webapps\Login\
echo 3. Tomcat\webapps\Login.war
echo.
echo Hoặc chạy lệnh (thay đổi đường dẫn Tomcat của bạn):
echo.
echo rmdir /s /q "C:\Program Files\Apache Software Foundation\Tomcat 10.1\work\Catalina\localhost\Login"
echo rmdir /s /q "C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\Login"
echo del "C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\Login.war"
echo.
pause
echo.
echo Bước 3: Clean and Build project
echo ----------------------------------------
echo Trong NetBeans:
echo 1. Click chuột phải vào project "Login"
echo 2. Chọn "Clean and Build"
echo.
pause
echo.
echo Bước 4: Khởi động lại Tomcat và Deploy
echo ----------------------------------------
echo Trong NetBeans:
echo 1. Click chuột phải vào project "Login"
echo 2. Chọn "Run" (F6)
echo.
pause
echo.
echo ========================================
echo HOÀN TẤT - THỬ ĐĂNG NHẬP
echo ========================================
echo.
echo Bây giờ thử đăng nhập với:
echo.
echo ADMIN:
echo   Username: admin1
echo   Password: 123456
echo.
echo USER:
echo   Username: an
echo   Password: 123456
echo.
start http://localhost:8080/Login/login.jsp
pause

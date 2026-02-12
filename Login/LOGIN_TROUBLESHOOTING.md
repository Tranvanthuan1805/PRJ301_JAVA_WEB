# Login Troubleshooting Guide

## Database Verification ✅

All accounts are correctly set up in the database:

### ADMIN Account
- Username: `admin1`
- Password: `123456`
- Role: ADMIN
- Expected redirect: `/admin/customers`

### USER Accounts
- Username: `an` / Password: `123456` → Customer: Nguyễn Văn An
- Username: `binh` / Password: `123456` → Customer: Trần Thị Bình
- Username: `cuong` / Password: `123456` → Customer: Lê Hoàng Cường
- Username: `dung` / Password: `123456` → Customer: Phạm Thị Dung
- Username: `em` / Password: `123456` → Customer: Hoàng Văn Em
- Username: `phuong` / Password: `123456` → Customer: Võ Thị Phương
- Username: `giang` / Password: `123456` → Customer: Đặng Văn Giang
- Username: `hoa` / Password: `123456` → Customer: Bùi Thị Hoa
- Username: `inh` / Password: `123456` → Customer: Ngô Văn Inh
- Username: `kim` / Password: `123456` → Customer: Dương Thị Kim

All USER accounts redirect to: `/user.jsp`

## Password Hash
SHA-256 hash of "123456": `8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92`

## If Login Still Doesn't Work

### Step 1: Clean and Rebuild
```bash
# In NetBeans:
1. Right-click project → Clean and Build
2. Stop Tomcat server
3. Start Tomcat server
4. Try login again
```

### Step 2: Clear Tomcat Cache
```bash
# Run this batch file:
CLEAR_TOMCAT_CACHE.bat

# Or manually:
1. Stop Tomcat
2. Delete: C:\apache-tomcat-9.0.XX\work\Catalina\localhost\Login
3. Delete: C:\apache-tomcat-9.0.XX\webapps\Login
4. Start Tomcat
5. Redeploy project
```

### Step 3: Check Tomcat Console Logs
When you try to login, check the Tomcat console for these debug messages:

```
>>> Connected DB = AdminUser
>>> JDBC URL = jdbc:sqlserver://localhost:1433;...
LOGIN USER = an
HASH = 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92
>>> LOGIN MATCH OK for an
```

If you see "LOGIN NOT MATCH", the issue is with the database query.
If you don't see any logs, the servlet is not being called.

### Step 4: Test Direct Servlet Access
Try accessing: `http://localhost:8080/Login/login`
- Should redirect to `login.jsp`
- If you get 404, the servlet mapping is broken

### Step 5: Check Browser Console
Open browser DevTools (F12) → Network tab
- Submit login form
- Check if POST request goes to `/Login/login`
- Check response status (should be 302 redirect or 200)

### Step 6: Verify Database Connection
The application should print this on startup:
```
>>> SQLServer JDBC Driver loaded OK
```

If you don't see this, the JDBC driver is missing from `WEB-INF/lib/`.

## Common Issues

### Issue 1: "Username phải 3-20 ký tự"
- This validation error means the username is too short or too long
- Use short usernames: `an`, `binh`, `cuong` (NOT email addresses)

### Issue 2: "Sai tài khoản hoặc mật khẩu"
- Check Tomcat console for debug logs
- Verify password is exactly `123456` (no spaces)
- Run `VERIFY_LOGIN_ACCOUNTS.sql` to check database

### Issue 3: Login form doesn't submit
- Check browser console for JavaScript errors
- Verify form action is `action="login"` (relative path)
- Check if EncodingFilter is interfering

### Issue 4: Redirect doesn't work
- Check if session is created: `session.getAttribute("user")`
- Verify AuthFilter is not blocking the redirect
- Check Tomcat logs for redirect URL

## Quick Test

1. Open: `http://localhost:8080/Login/login.jsp`
2. Enter: `an` / `123456`
3. Click Login
4. Should redirect to: `http://localhost:8080/Login/user.jsp`
5. Should see: "Xin chào, an" or similar

For ADMIN test:
1. Enter: `admin1` / `123456`
2. Should redirect to: `http://localhost:8080/Login/admin/customers`
3. Should see customer list

## Files to Check

- `Login/src/java/servlet/LoginServlet.java` - Login logic
- `Login/src/java/dao/UserDAO.java` - Database query
- `Login/src/java/util/ValidateUtil.java` - Validation rules
- `Login/src/java/util/DBUtil.java` - Database connection
- `Login/web/login.jsp` - Login form
- `Login/web/WEB-INF/web.xml` - Servlet configuration

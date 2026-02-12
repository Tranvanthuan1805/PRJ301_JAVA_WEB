-- =============================================
-- VERIFY LOGIN ACCOUNTS
-- =============================================

USE AdminUser;
GO

PRINT '========================================';
PRINT 'VERIFYING LOGIN ACCOUNTS';
PRINT '========================================';
PRINT '';

-- Check if Roles exist
PRINT '1. Checking Roles...';
SELECT RoleId, RoleName FROM Roles;
PRINT '';

-- Check ADMIN account
PRINT '2. Checking ADMIN account (admin1)...';
SELECT u.UserId, u.Username, u.PasswordHash, r.RoleName, u.IsActive
FROM Users u
JOIN Roles r ON u.RoleId = r.RoleId
WHERE u.Username = 'admin1';
PRINT '';

-- Check USER accounts
PRINT '3. Checking USER accounts (an, binh, cuong)...';
SELECT u.UserId, u.Username, u.PasswordHash, r.RoleName, u.IsActive
FROM Users u
JOIN Roles r ON u.RoleId = r.RoleId
WHERE u.Username IN ('an', 'binh', 'cuong')
ORDER BY u.Username;
PRINT '';

-- Check if Customers have matching emails
PRINT '4. Checking Customers with matching emails...';
SELECT c.id, c.full_name, c.email, c.phone, c.status
FROM Customers c
WHERE c.email IN ('an', 'binh', 'cuong')
ORDER BY c.id;
PRINT '';

-- Check Users-Customers link
PRINT '5. Checking Users-Customers link...';
SELECT u.Username, c.full_name, c.email, c.phone, c.status
FROM Users u
LEFT JOIN Customers c ON u.Username = c.email
WHERE u.Username IN ('an', 'binh', 'cuong', 'admin1')
ORDER BY u.Username;
PRINT '';

PRINT '========================================';
PRINT 'TEST CREDENTIALS';
PRINT '========================================';
PRINT '';
PRINT 'ADMIN Account:';
PRINT '  Username: admin1';
PRINT '  Password: 123456';
PRINT '  Expected: Redirect to /admin/customers';
PRINT '';
PRINT 'USER Accounts (any of these):';
PRINT '  Username: an       Password: 123456';
PRINT '  Username: binh     Password: 123456';
PRINT '  Username: cuong    Password: 123456';
PRINT '  Expected: Redirect to /user.jsp';
PRINT '';
PRINT 'Password Hash (SHA-256 of "123456"):';
PRINT '  8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92';
PRINT '';

GO

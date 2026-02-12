-- =============================================
-- CREATE SHORT USERNAME ACCOUNTS - FINAL VERSION
-- =============================================
-- This script creates user accounts with short usernames
-- that can be used to login to the system.
-- All passwords are: 123456
-- =============================================

USE AdminUser;
GO

PRINT '========================================';
PRINT 'CREATING LOGIN ACCOUNTS';
PRINT '========================================';
PRINT '';

-- Step 1: Delete old accounts if they exist
PRINT 'Step 1: Cleaning up old accounts...';
DELETE FROM Users WHERE Username IN ('an', 'binh', 'cuong', 'dung', 'em', 'phuong', 'giang', 'hoa', 'inh', 'kim', 'admin1');
PRINT '✓ Old accounts deleted';
PRINT '';

-- Step 2: Create ADMIN account
PRINT 'Step 2: Creating ADMIN account...';
INSERT INTO Users (Username, PasswordHash, RoleId, IsActive, CreatedAt)
VALUES ('admin1', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, 1, GETDATE());
PRINT '✓ ADMIN account created: admin1 / 123456';
PRINT '';

-- Step 3: Create USER accounts
PRINT 'Step 3: Creating USER accounts...';
INSERT INTO Users (Username, PasswordHash, RoleId, IsActive, CreatedAt)
VALUES 
('an', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('binh', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('cuong', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('dung', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('em', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('phuong', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('giang', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('hoa', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('inh', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('kim', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE());
PRINT '✓ 10 USER accounts created';
PRINT '';

-- Step 4: Update Customers to match usernames
PRINT 'Step 4: Linking Customers to Users...';
UPDATE Customers SET email = 'an' WHERE id = 1;
UPDATE Customers SET email = 'binh' WHERE id = 2;
UPDATE Customers SET email = 'cuong' WHERE id = 3;
UPDATE Customers SET email = 'dung' WHERE id = 4;
UPDATE Customers SET email = 'em' WHERE id = 5;
UPDATE Customers SET email = 'phuong' WHERE id = 6;
UPDATE Customers SET email = 'giang' WHERE id = 7;
UPDATE Customers SET email = 'hoa' WHERE id = 8;
UPDATE Customers SET email = 'inh' WHERE id = 9;
UPDATE Customers SET email = 'kim' WHERE id = 10;
PRINT '✓ Customer emails updated to match usernames';
PRINT '';

-- Step 5: Verify setup
PRINT '========================================';
PRINT 'VERIFICATION';
PRINT '========================================';
PRINT '';

PRINT 'Users created:';
SELECT u.Username, r.RoleName, u.IsActive
FROM Users u
JOIN Roles r ON u.RoleId = r.RoleId
WHERE u.Username IN ('admin1', 'an', 'binh', 'cuong', 'dung', 'em', 'phuong', 'giang', 'hoa', 'inh', 'kim')
ORDER BY r.RoleId, u.Username;
PRINT '';

PRINT 'Users-Customers link:';
SELECT u.Username, c.full_name, c.email, c.status
FROM Users u
LEFT JOIN Customers c ON u.Username = c.email
WHERE u.Username IN ('an', 'binh', 'cuong', 'dung', 'em')
ORDER BY u.Username;
PRINT '';

-- Step 6: Display login credentials
PRINT '========================================';
PRINT 'LOGIN CREDENTIALS';
PRINT '========================================';
PRINT '';
PRINT 'ADMIN Account:';
PRINT '  Username: admin1';
PRINT '  Password: 123456';
PRINT '  Access: /admin/customers (Customer Management)';
PRINT '';
PRINT 'USER Accounts (all passwords: 123456):';
PRINT '  an     → Nguyễn Văn An';
PRINT '  binh   → Trần Thị Bình';
PRINT '  cuong  → Lê Hoàng Cường';
PRINT '  dung   → Phạm Thị Dung';
PRINT '  em     → Hoàng Văn Em';
PRINT '  phuong → Võ Thị Phương';
PRINT '  giang  → Đặng Văn Giang';
PRINT '  hoa    → Bùi Thị Hoa';
PRINT '  inh    → Ngô Văn Inh';
PRINT '  kim    → Dương Thị Kim';
PRINT '  Access: /user.jsp and /profile';
PRINT '';
PRINT '========================================';
PRINT 'SETUP COMPLETE!';
PRINT '========================================';
PRINT '';
PRINT 'Next steps:';
PRINT '1. Clean and Build project in NetBeans';
PRINT '2. Run CLEAR_TOMCAT_CACHE.bat if needed';
PRINT '3. Deploy and test login';
PRINT '';

GO

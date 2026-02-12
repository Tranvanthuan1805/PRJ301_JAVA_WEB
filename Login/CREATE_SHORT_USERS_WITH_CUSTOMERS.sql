-- =============================================
-- CREATE SHORT USERNAME USERS LINKED TO CUSTOMERS
-- =============================================

USE AdminUser;
GO

PRINT 'Creating users with short usernames linked to customers...';
PRINT '';

-- Delete old short users
DELETE FROM Users WHERE Username IN ('an', 'binh', 'cuong', 'dung', 'em', 'phuong', 'giang', 'hoa', 'inh', 'kim');

-- Password: 123456 (SHA-256 hash)
-- RoleId: 2 = USER

-- Insert users with short usernames
-- Note: These users will NOT have matching Customers by email
-- But we'll document which customer they represent

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

PRINT '✓ Created 10 users with short usernames';
PRINT '';

-- Now update Customers to use short usernames as email
-- This will allow ProfileServlet to find customers by username

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

PRINT '✓ Updated customer emails to match short usernames';
PRINT '';

-- Display results
PRINT '========================================';
PRINT 'SETUP COMPLETED!';
PRINT '========================================';
PRINT '';
PRINT 'Login credentials (all passwords: 123456):';
PRINT '';
PRINT 'Username: an     | Customer: Nguyễn Văn An';
PRINT 'Username: binh   | Customer: Trần Thị Bình';
PRINT 'Username: cuong  | Customer: Lê Hoàng Cường';
PRINT 'Username: dung   | Customer: Phạm Thị Dung';
PRINT 'Username: em     | Customer: Hoàng Văn Em';
PRINT 'Username: phuong | Customer: Võ Thị Phương';
PRINT 'Username: giang  | Customer: Đặng Văn Giang';
PRINT 'Username: hoa    | Customer: Bùi Thị Hoa';
PRINT 'Username: inh    | Customer: Ngô Văn Inh';
PRINT 'Username: kim    | Customer: Dương Thị Kim';
PRINT '';
PRINT 'Now you can:';
PRINT '1. Login with short username (e.g., "an" / "123456")';
PRINT '2. Access /profile to see customer info';
PRINT '3. Admin can see all customers in /admin/customers';
PRINT '';

-- Verify
SELECT u.Username, c.full_name, c.phone, c.status
FROM Users u
JOIN Customers c ON u.Username = c.email
WHERE u.RoleId = 2 AND u.Username IN ('an', 'binh', 'cuong', 'dung', 'em', 'phuong', 'giang', 'hoa', 'inh', 'kim')
ORDER BY c.id;

GO

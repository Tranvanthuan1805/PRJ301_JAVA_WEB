-- =============================================
-- CREATE FINAL USER ACCOUNTS
-- Username format: name123 (dễ nhớ, đủ dài)
-- Password: 123456
-- =============================================

USE AdminUser;
GO

PRINT '========================================';
PRINT 'TẠO TÀI KHOẢN ĐĂNG NHẬP';
PRINT '========================================';
PRINT '';

-- Xóa tài khoản cũ
DELETE FROM Users WHERE Username IN ('an', 'binh', 'cuong', 'dung', 'em', 'phuong', 'giang', 'hoa', 'inh', 'kim', 'admin1');
DELETE FROM Users WHERE Username IN ('an123', 'binh123', 'cuong123', 'dung123', 'em123', 'phuong123', 'giang123', 'hoa123', 'inh123', 'kim123', 'admin123');
PRINT '✓ Đã xóa tài khoản cũ';
PRINT '';

-- Tạo ADMIN
INSERT INTO Users (Username, PasswordHash, RoleId, IsActive, CreatedAt)
VALUES ('admin123', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, 1, GETDATE());
PRINT '✓ Tạo ADMIN: admin123 / 123456';
PRINT '';

-- Tạo USER accounts
INSERT INTO Users (Username, PasswordHash, RoleId, IsActive, CreatedAt)
VALUES 
('an123', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('binh123', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('cuong123', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('dung123', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('em123', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('phuong123', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('giang123', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('hoa123', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('inh123', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
('kim123', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE());
PRINT '✓ Tạo 10 USER accounts';
PRINT '';

-- Cập nhật email trong Customers để link với Users
UPDATE Customers SET email = 'an123' WHERE id = 1;
UPDATE Customers SET email = 'binh123' WHERE id = 2;
UPDATE Customers SET email = 'cuong123' WHERE id = 3;
UPDATE Customers SET email = 'dung123' WHERE id = 4;
UPDATE Customers SET email = 'em123' WHERE id = 5;
UPDATE Customers SET email = 'phuong123' WHERE id = 6;
UPDATE Customers SET email = 'giang123' WHERE id = 7;
UPDATE Customers SET email = 'hoa123' WHERE id = 8;
UPDATE Customers SET email = 'inh123' WHERE id = 9;
UPDATE Customers SET email = 'kim123' WHERE id = 10;
PRINT '✓ Đã link Users với Customers';
PRINT '';

-- Verify
PRINT '========================================';
PRINT 'KIỂM TRA';
PRINT '========================================';
PRINT '';

SELECT u.Username, r.RoleName, c.full_name, c.phone
FROM Users u
JOIN Roles r ON u.RoleId = r.RoleId
LEFT JOIN Customers c ON u.Username = c.email
WHERE u.Username IN ('admin123', 'an123', 'binh123', 'cuong123')
ORDER BY r.RoleId, u.Username;

PRINT '';
PRINT '========================================';
PRINT 'TÀI KHOẢN ĐĂNG NHẬP';
PRINT '========================================';
PRINT '';
PRINT 'ADMIN:';
PRINT '  Username: admin123';
PRINT '  Password: 123456';
PRINT '';
PRINT 'USER (chọn 1 trong 10):';
PRINT '  an123 / 123456     → Nguyễn Văn An';
PRINT '  binh123 / 123456   → Trần Thị Bình';
PRINT '  cuong123 / 123456  → Lê Hoàng Cường';
PRINT '  dung123 / 123456   → Phạm Thị Dung';
PRINT '  em123 / 123456     → Hoàng Văn Em';
PRINT '  phuong123 / 123456 → Võ Thị Phương';
PRINT '  giang123 / 123456  → Đặng Văn Giang';
PRINT '  hoa123 / 123456    → Bùi Thị Hoa';
PRINT '  inh123 / 123456    → Ngô Văn Inh';
PRINT '  kim123 / 123456    → Dương Thị Kim';
PRINT '';
PRINT '✅ HOÀN TẤT!';
PRINT '';

GO

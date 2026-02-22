-- ========================================
-- SETUP TOÀN BỘ DATABASE
-- ========================================
USE AdminUser;
GO

-- ========================================
-- 1. TẠO BẢNG
-- ========================================

-- Bảng Users (Tài khoản đăng nhập)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
BEGIN
    CREATE TABLE Users (
        id INT IDENTITY(1,1) PRIMARY KEY,
        username NVARCHAR(50) NOT NULL UNIQUE,
        password NVARCHAR(255) NOT NULL,
        role NVARCHAR(20) NOT NULL CHECK (role IN ('admin', 'user')),
        created_at DATETIME DEFAULT GETDATE()
    );
END
GO

-- Bảng Customers (Thông tin khách hàng)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Customers')
BEGIN
    CREATE TABLE Customers (
        id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NULL,
        full_name NVARCHAR(100) NOT NULL,
        email NVARCHAR(100) NOT NULL UNIQUE,
        phone NVARCHAR(20),
        address NVARCHAR(255),
        city NVARCHAR(50),
        status NVARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'banned')),
        created_at DATETIME DEFAULT GETDATE(),
        updated_at DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE SET NULL
    );
END
GO

-- Bảng CustomerActivity (Lịch sử hoạt động)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CustomerActivity')
BEGIN
    CREATE TABLE CustomerActivity (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        CustomerId INT NOT NULL,
        ActionType NVARCHAR(50) NOT NULL,
        ActionDetails NVARCHAR(MAX),
        CreatedAt DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (CustomerId) REFERENCES Customers(id) ON DELETE CASCADE
    );
END
GO

-- ========================================
-- 2. XÓA DỮ LIỆU CŨ (NẾU CÓ)
-- ========================================
DELETE FROM CustomerActivity;
DELETE FROM Customers;
DELETE FROM Users;
GO

-- Reset identity
DBCC CHECKIDENT ('CustomerActivity', RESEED, 0);
DBCC CHECKIDENT ('Customers', RESEED, 0);
DBCC CHECKIDENT ('Users', RESEED, 0);
GO

-- ========================================
-- 3. INSERT ADMIN USER
-- ========================================
-- Check if admin exists
IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = 'admin')
BEGIN
    INSERT INTO Users (Username, PasswordHash, RoleId, IsActive) 
    VALUES ('admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, 1);
END
GO

-- ========================================
-- 4. INSERT 10 KHÁCH HÀNG
-- ========================================
SET IDENTITY_INSERT Customers ON;

INSERT INTO Customers (id, user_id, full_name, email, phone, address, date_of_birth, status, created_at, updated_at) VALUES
(1, NULL, N'Nguyễn Văn An', N'an@gmail.com', N'0901234567', N'123 Lê Lợi, Hồ Chí Minh', '1990-01-15', N'active', GETDATE(), GETDATE()),
(2, NULL, N'Trần Thị Bình', N'binh@gmail.com', N'0902345678', N'456 Trần Hưng Đạo, Hà Nội', '1992-03-20', N'active', GETDATE(), GETDATE()),
(3, NULL, N'Lê Văn Cường', N'cuong@gmail.com', N'0903456789', N'789 Nguyễn Huệ, Đà Nẵng', '1988-07-10', N'inactive', GETDATE(), GETDATE()),
(4, NULL, N'Phạm Thị Dung', N'dung@gmail.com', N'0904567890', N'321 Hai Bà Trưng, Hồ Chí Minh', '1995-11-25', N'active', GETDATE(), GETDATE()),
(5, NULL, N'Hoàng Văn Em', N'em@gmail.com', N'0905678901', N'654 Lý Thường Kiệt, Cần Thơ', '1991-05-30', N'banned', GETDATE(), GETDATE()),
(6, NULL, N'Vũ Thị Phương', N'phuong@gmail.com', N'0906789012', N'987 Điện Biên Phủ, Hà Nội', '1993-09-12', N'active', GETDATE(), GETDATE()),
(7, NULL, N'Đặng Văn Giang', N'giang@gmail.com', N'0907890123', N'147 Võ Văn Tần, Đà Nẵng', '1989-02-18', N'active', GETDATE(), GETDATE()),
(8, NULL, N'Bùi Thị Hoa', N'hoa@gmail.com', N'0908901234', N'258 Pasteur, Hồ Chí Minh', '1994-06-22', N'inactive', GETDATE(), GETDATE()),
(9, NULL, N'Ngô Văn Inh', N'inh@gmail.com', N'0909012345', N'369 Cách Mạng Tháng 8, Huế', '1990-12-05', N'active', GETDATE(), GETDATE()),
(10, NULL, N'Trương Thị Kim', N'kim@gmail.com', N'0900123456', N'741 Nguyễn Thị Minh Khai, Hà Nội', '1996-04-08', N'active', GETDATE(), GETDATE());

SET IDENTITY_INSERT Customers OFF;
GO

-- ========================================
-- 5. TẠO TÀI KHOẢN CHO 10 KHÁCH HÀNG
-- ========================================
INSERT INTO Users (Username, PasswordHash, RoleId, IsActive) VALUES
(N'nvan', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1),
(N'tbinh', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1),
(N'lcuong', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1),
(N'pdung', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1),
(N'hvem', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1),
(N'vtphuong', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1),
(N'dvgiang', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1),
(N'bthoa', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1),
(N'nvinh', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1),
(N'ttkim', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1);
GO

-- ========================================
-- 6. LINK USERS VỚI CUSTOMERS
-- ========================================
DECLARE @adminId INT = (SELECT UserId FROM Users WHERE Username = 'admin');
DECLARE @startId INT = @adminId + 1;

UPDATE Customers SET user_id = @startId WHERE id = 1;      -- an
UPDATE Customers SET user_id = @startId + 1 WHERE id = 2;  -- binh
UPDATE Customers SET user_id = @startId + 2 WHERE id = 3;  -- cuong
UPDATE Customers SET user_id = @startId + 3 WHERE id = 4;  -- dung
UPDATE Customers SET user_id = @startId + 4 WHERE id = 5;  -- em
UPDATE Customers SET user_id = @startId + 5 WHERE id = 6;  -- phuong
UPDATE Customers SET user_id = @startId + 6 WHERE id = 7;  -- giang
UPDATE Customers SET user_id = @startId + 7 WHERE id = 8;  -- hoa
UPDATE Customers SET user_id = @startId + 8 WHERE id = 9;  -- inh
UPDATE Customers SET user_id = @startId + 9 WHERE id = 10; -- kim
GO

-- ========================================
-- 7. INSERT DỮ LIỆU MẪU CUSTOMERACTIVITY
-- ========================================
INSERT INTO CustomerActivity (CustomerId, ActionType, ActionDetails) VALUES
(1, N'Đăng ký', N'Khách hàng đăng ký tài khoản mới'),
(1, N'Cập nhật thông tin', N'Cập nhật số điện thoại và địa chỉ'),
(2, N'Đăng ký', N'Khách hàng đăng ký tài khoản mới'),
(3, N'Đăng ký', N'Khách hàng đăng ký tài khoản mới'),
(3, N'Vô hiệu hóa', N'Tài khoản bị vô hiệu hóa do vi phạm'),
(4, N'Đăng ký', N'Khách hàng đăng ký tài khoản mới'),
(5, N'Đăng ký', N'Khách hàng đăng ký tài khoản mới'),
(5, N'Cấm', N'Tài khoản bị cấm do spam'),
(6, N'Đăng ký', N'Khách hàng đăng ký tài khoản mới'),
(7, N'Đăng ký', N'Khách hàng đăng ký tài khoản mới');
GO

-- ========================================
-- HOÀN TẤT
-- ========================================
PRINT '========================================';
PRINT 'SETUP DATABASE THÀNH CÔNG!';
PRINT '========================================';
PRINT '';
PRINT 'ADMIN ACCOUNT:';
PRINT '  Username: admin';
PRINT '  Password: 123456';
PRINT '';
PRINT 'USER ACCOUNTS (10 khách hàng):';
PRINT '  nvan/tbinh/lcuong/pdung/hvem/vtphuong/dvgiang/bthoa/nvinh/ttkim';
PRINT '  Password: 123456';
PRINT '';
PRINT '========================================';
GO

-- =============================================
-- COMPLETE SETUP: Customers + Users + Sample Data
-- =============================================

USE AdminUser;
GO

-- =============================================
-- 1. Tạo bảng Customers (nếu chưa có)
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Customers')
BEGIN
    CREATE TABLE Customers (
        id INT PRIMARY KEY IDENTITY(1,1),
        full_name NVARCHAR(100) NOT NULL,
        email NVARCHAR(100) NOT NULL UNIQUE,
        phone NVARCHAR(20),
        address NVARCHAR(255),
        date_of_birth DATE,
        status NVARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'banned')),
        created_at DATETIME DEFAULT GETDATE(),
        updated_at DATETIME DEFAULT GETDATE()
    );
    PRINT '✓ Table Customers created';
END
ELSE
BEGIN
    PRINT '✓ Table Customers already exists';
END
GO

-- =============================================
-- 2. Tạo bảng CustomerActivities (nếu chưa có)
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CustomerActivities')
BEGIN
    CREATE TABLE CustomerActivities (
        id INT PRIMARY KEY IDENTITY(1,1),
        customer_id INT NOT NULL,
        action_type NVARCHAR(50) NOT NULL,
        description NVARCHAR(500),
        created_at DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (customer_id) REFERENCES Customers(id) ON DELETE CASCADE
    );
    PRINT '✓ Table CustomerActivities created';
END
ELSE
BEGIN
    PRINT '✓ Table CustomerActivities already exists';
END
GO

-- =============================================
-- 3. Xóa dữ liệu cũ (nếu có)
-- =============================================
DELETE FROM CustomerActivities;
DELETE FROM Customers;
PRINT '✓ Cleared old data';
GO

-- =============================================
-- 4. Insert 10 Customers mẫu
-- =============================================
SET IDENTITY_INSERT Customers ON;

INSERT INTO Customers (id, full_name, email, phone, address, date_of_birth, status, created_at, updated_at)
VALUES 
(1, N'Nguyễn Văn An', 'nguyenvanan@gmail.com', '0901234567', N'123 Lê Lợi, Hải Châu, Đà Nẵng', '1990-05-15', 'active', DATEADD(day, -30, GETDATE()), GETDATE()),
(2, N'Trần Thị Bình', 'tranthibinh@gmail.com', '0912345678', N'456 Trần Phú, Sơn Trà, Đà Nẵng', '1992-08-20', 'active', DATEADD(day, -25, GETDATE()), GETDATE()),
(3, N'Lê Hoàng Cường', 'lehoangcuong@gmail.com', '0923456789', N'789 Nguyễn Văn Linh, Thanh Khê, Đà Nẵng', '1988-03-10', 'active', DATEADD(day, -20, GETDATE()), GETDATE()),
(4, N'Phạm Thị Dung', 'phamthidung@gmail.com', '0934567890', N'321 Hoàng Diệu, Hải Châu, Đà Nẵng', '1995-11-25', 'active', DATEADD(day, -15, GETDATE()), GETDATE()),
(5, N'Hoàng Văn Em', 'hoangvanem@gmail.com', '0945678901', N'654 Điện Biên Phủ, Thanh Khê, Đà Nẵng', '1991-07-08', 'inactive', DATEADD(day, -12, GETDATE()), GETDATE()),
(6, N'Võ Thị Phương', 'vothiphuong@gmail.com', '0956789012', N'987 Phan Châu Trinh, Hải Châu, Đà Nẵng', '1993-12-30', 'active', DATEADD(day, -10, GETDATE()), GETDATE()),
(7, N'Đặng Văn Giang', 'dangvangiang@gmail.com', '0967890123', N'147 Lê Duẩn, Thanh Khê, Đà Nẵng', '1989-04-18', 'active', DATEADD(day, -8, GETDATE()), GETDATE()),
(8, N'Bùi Thị Hoa', 'buithihoa@gmail.com', '0978901234', N'258 Hùng Vương, Hải Châu, Đà Nẵng', '1994-09-22', 'banned', DATEADD(day, -7, GETDATE()), GETDATE()),
(9, N'Ngô Văn Inh', 'ngovaninh@gmail.com', '0989012345', N'369 Ông Ích Khiêm, Hải Châu, Đà Nẵng', '1987-01-14', 'active', DATEADD(day, -5, GETDATE()), GETDATE()),
(10, N'Dương Thị Kim', 'duongthikim@gmail.com', '0990123456', N'741 Núi Thành, Hải Châu, Đà Nẵng', '1996-06-05', 'active', DATEADD(day, -3, GETDATE()), GETDATE());

SET IDENTITY_INSERT Customers OFF;
PRINT '✓ Inserted 10 customers';
GO

-- =============================================
-- 5. Insert Activities cho 5 customers đầu
-- =============================================

-- Customer 1: Nguyễn Văn An (10 activities)
INSERT INTO CustomerActivities (customer_id, action_type, description, created_at)
VALUES 
(1, 'REGISTER', N'Đăng ký tài khoản mới', DATEADD(day, -30, GETDATE())),
(1, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -30, GETDATE())),
(1, 'SEARCH', N'Tìm kiếm tour: Bà Nà Hills', DATEADD(day, -28, GETDATE())),
(1, 'VIEW_TOUR', N'Xem chi tiết tour: Bà Nà Hills - Cáp treo dài nhất thế giới', DATEADD(day, -28, GETDATE())),
(1, 'BOOKING', N'Đặt tour: Bà Nà Hills (2 người, 2,500,000 VNĐ)', DATEADD(day, -27, GETDATE())),
(1, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -15, GETDATE())),
(1, 'SEARCH', N'Tìm kiếm tour: Hội An', DATEADD(day, -15, GETDATE())),
(1, 'VIEW_TOUR', N'Xem chi tiết tour: Phố cổ Hội An', DATEADD(day, -15, GETDATE())),
(1, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -5, GETDATE())),
(1, 'VIEW_HISTORY', N'Xem lịch sử đặt tour', DATEADD(day, -5, GETDATE()));

-- Customer 2: Trần Thị Bình (10 activities)
INSERT INTO CustomerActivities (customer_id, action_type, description, created_at)
VALUES 
(2, 'REGISTER', N'Đăng ký tài khoản mới', DATEADD(day, -25, GETDATE())),
(2, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -25, GETDATE())),
(2, 'SEARCH', N'Tìm kiếm tour: Cù Lao Chàm', DATEADD(day, -24, GETDATE())),
(2, 'VIEW_TOUR', N'Xem chi tiết tour: Cù Lao Chàm - Lặn biển ngắm san hô', DATEADD(day, -24, GETDATE())),
(2, 'BOOKING', N'Đặt tour: Cù Lao Chàm (4 người, 3,200,000 VNĐ)', DATEADD(day, -23, GETDATE())),
(2, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -10, GETDATE())),
(2, 'SEARCH', N'Tìm kiếm tour: Ngũ Hành Sơn', DATEADD(day, -10, GETDATE())),
(2, 'VIEW_TOUR', N'Xem chi tiết tour: Ngũ Hành Sơn', DATEADD(day, -10, GETDATE())),
(2, 'BOOKING', N'Đặt tour: Ngũ Hành Sơn (2 người, 800,000 VNĐ)', DATEADD(day, -9, GETDATE())),
(2, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -2, GETDATE()));

-- Customer 3: Lê Hoàng Cường (8 activities)
INSERT INTO CustomerActivities (customer_id, action_type, description, created_at)
VALUES 
(3, 'REGISTER', N'Đăng ký tài khoản mới', DATEADD(day, -20, GETDATE())),
(3, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -20, GETDATE())),
(3, 'SEARCH', N'Tìm kiếm tour: Huế', DATEADD(day, -19, GETDATE())),
(3, 'VIEW_TOUR', N'Xem chi tiết tour: Cố đô Huế', DATEADD(day, -19, GETDATE())),
(3, 'BOOKING', N'Đặt tour: Cố đô Huế (3 người, 4,500,000 VNĐ)', DATEADD(day, -18, GETDATE())),
(3, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -7, GETDATE())),
(3, 'VIEW_HISTORY', N'Xem lịch sử đặt tour', DATEADD(day, -7, GETDATE())),
(3, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -1, GETDATE()));

-- Customer 4: Phạm Thị Dung (8 activities)
INSERT INTO CustomerActivities (customer_id, action_type, description, created_at)
VALUES 
(4, 'REGISTER', N'Đăng ký tài khoản mới', DATEADD(day, -15, GETDATE())),
(4, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -15, GETDATE())),
(4, 'SEARCH', N'Tìm kiếm tour: Sơn Trà', DATEADD(day, -14, GETDATE())),
(4, 'VIEW_TOUR', N'Xem chi tiết tour: Bán đảo Sơn Trà', DATEADD(day, -14, GETDATE())),
(4, 'SEARCH', N'Tìm kiếm tour: Núi Thần Tài', DATEADD(day, -13, GETDATE())),
(4, 'VIEW_TOUR', N'Xem chi tiết tour: Núi Thần Tài - Suối khoáng nóng', DATEADD(day, -13, GETDATE())),
(4, 'BOOKING', N'Đặt tour: Núi Thần Tài (2 người, 1,800,000 VNĐ)', DATEADD(day, -12, GETDATE())),
(4, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -3, GETDATE()));

-- Customer 5: Hoàng Văn Em (5 activities)
INSERT INTO CustomerActivities (customer_id, action_type, description, created_at)
VALUES 
(5, 'REGISTER', N'Đăng ký tài khoản mới', DATEADD(day, -12, GETDATE())),
(5, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -12, GETDATE())),
(5, 'SEARCH', N'Tìm kiếm tour: Bà Nà Hills', DATEADD(day, -11, GETDATE())),
(5, 'VIEW_TOUR', N'Xem chi tiết tour: Bà Nà Hills', DATEADD(day, -11, GETDATE())),
(5, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -8, GETDATE()));

PRINT '✓ Inserted 41 activities for 5 customers';
GO

-- =============================================
-- 6. Tạo Users tương ứng với Customers
-- Password: 123456 (SHA-256 hashed)
-- =============================================

-- SHA-256 hash của "123456" = 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92

-- Kiểm tra xem bảng Users có tồn tại không
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
BEGIN
    -- Xóa users cũ nếu đã tồn tại
    DELETE FROM Users WHERE Username IN (
        'nguyenvanan@gmail.com',
        'tranthibinh@gmail.com', 
        'lehoangcuong@gmail.com',
        'phamthidung@gmail.com',
        'hoangvanem@gmail.com',
        'vothiphuong@gmail.com',
        'dangvangiang@gmail.com',
        'buithihoa@gmail.com',
        'ngovaninh@gmail.com',
        'duongthikim@gmail.com'
    );
    
    -- Insert Users mới (RoleId = 2 là USER)
    INSERT INTO Users (Username, PasswordHash, RoleId, IsActive, CreatedAt)
    VALUES 
    ('nguyenvanan@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
    ('tranthibinh@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
    ('lehoangcuong@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
    ('phamthidung@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
    ('hoangvanem@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
    ('vothiphuong@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
    ('dangvangiang@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
    ('buithihoa@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
    ('ngovaninh@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE()),
    ('duongthikim@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 1, GETDATE());
    
    PRINT '✓ Inserted 10 Users (password: 123456)';
END
ELSE
BEGIN
    PRINT '✗ Table Users does not exist! Please create it first.';
END
GO

-- =============================================
-- 7. Hiển thị thống kê
-- =============================================
PRINT '';
PRINT '========================================';
PRINT 'SETUP COMPLETED SUCCESSFULLY!';
PRINT '========================================';
PRINT '';

SELECT COUNT(*) AS 'Total Customers' FROM Customers;
SELECT COUNT(*) AS 'Total Activities' FROM CustomerActivities;

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
BEGIN
    SELECT COUNT(*) AS 'Total Users (USER role)' FROM Users WHERE RoleId = 2;
END

PRINT '';
PRINT 'Login credentials (all passwords: 123456):';
PRINT '1. nguyenvanan@gmail.com';
PRINT '2. tranthibinh@gmail.com';
PRINT '3. lehoangcuong@gmail.com';
PRINT '4. phamthidung@gmail.com';
PRINT '5. hoangvanem@gmail.com';
PRINT '';
PRINT 'You can now:';
PRINT '- Login as USER to test /profile';
PRINT '- Login as ADMIN to test /admin/customers';
PRINT '';
GO

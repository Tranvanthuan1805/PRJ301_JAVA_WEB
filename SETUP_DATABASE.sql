-- =============================================
-- SETUP DATABASE: TourManagement
-- Kết hợp database.sql (Tours) + SQLQuery1.sql (Users)
-- =============================================

USE master;
GO

-- Xóa database cũ nếu tồn tại
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'TourManagement')
BEGIN
    ALTER DATABASE TourManagement SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TourManagement;
END
GO

-- Tạo database mới
CREATE DATABASE TourManagement;
GO

USE TourManagement;
GO

-- =============================================
-- PHẦN 1: USERS & ROLES (từ SQLQuery1.sql)
-- =============================================

-- Bảng Roles
CREATE TABLE Roles (
    RoleId INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE
);

-- Bảng Users
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(64) NOT NULL,
    RoleId INT NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleId) REFERENCES Roles(RoleId)
);

-- Thêm Roles
INSERT INTO Roles (RoleName) VALUES ('ADMIN');
INSERT INTO Roles (RoleName) VALUES ('USER');

-- Thêm Users (password: 123456)
-- Hash SHA-256 của "123456" = 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92
INSERT INTO Users (Username, PasswordHash, RoleId) VALUES 
('admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1),
('user', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2);

-- =============================================
-- PHẦN 2: TOUR MANAGEMENT (từ database.sql)
-- =============================================

-- Bảng Customers
CREATE TABLE Customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(20),
    address NVARCHAR(255),
    createdAt DATETIME2 DEFAULT GETDATE(),
    updatedAt DATETIME2 DEFAULT GETDATE()
);

-- Bảng Tours
CREATE TABLE Tours (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200) NOT NULL,
    destination NVARCHAR(100) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    startTime NVARCHAR(10) DEFAULT '08:00',
    endTime NVARCHAR(10) DEFAULT '18:00',
    price DECIMAL(10,2) NOT NULL,
    maxCapacity INT NOT NULL,
    currentCapacity INT DEFAULT 0,
    description NTEXT,
    createdAt DATETIME2 DEFAULT GETDATE(),
    updatedAt DATETIME2 DEFAULT GETDATE()
);

-- Bảng Bookings
CREATE TABLE Bookings (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customerId INT NOT NULL,
    tourId INT NOT NULL,
    bookingDate DATETIME2 DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT 'CONFIRMED',
    bookingCode NVARCHAR(20) UNIQUE,
    createdAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (customerId) REFERENCES Customers(id) ON DELETE CASCADE,
    FOREIGN KEY (tourId) REFERENCES Tours(id) ON DELETE CASCADE
);

-- Bảng InteractionHistory
CREATE TABLE InteractionHistory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customerId INT NOT NULL,
    action NVARCHAR(100) NOT NULL,
    createdAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (customerId) REFERENCES Customers(id) ON DELETE CASCADE
);

-- =============================================
-- PHẦN 3: INDEXES
-- =============================================

CREATE INDEX IX_Customers_email ON Customers(email);
CREATE INDEX IX_Tours_destination ON Tours(destination);
CREATE INDEX IX_Tours_startDate ON Tours(startDate);
CREATE INDEX IX_Bookings_customerId ON Bookings(customerId);
CREATE INDEX IX_Bookings_tourId ON Bookings(tourId);
CREATE INDEX IX_InteractionHistory_customerId ON InteractionHistory(customerId);
CREATE INDEX IX_InteractionHistory_createdAt ON InteractionHistory(createdAt);

-- =============================================
-- PHẦN 4: DỮ LIỆU MẪU
-- =============================================

-- Thêm Customers (20 khách hàng từ Đà Nẵng)
INSERT INTO Customers (fullName, email, phone, address) VALUES
(N'Nguyễn Văn An', 'an.nguyen@email.com', '0901234567', N'123 Đường Lê Duẩn, Quận Hải Châu, Đà Nẵng'),
(N'Trần Thị Bình', 'binh.tran@email.com', '0912345678', N'456 Đường Trần Phú, Quận Hải Châu, Đà Nẵng'),
(N'Lê Văn Cường', 'cuong.le@email.com', '0923456789', N'789 Đường Hoàng Diệu, Quận Hải Châu, Đà Nẵng'),
(N'Phạm Thị Dung', 'dung.pham@email.com', '0934567890', N'321 Đường Bạch Đằng, Quận Hải Châu, Đà Nẵng'),
(N'Hoàng Văn Em', 'em.hoang@email.com', '0945678901', N'654 Đường Nguyễn Văn Linh, Quận Thanh Khê, Đà Nẵng'),
(N'Vũ Thị Hoa', 'hoa.vu@email.com', '0956789012', N'987 Đường Điện Biên Phủ, Quận Thanh Khê, Đà Nẵng'),
(N'Đặng Văn Giang', 'giang.dang@email.com', '0967890123', N'147 Đường Lê Lợi, Quận Thanh Khê, Đà Nẵng'),
(N'Bùi Thị Lan', 'lan.bui@email.com', '0978901234', N'258 Đường Nguyễn Hữu Thọ, Quận Thanh Khê, Đà Nẵng'),
(N'Ngô Văn Minh', 'minh.ngo@email.com', '0989012345', N'369 Đường Võ Nguyên Giáp, Quận Sơn Trà, Đà Nẵng'),
(N'Lý Thị Nga', 'nga.ly@email.com', '0990123456', N'741 Đường Hoàng Sa, Quận Sơn Trà, Đà Nẵng'),
(N'Trương Văn Phúc', 'phuc.truong@email.com', '0901357924', N'852 Đường Nguyễn Tất Thành, Quận Ngũ Hành Sơn, Đà Nẵng'),
(N'Phan Thị Quỳnh', 'quynh.phan@email.com', '0912468135', N'963 Đường Trường Sa, Quận Ngũ Hành Sơn, Đà Nẵng'),
(N'Võ Văn Sơn', 'son.vo@email.com', '0923579246', N'159 Đường Tôn Đức Thắng, Quận Liên Chiểu, Đà Nẵng'),
(N'Đinh Thị Tâm', 'tam.dinh@email.com', '0934680357', N'357 Đường Nguyễn Duy Trinh, Quận Liên Chiểu, Đà Nẵng'),
(N'Huỳnh Văn Tùng', 'tung.huynh@email.com', '0945791468', N'468 Đường Cách Mạng Tháng Tám, Quận Cẩm Lệ, Đà Nẵng'),
(N'Mai Thị Uyên', 'uyen.mai@email.com', '0956802579', N'579 Đường Hùng Vương, Quận Cẩm Lệ, Đà Nẵng'),
(N'Lưu Văn Vinh', 'vinh.luu@email.com', '0967913680', N'680 Đường Hồ Chí Minh, Huyện Hòa Vang, Đà Nẵng'),
(N'Cao Thị Xuân', 'xuan.cao@email.com', '0978024791', N'791 Đường Quốc lộ 14B, Huyện Hòa Vang, Đà Nẵng'),
(N'Đỗ Văn Yên', 'yen.do@email.com', '0989135802', N'802 Đường 2/9, Quận Hải Châu, Đà Nẵng'),
(N'Hồ Thị Zara', 'zara.ho@email.com', '0990246913', N'913 Đường Phan Châu Trinh, Quận Hải Châu, Đà Nẵng');

-- Thêm Tours (15 tours trong Đà Nẵng)
INSERT INTO Tours (name, destination, startDate, endDate, startTime, endTime, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Quận Hải Châu 3N2Đ', N'Hải Châu', '2026-03-15', '2026-03-17', '07:30', '18:00', 1800000, 30, 8, N'Khám phá trung tâm Đà Nẵng với cầu Rồng, chợ Hàn, bãi biển Mỹ Khê'),
(N'Tour Bán đảo Sơn Trà 4N3Đ', N'Sơn Trà', '2026-04-01', '2026-04-04', '06:00', '19:30', 2200000, 25, 12, N'Tham quan chùa Linh Ứng, tượng Phật Quan Âm và rừng nguyên sinh Sơn Trà'),
(N'Tour Ngũ Hành Sơn 3N2Đ', N'Ngũ Hành Sơn', '2026-05-10', '2026-05-12', '09:00', '20:00', 2000000, 40, 18, N'Khám phá 5 ngọn núi đá vôi, hang động và làng đá Non Nước nổi tiếng'),
(N'Tour Thanh Khê 2N1Đ', N'Thanh Khê', '2026-06-05', '2026-06-06', '08:00', '17:30', 1600000, 35, 22, N'Tham quan khu đô thị hiện đại với trường đại học và công viên Châu Á'),
(N'Tour Liên Chiểu 3N2Đ', N'Liên Chiểu', '2026-07-20', '2026-07-22', '07:00', '18:30', 1500000, 45, 30, N'Khám phá khu vực phát triển mới với sân bay quốc tế và khu công nghiệp'),
(N'Tour Cẩm Lệ 2N1Đ', N'Cẩm Lệ', '2026-08-15', '2026-08-16', '08:30', '19:00', 1400000, 30, 15, N'Trải nghiệm khu vực nông thôn kết hợp đô thị với làng nghề truyền thống'),
(N'Tour Bà Nà Hills 4N3Đ', N'Hòa Vang', '2026-03-20', '2026-03-23', '06:30', '17:00', 2500000, 28, 10, N'Khám phá Bà Nà Hills với cầu Vàng nổi tiếng, làng Pháp và cáp treo'),
(N'Tour Hoàng Sa 5N4Đ', N'Hoàng Sa', '2026-04-10', '2026-04-14', '07:00', '18:00', 3500000, 20, 6, N'Tour đặc biệt đến quần đảo Hoàng Sa - chủ quyền thiêng liêng của Việt Nam'),
(N'Tour Hải Châu - Sơn Trà 3N2Đ', N'Hải Châu', '2026-05-01', '2026-05-03', '08:00', '19:00', 1900000, 40, 25, N'Kết hợp trung tâm thành phố và bán đảo Sơn Trà trong một chuyến đi'),
(N'Tour Ngũ Hành Sơn - Hòa Vang 4N3Đ', N'Ngũ Hành Sơn', '2026-06-15', '2026-06-18', '07:30', '18:30', 2300000, 32, 16, N'Từ Ngũ Hành Sơn đến Bà Nà Hills, trải nghiệm đầy đủ vẻ đẹp Đà Nẵng'),
(N'Tour Thanh Khê - Liên Chiểu 2N1Đ', N'Thanh Khê', '2026-07-05', '2026-07-06', '06:00', '17:30', 1700000, 30, 12, N'Khám phá hai quận hiện đại nhất của Đà Nẵng'),
(N'Tour Cẩm Lệ - Hòa Vang 3N2Đ', N'Cẩm Lệ', '2026-08-01', '2026-08-03', '08:00', '19:30', 2100000, 25, 8, N'Từ nông thôn đến núi non, trải nghiệm đa dạng địa hình Đà Nẵng'),
(N'Tour Toàn cảnh Đà Nẵng 5N4Đ', N'Hải Châu', '2026-09-10', '2026-09-14', '09:00', '20:00', 2800000, 35, 20, N'Tour tổng hợp tất cả các quận huyện trong thành phố Đà Nẵng'),
(N'Tour Sơn Trà - Ngũ Hành Sơn 3N2Đ', N'Sơn Trà', '2026-10-01', '2026-10-03', '07:00', '18:00', 2200000, 30, 14, N'Kết hợp bán đảo Sơn Trà và Ngũ Hành Sơn trong cùng một tour'),
(N'Tour Hòa Vang - Hoàng Sa 6N5Đ', N'Hòa Vang', '2026-11-15', '2026-11-20', '08:30', '17:00', 4000000, 20, 9, N'Tour cao cấp từ Bà Nà Hills đến quần đảo Hoàng Sa');

-- =============================================
-- PHẦN 5: KIỂM TRA
-- =============================================

PRINT '==============================================';
PRINT 'DATABASE TourManagement ĐÃ TẠO THÀNH CÔNG!';
PRINT '==============================================';
PRINT '';
PRINT 'USERS:';
SELECT u.Username, r.RoleName, u.IsActive 
FROM Users u 
JOIN Roles r ON u.RoleId = r.RoleId;
PRINT '';
PRINT 'TOURS:';
SELECT COUNT(*) AS TotalTours FROM Tours;
PRINT '';
PRINT 'CUSTOMERS:';
SELECT COUNT(*) AS TotalCustomers FROM Customers;
PRINT '';
PRINT '==============================================';
PRINT 'THÔNG TIN ĐĂNG NHẬP:';
PRINT 'Username: admin | Password: 123456 | Role: ADMIN';
PRINT 'Username: user  | Password: 123456 | Role: USER';
PRINT '==============================================';
PRINT 'DATABASE: TourManagement';
PRINT 'SERVER: localhost (hoặc .\SQLEXPRESS)';
PRINT 'AUTH: SQL Server Authentication';
PRINT 'User: sa | Password: 123456';
PRINT '==============================================';


-- Tạo bảng Cart để lưu giỏ hàng vào database
-- Chạy script này trong SQL Server Management Studio

USE TourManagement;
GO

-- Xóa bảng cũ nếu tồn tại
IF OBJECT_ID('Cart', 'U') IS NOT NULL
    DROP TABLE Cart;
GO

-- Tạo bảng Cart
CREATE TABLE Cart (
    CartId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    TourId INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    AddedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE,
    FOREIGN KEY (TourId) REFERENCES Tours(id) ON DELETE CASCADE,
    UNIQUE (UserId, TourId) -- Mỗi user chỉ có 1 dòng cho mỗi tour
);
GO

-- Tạo index để tăng tốc truy vấn
CREATE INDEX IX_Cart_UserId ON Cart(UserId);
CREATE INDEX IX_Cart_TourId ON Cart(TourId);
GO

PRINT 'Tạo bảng Cart thành công!';


-- Fix Orders table to match entity
USE TourManagement;
GO

-- Drop and recreate Orders table
IF OBJECT_ID('Orders', 'U') IS NOT NULL
    DROP TABLE Orders;
GO

CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT NOT NULL,
    TotalAmount FLOAT NOT NULL,
    OrderStatus NVARCHAR(50) DEFAULT 'Pending',
    PaymentStatus NVARCHAR(20) DEFAULT 'Unpaid',
    CancelReason NVARCHAR(500),
    OrderDate DATETIME2 DEFAULT GETDATE(),
    UpdatedAt DATETIME2,
    
    CONSTRAINT FK_Orders_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
);
GO

-- Create indexes
CREATE INDEX IX_Orders_CustomerId ON Orders(CustomerId);
CREATE INDEX IX_Orders_OrderStatus ON Orders(OrderStatus);
CREATE INDEX IX_Orders_OrderDate ON Orders(OrderDate DESC);
GO

PRINT 'Orders table fixed successfully!';
GO


-- Fix Bookings table to match entity
USE TourManagement;
GO

-- Drop and recreate Bookings table
IF OBJECT_ID('Bookings', 'U') IS NOT NULL
    DROP TABLE Bookings;
GO

CREATE TABLE Bookings (
    BookingId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    TourId INT NOT NULL,
    BookingDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    Quantity INT DEFAULT 1,
    SubTotal FLOAT NOT NULL,
    BookingStatus NVARCHAR(50) DEFAULT 'Pending',
    
    CONSTRAINT FK_Bookings_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_Bookings_Tours FOREIGN KEY (TourId) REFERENCES Tours(Id)
);
GO

-- Create indexes
CREATE INDEX IX_Bookings_OrderId ON Bookings(OrderId);
CREATE INDEX IX_Bookings_TourId ON Bookings(TourId);
CREATE INDEX IX_Bookings_BookingStatus ON Bookings(BookingStatus);
GO

PRINT 'Bookings table fixed successfully!';
GO



-- Migration script for TourManagement database
-- Add missing columns to Users table and create Customers table for user profiles

USE TourManagement;
GO

PRINT 'Starting migration for TourManagement database...';
GO

-- =============================================
-- STEP 1: Add columns to Users table
-- =============================================

PRINT 'Step 1: Adding columns to Users table...';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'Email')
BEGIN
    ALTER TABLE Users ADD Email NVARCHAR(100);
    PRINT '  Added column: Email';
END
ELSE PRINT '  Column Email already exists';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'FullName')
BEGIN
    ALTER TABLE Users ADD FullName NVARCHAR(100);
    PRINT '  Added column: FullName';
END
ELSE PRINT '  Column FullName already exists';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'PhoneNumber')
BEGIN
    ALTER TABLE Users ADD PhoneNumber NVARCHAR(20);
    PRINT '  Added column: PhoneNumber';
END
ELSE PRINT '  Column PhoneNumber already exists';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'Address')
BEGIN
    ALTER TABLE Users ADD Address NVARCHAR(255);
    PRINT '  Added column: Address';
END
ELSE PRINT '  Column Address already exists';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'DateOfBirth')
BEGIN
    ALTER TABLE Users ADD DateOfBirth DATE;
    PRINT '  Added column: DateOfBirth';
END
ELSE PRINT '  Column DateOfBirth already exists';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'AvatarUrl')
BEGIN
    ALTER TABLE Users ADD AvatarUrl NVARCHAR(500);
    PRINT '  Added column: AvatarUrl';
END
ELSE PRINT '  Column AvatarUrl already exists';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'UpdatedAt')
BEGIN
    ALTER TABLE Users ADD UpdatedAt DATETIME DEFAULT GETDATE();
    PRINT '  Added column: UpdatedAt';
END
ELSE PRINT '  Column UpdatedAt already exists';
GO

-- =============================================
-- STEP 2: Update existing users with default email
-- =============================================

PRINT 'Step 2: Updating existing users with default emails...';
GO

UPDATE Users 
SET Email = Username + '@eztravel.com'
WHERE Email IS NULL;
GO

PRINT '  Updated ' + CAST(@@ROWCOUNT AS VARCHAR) + ' users with default emails';
GO

-- =============================================
-- STEP 3: Add CUSTOMER role if not exists
-- =============================================

PRINT 'Step 3: Checking roles...';
GO

IF NOT EXISTS (SELECT * FROM Roles WHERE RoleName = 'CUSTOMER')
BEGIN
    INSERT INTO Roles (RoleName) VALUES ('CUSTOMER');
    PRINT '  Added CUSTOMER role';
END
ELSE PRINT '  CUSTOMER role already exists';
GO

-- =============================================
-- STEP 4: Rename or create Customers table for profile management
-- =============================================

PRINT 'Step 4: Setting up Customers table for profile management...';
GO

-- Check if old Customers table exists (from SETUP_DATABASE.sql)
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customers')
BEGIN
    -- Check if it has the old structure (id, fullName, email, etc.)
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Customers' AND COLUMN_NAME = 'id')
    BEGIN
        PRINT '  Found old Customers table structure. Renaming to Customers_OLD...';
        
        -- Rename old table
        EXEC sp_rename 'Customers', 'Customers_OLD';
        
        -- Drop foreign keys from Bookings if they exist
        IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK__Bookings__custom__5EBF139D')
            ALTER TABLE Bookings DROP CONSTRAINT FK__Bookings__custom__5EBF139D;
        
        PRINT '  Old table renamed successfully';
    END
    ELSE
    BEGIN
        PRINT '  Customers table already has correct structure';
    END
END
GO

-- Create new Customers table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customers')
BEGIN
    CREATE TABLE Customers (
        CustomerId INT PRIMARY KEY,
        Address NVARCHAR(255),
        DateOfBirth DATE,
        Status NVARCHAR(20) DEFAULT 'active',
        CONSTRAINT FK_Customers_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
    );
    PRINT '  Created new Customers table';
    
    -- Create customer records for users with USER or CUSTOMER role
    INSERT INTO Customers (CustomerId, Status)
    SELECT u.UserId, 'active'
    FROM Users u
    INNER JOIN Roles r ON u.RoleId = r.RoleId
    WHERE r.RoleName IN ('USER', 'CUSTOMER');
    
    PRINT '  Created ' + CAST(@@ROWCOUNT AS VARCHAR) + ' customer records';
END
ELSE
BEGIN
    PRINT '  Customers table already exists';
    
    -- Make sure all USER/CUSTOMER role users have customer records
    INSERT INTO Customers (CustomerId, Status)
    SELECT u.UserId, 'active'
    FROM Users u
    INNER JOIN Roles r ON u.RoleId = r.RoleId
    WHERE r.RoleName IN ('USER', 'CUSTOMER')
    AND u.UserId NOT IN (SELECT CustomerId FROM Customers);
    
    IF @@ROWCOUNT > 0
        PRINT '  Added ' + CAST(@@ROWCOUNT AS VARCHAR) + ' missing customer records';
END
GO

-- =============================================
-- STEP 5: Create CustomerActivities table
-- =============================================

PRINT 'Step 5: Creating CustomerActivities table...';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CustomerActivities')
BEGIN
    CREATE TABLE CustomerActivities (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        CustomerId INT NOT NULL,
        ActionType NVARCHAR(50) NOT NULL,
        Description NVARCHAR(500),
        Metadata NVARCHAR(MAX),
        CreatedAt DATETIME DEFAULT GETDATE(),
        CONSTRAINT FK_CustAct_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
    );
    PRINT '  Created CustomerActivities table';
END
ELSE PRINT '  CustomerActivities table already exists';
GO

-- =============================================
-- STEP 6: Add unique constraint to Email
-- =============================================

PRINT 'Step 6: Adding unique constraint to Email...';
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Users') AND name = 'UQ_Users_Email')
BEGIN
    -- Check for duplicates first
    IF NOT EXISTS (
        SELECT Email 
        FROM Users 
        WHERE Email IS NOT NULL 
        GROUP BY Email 
        HAVING COUNT(*) > 1
    )
    BEGIN
        ALTER TABLE Users ADD CONSTRAINT UQ_Users_Email UNIQUE (Email);
        PRINT '  Added unique constraint on Email';
    END
    ELSE
    BEGIN
        PRINT '  WARNING: Cannot add unique constraint - duplicate emails exist!';
        PRINT '  Please fix duplicate emails manually';
    END
END
ELSE PRINT '  Unique constraint on Email already exists';
GO

-- =============================================
-- FINAL: Show results
-- =============================================

PRINT '';
PRINT '==============================================';
PRINT 'MIGRATION COMPLETED SUCCESSFULLY!';
PRINT '==============================================';
PRINT '';
PRINT 'Users table structure:';
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Users'
ORDER BY ORDINAL_POSITION;
GO

PRINT '';
PRINT 'Available tables:';
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO

PRINT '';
PRINT '==============================================';
PRINT 'NEXT STEPS:';
PRINT '1. Restart Tomcat server';
PRINT '2. Login with: admin / 123456';
PRINT '3. Update your profile to test';
PRINT '==============================================';
GO




-- Sync data between Users and Customers tables
-- Chạy file này khi cần đồng bộ thủ công
USE TourManagement;
GO

PRINT '=== SYNCING USERS <-> CUSTOMERS ===';
PRINT '';

-- Step 1: Tạo Customer records nếu thiếu
PRINT 'Step 1: Creating missing Customer records...';
INSERT INTO Customers (CustomerId, Address, DateOfBirth, Status)
SELECT 
    u.UserId,
    u.Address,
    u.DateOfBirth,
    'active'
FROM Users u
LEFT JOIN Customers c ON u.UserId = c.CustomerId
WHERE c.CustomerId IS NULL
AND u.RoleId IN (SELECT RoleId FROM Roles WHERE RoleName IN ('USER', 'CUSTOMER'));

IF @@ROWCOUNT > 0
    PRINT '  Created ' + CAST(@@ROWCOUNT AS VARCHAR) + ' Customer record(s)';
ELSE
    PRINT '  All Customer records exist';
GO

PRINT '';

-- Step 2: Sync Users → Customers
PRINT 'Step 2: Syncing Users → Customers...';
UPDATE c
SET 
    c.Address = u.Address,
    c.DateOfBirth = u.DateOfBirth
FROM Customers c
INNER JOIN Users u ON c.CustomerId = u.UserId;

PRINT '  Synced ' + CAST(@@ROWCOUNT AS VARCHAR) + ' record(s)';
GO

PRINT '';

-- Step 3: Verify
PRINT 'Step 3: Verification...';
SELECT 
    u.UserId AS ID,
    u.Username,
    u.FullName,
    u.Email,
    u.PhoneNumber AS Phone,
    u.Address AS UserAddress,
    c.Address AS CustomerAddress,
    CASE 
        WHEN ISNULL(u.Address, '') = ISNULL(c.Address, '') THEN '✓ SYNCED'
        ELSE '✗ NOT SYNCED'
    END AS Status
FROM Users u
LEFT JOIN Customers c ON u.UserId = c.CustomerId
WHERE u.RoleId IN (SELECT RoleId FROM Roles WHERE RoleName IN ('USER', 'CUSTOMER'))
ORDER BY u.UserId;
GO

PRINT '';
PRINT '=== DONE ===';
PRINT 'Data synced. Refresh admin page to see changes.';

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

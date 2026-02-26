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

-- Bảng Cart (Giỏ hàng cho user đã đăng nhập)
CREATE TABLE Cart (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    tourId INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    addedAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (userId) REFERENCES Users(UserId) ON DELETE CASCADE,
    FOREIGN KEY (tourId) REFERENCES Tours(id) ON DELETE CASCADE,
    CONSTRAINT UQ_Cart_UserTour UNIQUE(userId, tourId)
);

-- Bảng Orders (Đơn đặt tour)
CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    orderCode NVARCHAR(20) UNIQUE NOT NULL,
    customerName NVARCHAR(100) NOT NULL,
    customerEmail NVARCHAR(100) NOT NULL,
    customerPhone NVARCHAR(20) NOT NULL,
    customerAddress NVARCHAR(255),
    totalAmount DECIMAL(12,2) NOT NULL,
    status NVARCHAR(20) NOT NULL DEFAULT 'PENDING',
    paymentStatus NVARCHAR(20) NOT NULL DEFAULT 'UNPAID',
    paymentMethod NVARCHAR(50),
    notes NTEXT,
    createdAt DATETIME2 DEFAULT GETDATE(),
    updatedAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (userId) REFERENCES Users(UserId),
    CONSTRAINT CK_Order_Status CHECK (status IN ('PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED')),
    CONSTRAINT CK_Payment_Status CHECK (paymentStatus IN ('UNPAID', 'PAID', 'REFUNDED'))
);

-- Bảng OrderItems (Chi tiết đơn hàng)
CREATE TABLE OrderItems (
    id INT IDENTITY(1,1) PRIMARY KEY,
    orderId INT NOT NULL,
    tourId INT NOT NULL,
    tourName NVARCHAR(200) NOT NULL,
    tourPrice DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (orderId) REFERENCES Orders(id) ON DELETE CASCADE,
    FOREIGN KEY (tourId) REFERENCES Tours(id)
);

-- Bảng Payments (Lịch sử thanh toán)
CREATE TABLE Payments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    orderId INT NOT NULL,
    paymentCode NVARCHAR(50) UNIQUE NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    paymentMethod NVARCHAR(50) NOT NULL,
    paymentStatus NVARCHAR(20) NOT NULL DEFAULT 'PENDING',
    transactionId NVARCHAR(100),
    paymentDate DATETIME2,
    createdAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (orderId) REFERENCES Orders(id) ON DELETE CASCADE,
    CONSTRAINT CK_Payment_Method CHECK (paymentMethod IN ('CASH', 'BANK_TRANSFER', 'CREDIT_CARD', 'MOMO', 'VNPAY')),
    CONSTRAINT CK_Payment_Status_Detail CHECK (paymentStatus IN ('PENDING', 'SUCCESS', 'FAILED', 'CANCELLED'))
);

-- Bảng AbandonedCarts (Giỏ hàng bị bỏ quên)
CREATE TABLE AbandonedCarts (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT,
    sessionId NVARCHAR(100),
    tourId INT NOT NULL,
    quantity INT NOT NULL,
    addedAt DATETIME2 NOT NULL,
    lastViewedAt DATETIME2 NOT NULL,
    abandonedAt DATETIME2,
    reminderSent BIT DEFAULT 0,
    reminderSentAt DATETIME2,
    converted BIT DEFAULT 0,
    convertedAt DATETIME2,
    orderId INT,
    FOREIGN KEY (userId) REFERENCES Users(UserId),
    FOREIGN KEY (tourId) REFERENCES Tours(id),
    FOREIGN KEY (orderId) REFERENCES Orders(id)
);

-- Bảng CartInteractions (Tương tác với giỏ hàng)
CREATE TABLE CartInteractions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT,
    sessionId NVARCHAR(100),
    tourId INT NOT NULL,
    action NVARCHAR(50) NOT NULL,
    quantity INT,
    createdAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (userId) REFERENCES Users(UserId),
    FOREIGN KEY (tourId) REFERENCES Tours(id),
    CONSTRAINT CK_Cart_Action CHECK (action IN ('ADD', 'UPDATE', 'REMOVE', 'VIEW', 'CHECKOUT_START', 'CHECKOUT_COMPLETE'))
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
CREATE INDEX IX_Cart_userId ON Cart(userId);
CREATE INDEX IX_Cart_tourId ON Cart(tourId);
CREATE INDEX IX_Orders_userId ON Orders(userId);
CREATE INDEX IX_Orders_orderCode ON Orders(orderCode);
CREATE INDEX IX_Orders_status ON Orders(status);
CREATE INDEX IX_OrderItems_orderId ON OrderItems(orderId);
CREATE INDEX IX_OrderItems_tourId ON OrderItems(tourId);
CREATE INDEX IX_Payments_orderId ON Payments(orderId);
CREATE INDEX IX_Payments_paymentCode ON Payments(paymentCode);
CREATE INDEX IX_AbandonedCarts_userId ON AbandonedCarts(userId);
CREATE INDEX IX_AbandonedCarts_sessionId ON AbandonedCarts(sessionId);
CREATE INDEX IX_AbandonedCarts_tourId ON AbandonedCarts(tourId);
CREATE INDEX IX_AbandonedCarts_abandonedAt ON AbandonedCarts(abandonedAt);
CREATE INDEX IX_AbandonedCarts_reminderSent ON AbandonedCarts(reminderSent);
CREATE INDEX IX_CartInteractions_userId ON CartInteractions(userId);
CREATE INDEX IX_CartInteractions_sessionId ON CartInteractions(sessionId);
CREATE INDEX IX_CartInteractions_tourId ON CartInteractions(tourId);
CREATE INDEX IX_CartInteractions_action ON CartInteractions(action);
CREATE INDEX IX_CartInteractions_createdAt ON CartInteractions(createdAt);

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

-- LƯU Ý: Tours sẽ được thêm từ file ADD_NEW_TOURS_2026.sql
-- Không thêm tours mẫu ở đây để tránh trùng lặp

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
PRINT 'LƯU Ý: Chạy ADD_NEW_TOURS_2026.sql để thêm 72 tours năm 2026';
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

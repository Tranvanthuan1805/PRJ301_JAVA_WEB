-- =============================================
-- TRAVEL BOOKING DATABASE - COMPLETE SCRIPT
-- Module: Users, Roles, Tours, Bookings, Revenue
-- =============================================


-- Tạo Database
CREATE DATABASE AdminUser;
GO
USE AdminUser;
GO
-- =============================================
-- BẢNG 1: ROLES (Vai trò người dùng)
-- =============================================
CREATE TABLE Roles (
    RoleId INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO Roles (RoleName) VALUES ('ADMIN');
INSERT INTO Roles (RoleName) VALUES ('USER');
-- =============================================
-- BẢNG 2: USERS (Người dùng)
-- =============================================
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(64) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    RoleId INT NOT NULL DEFAULT 2,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleId) REFERENCES Roles(RoleId)
);
-- Mật khẩu mẫu: 123456 (SHA-256 hash)
INSERT INTO Users (Username, PasswordHash, RoleId) VALUES 
    ('admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1),
    ('user1', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2),
    ('hieu', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2);
-- =============================================
-- BẢNG 3: TOURS (Danh sách Tour)
-- =============================================
CREATE TABLE Tours (
    TourId INT IDENTITY(1,1) PRIMARY KEY,
    TourName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    ShortDesc NVARCHAR(500),
    Price DECIMAL(18, 2) NOT NULL,
    ImageUrl VARCHAR(500),
    Duration NVARCHAR(50),
    StartLocation NVARCHAR(100),
    Itinerary NVARCHAR(MAX),
    Transport NVARCHAR(100),
    MaxPeople INT DEFAULT 30,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);
-- Dữ liệu mẫu Tours
INSERT INTO Tours (TourName, Description, ShortDesc, Price, ImageUrl, Duration, StartLocation, Transport, MaxPeople) VALUES 
(
    N'Tour Du Lịch Bà Nà Hills',
    N'Khám phá Bà Nà Hills - thiên đường du lịch trên mây với cáp treo dài nhất thế giới, Cầu Vàng nổi tiếng và làng Pháp cổ kính.',
    N'Trải nghiệm Cầu Vàng và làng Pháp trên đỉnh Bà Nà',
    1250000,
    'https://images.unsplash.com/photo-1555217851-6141535c9797?w=800',
    N'1 ngày',
    N'Đà Nẵng',
    N'Xe du lịch đời mới',
    30
),
(
    N'Tour Phố Cổ Hội An',
    N'Dạo bước qua những con phố cổ kính, ngắm đèn lồng lung linh và thưởng thức ẩm thực đặc sắc của phố Hội.',
    N'Khám phá phố cổ Hội An về đêm',
    850000,
    'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800',
    N'1 ngày',
    N'Đà Nẵng',
    N'Xe du lịch 16 chỗ',
    15
),
(
    N'Tour Khám Phá Hang Sơn Đoòng',
    N'Chinh phục hang động lớn nhất thế giới - Sơn Đoòng với hệ sinh thái độc đáo bên trong lòng núi.',
    N'Hành trình chinh phục hang động lớn nhất thế giới',
    70000000,
    'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    N'4 ngày 3 đêm',
    N'Quảng Bình',
    N'Xe du lịch + Đi bộ',
    10
),
(
    N'Tour Biển Mỹ Khê',
    N'Tận hưởng bãi biển đẹp nhất hành tinh với cát trắng mịn, nước xanh trong vắt và các hoạt động thể thao biển.',
    N'Nghỉ dưỡng tại bãi biển đẹp nhất châu Á',
    650000,
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
    N'1 ngày',
    N'Đà Nẵng',
    N'Xe đưa đón',
    50
),
(
    N'Tour Ngũ Hành Sơn',
    N'Khám phá quần thể núi Non Nước với hệ thống hang động, chùa chiền cổ kính và làng nghề điêu khắc đá truyền thống.',
    N'Tham quan danh thắng Ngũ Hành Sơn',
    450000,
    'https://images.unsplash.com/photo-1528127269322-539801943592?w=800',
    N'Nửa ngày',
    N'Đà Nẵng',
    N'Xe du lịch',
    25
);
-- =============================================
-- BẢNG 4: BOOKINGS (Đơn đặt tour)
-- =============================================
CREATE TABLE Bookings (
    BookingId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    TourId INT NOT NULL,
    BookingDate DATETIME DEFAULT GETDATE(),
    NumberOfPeople INT DEFAULT 1,
    TotalPrice DECIMAL(18, 2),
    Status NVARCHAR(50) DEFAULT 'Pending',
    PaymentStatus VARCHAR(20) DEFAULT 'UNPAID',
    UpdatedAt DATETIME,
    CancelReason NVARCHAR(500),
    RefundAmount DECIMAL(18, 2) DEFAULT 0,
    
    CONSTRAINT FK_Bookings_Users FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT FK_Bookings_Tours FOREIGN KEY (TourId) REFERENCES Tours(TourId),
    CONSTRAINT CHK_Bookings_Status CHECK (Status IN ('Pending', 'Confirmed', 'InProgress', 'Completed', 'Cancelled')),
    CONSTRAINT CHK_Bookings_PaymentStatus CHECK (PaymentStatus IN ('UNPAID', 'PAID', 'REFUNDED'))
);
-- Dữ liệu mẫu Bookings
INSERT INTO Bookings (UserId, TourId, BookingDate, NumberOfPeople, TotalPrice, Status, PaymentStatus) VALUES 
(3, 1, DATEADD(day, -5, GETDATE()), 2, 2500000, 'Completed', 'PAID'),
(3, 2, DATEADD(day, -3, GETDATE()), 3, 2550000, 'Confirmed', 'PAID'),
(2, 1, DATEADD(day, -2, GETDATE()), 1, 1250000, 'Pending', 'UNPAID'),
(3, 4, DATEADD(day, -1, GETDATE()), 4, 2600000, 'Pending', 'UNPAID'),
(2, 3, GETDATE(), 2, 140000000, 'Cancelled', 'REFUNDED');
-- Cập nhật UpdatedAt
UPDATE Bookings SET UpdatedAt = DATEADD(hour, 2, BookingDate) WHERE Status != 'Pending';
UPDATE Bookings SET CancelReason = N'Khách hủy do thay đổi lịch trình', RefundAmount = 112000000 WHERE Status = 'Cancelled';
-- =============================================
-- BẢNG 5: REVENUE (Doanh thu theo ngày)
-- =============================================
CREATE TABLE Revenue (
    RevenueId INT IDENTITY(1,1) PRIMARY KEY,
    RevenueDate DATE NOT NULL UNIQUE,
    TotalAmount DECIMAL(18,2) DEFAULT 0,
    CompletedBookings INT DEFAULT 0,
    CancelledBookings INT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME
);
-- Dữ liệu mẫu Revenue
INSERT INTO Revenue (RevenueDate, TotalAmount, CompletedBookings, CancelledBookings) VALUES
(CAST(DATEADD(day, -5, GETDATE()) AS DATE), 2500000, 1, 0),
(CAST(GETDATE() AS DATE), 0, 0, 1);

-- Kiểm tra
SELECT * FROM Roles;
SELECT * FROM Users;
SELECT * FROM Tours;
SELECT * FROM Bookings;
SELECT * FROM Revenue;

GO

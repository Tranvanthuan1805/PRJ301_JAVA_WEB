CREATE DATABASE AdminUser;
GO

USE AdminUser;
GO

CREATE TABLE Roles (
    RoleId INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(64) NOT NULL,
    RoleId INT NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleId)
        REFERENCES Roles(RoleId)
);
INSERT INTO Roles (RoleName) VALUES ('ADMIN');
INSERT INTO Roles (RoleName) VALUES ('USER');

INSERT INTO Users (Username, PasswordHash, RoleId) VALUES 
('admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1), -- Admin
('user1', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2), -- User thường
('hieu', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2);

-- =============================================
-- PHẦN 2: MODULE TOUR & BOOKING
-- =============================================

-- Bảng Danh sách Tour
CREATE TABLE Tours (
    TourId INT IDENTITY(1,1) PRIMARY KEY,
    TourName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(18, 2) NOT NULL,
    ImageUrl VARCHAR(500),
    Duration NVARCHAR(50),      -- Ví dụ: 3 ngày 2 đêm
    StartLocation NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Bảng Đặt Tour (Nối User và Tour)
CREATE TABLE Bookings (
    BookingId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,        -- FK nối về Users
    TourId INT NOT NULL,        -- FK nối về Tours
    BookingDate DATETIME DEFAULT GETDATE(),
    NumberOfPeople INT DEFAULT 1,
    TotalPrice DECIMAL(18, 2),
    Status NVARCHAR(50) DEFAULT 'Pending', -- Pending, Confirmed, Cancelled
    
    CONSTRAINT FK_Bookings_Users FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT FK_Bookings_Tours FOREIGN KEY (TourId) REFERENCES Tours(TourId)
);

-- Data mẫu cho Tours (Để test giao diện)
INSERT INTO Tours (TourName, Price, Duration, ImageUrl) VALUES 
(N'Tour Du Lịch Bà Nà Hills', 1250000, N'1 ngày', 'https://example.com/bana.jpg'),
(N'Tour Phố Cổ Hội An', 850000, N'1 ngày', 'https://example.com/hoian.jpg'),
(N'Tour Khám Phá Hang Sơn Đoòng', 70000000, N'4 ngày 3 đêm', 'https://example.com/sondoong.jpg');

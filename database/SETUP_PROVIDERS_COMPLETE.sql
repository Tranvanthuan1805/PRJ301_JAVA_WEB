-- =============================================
-- SETUP HOÀN CHỈNH CHO TÍNH NĂNG NHÀ CUNG CẤP
-- Database: DaNangTravelHub
-- =============================================

USE DaNangTravelHub;
GO

-- =============================================
-- BƯỚC 1: Kiểm tra và tạo Roles nếu chưa có
-- =============================================

IF NOT EXISTS (SELECT 1 FROM Roles WHERE RoleName = 'ADMIN')
    INSERT INTO Roles (RoleName) VALUES ('ADMIN');

IF NOT EXISTS (SELECT 1 FROM Roles WHERE RoleName = 'PROVIDER')
    INSERT INTO Roles (RoleName) VALUES ('PROVIDER');

IF NOT EXISTS (SELECT 1 FROM Roles WHERE RoleName = 'CUSTOMER')
    INSERT INTO Roles (RoleName) VALUES ('CUSTOMER');

GO

-- =============================================
-- BƯỚC 2: Lấy RoleId cho PROVIDER
-- =============================================

DECLARE @ProviderRoleId INT;
SELECT @ProviderRoleId = RoleId FROM Roles WHERE RoleName = 'PROVIDER';

-- =============================================
-- BƯỚC 3: Tạo User accounts cho Providers
-- =============================================

-- Provider 1: Vinpearl Hotels
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'vinpearl@hotels.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('vinpearl@hotels.vn', 'vinpearl', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', @ProviderRoleId, 'Vinpearl Hotels & Resorts', '0236 3 888 999', 1, GETDATE(), GETDATE());
END

-- Provider 2: Furama Resort
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'furama@resort.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('furama@resort.vn', 'furama', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', @ProviderRoleId, 'Furama Resort Danang', '0236 3 847 333', 1, GETDATE(), GETDATE());
END

-- Provider 3: Sun World Ba Na Hills
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'banahills@sunworld.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('banahills@sunworld.vn', 'banahills', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', @ProviderRoleId, 'Sun World Ba Na Hills', '0236 3 791 999', 1, GETDATE(), GETDATE());
END

-- Provider 4: Vietravel Danang
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'vietravel@danang.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('vietravel@danang.vn', 'vietravel', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', @ProviderRoleId, 'Vietravel Danang', '0236 3 822 390', 1, GETDATE(), GETDATE());
END

-- Provider 5: Danang Bus
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'danangbus@transport.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('danangbus@transport.vn', 'danangbus', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', @ProviderRoleId, 'Danang Bus Company', '0236 3 654 321', 1, GETDATE(), GETDATE());
END

-- Provider 6: Saigon Tourist
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'saigontourist@vn.com')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('saigontourist@vn.com', 'saigontourist', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', @ProviderRoleId, 'Saigon Tourist', '0236 3 555 666', 1, GETDATE(), GETDATE());
END

-- Provider 7: Melia Hotels
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'melia@danang.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('melia@danang.vn', 'melia', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', @ProviderRoleId, 'Melia Hotels Danang', '0236 3 777 888', 1, GETDATE(), GETDATE());
END

-- Provider 8: Viet Fly Airlines
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'vietfly@airlines.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('vietfly@airlines.vn', 'vietfly', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', @ProviderRoleId, 'Viet Fly Airlines', '0236 3 999 111', 1, GETDATE(), GETDATE());
END

-- Provider 9: Luxury Cruise Vietnam
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'luxurycruise@vn.com')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('luxurycruise@vn.com', 'luxurycruise', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', @ProviderRoleId, 'Luxury Cruise Vietnam', '0236 3 222 333', 1, GETDATE(), GETDATE());
END

-- Provider 10: Danang Taxi Service
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'danang.taxi@service.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('danang.taxi@service.vn', 'danang_taxi', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', @ProviderRoleId, 'Danang Taxi Service', '0236 3 444 555', 1, GETDATE(), GETDATE());
END

GO

-- =============================================
-- BƯỚC 4: Tạo Provider records
-- =============================================

-- Xóa dữ liệu cũ nếu có (để tránh duplicate)
DELETE FROM ProviderPriceHistory WHERE ProviderId IN (
    SELECT UserId FROM Users WHERE Email IN (
        'vinpearl@hotels.vn', 'furama@resort.vn', 'banahills@sunworld.vn',
        'vietravel@danang.vn', 'danangbus@transport.vn', 'saigontourist@vn.com',
        'melia@danang.vn', 'vietfly@airlines.vn', 'luxurycruise@vn.com', 'danang.taxi@service.vn'
    )
);

DELETE FROM Providers WHERE ProviderId IN (
    SELECT UserId FROM Users WHERE Email IN (
        'vinpearl@hotels.vn', 'furama@resort.vn', 'banahills@sunworld.vn',
        'vietravel@danang.vn', 'danangbus@transport.vn', 'saigontourist@vn.com',
        'melia@danang.vn', 'vietfly@airlines.vn', 'luxurycruise@vn.com', 'danang.taxi@service.vn'
    )
);

GO

-- Insert Providers
INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive)
SELECT UserId, FullName, 'BL-' + CAST(UserId AS NVARCHAR(10)), 
    CASE 
        WHEN Email LIKE '%hotel%' OR Email LIKE '%resort%' OR Email LIKE '%melia%' THEN 'Hotel'
        WHEN Email LIKE '%tour%' OR Email LIKE '%saigon%' OR Email LIKE '%cruise%' THEN 'TourOperator'
        WHEN Email LIKE '%bus%' OR Email LIKE '%taxi%' OR Email LIKE '%fly%' THEN 'Transport'
        ELSE 'Hotel'
    END,
    CAST(RAND() * 5 + 3.5 AS DECIMAL(3,2)), -- Rating từ 3.5 đến 4.5
    1, -- IsVerified
    CAST(RAND() * 100 + 10 AS INT), -- TotalTours từ 10 đến 110
    1 -- IsActive
FROM Users 
WHERE Email IN (
    'vinpearl@hotels.vn', 'furama@resort.vn', 'banahills@sunworld.vn',
    'vietravel@danang.vn', 'danangbus@transport.vn', 'saigontourist@vn.com',
    'melia@danang.vn', 'vietfly@airlines.vn', 'luxurycruise@vn.com', 'danang.taxi@service.vn'
);

GO

-- =============================================
-- BƯỚC 5: Tạo ProviderPriceHistory (Lịch sử giá)
-- =============================================

INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
SELECT TOP 1 ProviderId, 'Hotel', 'Phòng Deluxe', 1500000, 1650000, DATEADD(DAY, -30, GETDATE()), 'Tăng giá mùa cao điểm'
FROM Providers WHERE BusinessName LIKE '%Vinpearl%';

INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
SELECT TOP 1 ProviderId, 'Hotel', 'Phòng Suite', 2500000, 2700000, DATEADD(DAY, -20, GETDATE()), 'Cập nhật giá'
FROM Providers WHERE BusinessName LIKE '%Furama%';

INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
SELECT TOP 1 ProviderId, 'Tour', 'Tour Ba Na Hills', 800000, 850000, DATEADD(DAY, -15, GETDATE()), 'Giá mới'
FROM Providers WHERE BusinessName LIKE '%Ba Na%';

INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
SELECT TOP 1 ProviderId, 'Tour', 'Tour Hội An', 600000, 650000, DATEADD(DAY, -10, GETDATE()), 'Khuyến mãi'
FROM Providers WHERE BusinessName LIKE '%Vietravel%';

INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
SELECT TOP 1 ProviderId, 'Transport', 'Vé xe Đà Nẵng - Hà Nội', 350000, 380000, DATEADD(DAY, -5, GETDATE()), 'Tăng giá xăng'
FROM Providers WHERE BusinessName LIKE '%Bus%';

-- Thêm nhiều records hơn cho mỗi provider
INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
SELECT ProviderId, 'Hotel', 'Phòng Standard', 800000, 900000, DATEADD(DAY, -25, GETDATE()), 'Cập nhật'
FROM Providers WHERE BusinessName LIKE '%Melia%';

INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
SELECT ProviderId, 'Transport', 'Vé máy bay', 1200000, 1350000, DATEADD(DAY, -12, GETDATE()), 'Giá mùa cao điểm'
FROM Providers WHERE BusinessName LIKE '%Viet Fly%';

INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
SELECT ProviderId, 'Tour', 'Tour du thuyền', 2000000, 2200000, DATEADD(DAY, -8, GETDATE()), 'Bao gồm ăn sáng'
FROM Providers WHERE BusinessName LIKE '%Cruise%';

INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
SELECT ProviderId, 'Transport', 'Taxi sân bay', 150000, 180000, DATEADD(DAY, -3, GETDATE()), 'Tăng giá'
FROM Providers WHERE BusinessName LIKE '%Taxi%';

INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
SELECT ProviderId, 'Tour', 'Tour Saigon', 500000, 550000, DATEADD(DAY, -7, GETDATE()), 'Khuyến mãi'
FROM Providers WHERE BusinessName LIKE '%Saigon%';

GO

-- =============================================
-- BƯỚC 6: Kiểm tra dữ liệu
-- =============================================

PRINT '=== KIỂM TRA DỮ LIỆU ==='
PRINT 'Tổng Providers: ' + CAST(COUNT(*) AS NVARCHAR(10)) FROM Providers;
PRINT 'Tổng ProviderPriceHistory: ' + CAST(COUNT(*) AS NVARCHAR(10)) FROM ProviderPriceHistory;

SELECT 'Danh sách Providers:' AS Info;
SELECT ProviderId, BusinessName, ProviderType, Rating, IsVerified, IsActive 
FROM Providers 
ORDER BY Rating DESC;

SELECT 'Lịch sử giá:' AS Info;
SELECT TOP 10 ph.PriceId, p.BusinessName, ph.ServiceType, ph.ServiceName, ph.OldPrice, ph.NewPrice, ph.ChangeDate
FROM ProviderPriceHistory ph
JOIN Providers p ON ph.ProviderId = p.ProviderId
ORDER BY ph.ChangeDate DESC;

GO

PRINT '✅ Setup hoàn thành!'

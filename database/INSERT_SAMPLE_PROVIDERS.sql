-- =============================================
-- INSERT DỮ LIỆU MẪU CHO NHÀ CUNG CẤP
-- Database: DaNangTravelHub
-- =============================================

USE DaNangTravelHub;
GO

-- =============================================
-- 1. Tạo User accounts cho Providers
-- =============================================

-- Provider 1: Vinpearl Hotels
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'vinpearl@hotels.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('vinpearl@hotels.vn', 'vinpearl', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 'Vinpearl Hotels & Resorts', '0236 3 888 999', 1, GETDATE(), GETDATE());
END
GO

-- Provider 2: Furama Resort
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'furama@resort.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('furama@resort.vn', 'furama', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 'Furama Resort Danang', '0236 3 847 333', 1, GETDATE(), GETDATE());
END
GO

-- Provider 3: Sun World Ba Na Hills
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'banahills@sunworld.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('banahills@sunworld.vn', 'banahills', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 'Sun World Ba Na Hills', '0236 3 791 999', 1, GETDATE(), GETDATE());
END
GO

-- Provider 4: Vietravel Danang
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'vietravel@danang.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('vietravel@danang.vn', 'vietravel', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 'Vietravel Danang', '0236 3 822 390', 1, GETDATE(), GETDATE());
END
GO

-- Provider 5: Danang Bus
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'danangbus@transport.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('danangbus@transport.vn', 'danangbus', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 'Danang Bus Company', '0236 3 654 321', 1, GETDATE(), GETDATE());
END
GO

-- =============================================
-- 2. Insert Providers (1:1 với Users)
-- =============================================

-- Provider 1: Vinpearl Hotels
DECLARE @VinpearlUserId INT = (SELECT UserId FROM Users WHERE Email = 'vinpearl@hotels.vn');
IF @VinpearlUserId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Providers WHERE ProviderId = @VinpearlUserId)
BEGIN
    INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive)
    VALUES (@VinpearlUserId, 'Vinpearl Hotels & Resorts', 'BL-VIN-2020-001', 'Hotel', 4.8, 1, 15, 1);
END
GO

-- Provider 2: Furama Resort
DECLARE @FuramaUserId INT = (SELECT UserId FROM Users WHERE Email = 'furama@resort.vn');
IF @FuramaUserId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Providers WHERE ProviderId = @FuramaUserId)
BEGIN
    INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive)
    VALUES (@FuramaUserId, 'Furama Resort Danang', 'BL-FUR-2018-002', 'Hotel', 4.9, 1, 12, 1);
END
GO

-- Provider 3: Sun World Ba Na Hills
DECLARE @BanaUserId INT = (SELECT UserId FROM Users WHERE Email = 'banahills@sunworld.vn');
IF @BanaUserId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Providers WHERE ProviderId = @BanaUserId)
BEGIN
    INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive)
    VALUES (@BanaUserId, 'Sun World Ba Na Hills', 'BL-SUN-2015-003', 'TourOperator', 4.7, 1, 25, 1);
END
GO

-- Provider 4: Vietravel Danang
DECLARE @VietravelUserId INT = (SELECT UserId FROM Users WHERE Email = 'vietravel@danang.vn');
IF @VietravelUserId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Providers WHERE ProviderId = @VietravelUserId)
BEGIN
    INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive)
    VALUES (@VietravelUserId, 'Vietravel Danang', 'BL-VTR-2010-004', 'TourOperator', 4.6, 1, 30, 1);
END
GO

-- Provider 5: Danang Bus
DECLARE @BusUserId INT = (SELECT UserId FROM Users WHERE Email = 'danangbus@transport.vn');
IF @BusUserId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Providers WHERE ProviderId = @BusUserId)
BEGIN
    INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive)
    VALUES (@BusUserId, 'Danang Bus Company', 'BL-BUS-2019-005', 'Transport', 4.5, 1, 8, 1);
END
GO

-- =============================================
-- 3. Insert Provider Price History (Lịch sử giá)
-- =============================================

-- Vinpearl - Room prices
DECLARE @VinpearlId INT = (SELECT ProviderId FROM Providers WHERE BusinessName = 'Vinpearl Hotels & Resorts');
IF @VinpearlId IS NOT NULL
BEGIN
    INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
    VALUES 
        (@VinpearlId, 'Hotel', 'Deluxe Ocean View Room', 2500000, 2800000, DATEADD(DAY, -30, GETDATE()), N'Tăng giá mùa cao điểm'),
        (@VinpearlId, 'Hotel', 'Suite Room', 4500000, 4200000, DATEADD(DAY, -15, GETDATE()), N'Khuyến mãi đặc biệt'),
        (@VinpearlId, 'Hotel', 'Standard Room', 1800000, 1800000, DATEADD(DAY, -7, GETDATE()), N'Giữ nguyên giá');
END
GO

-- Furama - Room prices
DECLARE @FuramaId INT = (SELECT ProviderId FROM Providers WHERE BusinessName = 'Furama Resort Danang');
IF @FuramaId IS NOT NULL
BEGIN
    INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
    VALUES 
        (@FuramaId, 'Hotel', 'Beach Villa', 5500000, 6000000, DATEADD(DAY, -25, GETDATE()), N'Nâng cấp tiện nghi'),
        (@FuramaId, 'Hotel', 'Garden View Room', 3200000, 2900000, DATEADD(DAY, -10, GETDATE()), N'Giảm giá thu hút khách'),
        (@FuramaId, 'Hotel', 'Pool View Room', 3800000, 3800000, DATEADD(DAY, -5, GETDATE()), N'Giá ổn định');
END
GO

-- Ba Na Hills - Tour prices
DECLARE @BanaId INT = (SELECT ProviderId FROM Providers WHERE BusinessName = 'Sun World Ba Na Hills');
IF @BanaId IS NOT NULL
BEGIN
    INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
    VALUES 
        (@BanaId, 'Tour', 'Vé cáp treo + Buffet', 750000, 850000, DATEADD(DAY, -20, GETDATE()), N'Tăng giá vé'),
        (@BanaId, 'Tour', 'Vé cáp treo đơn', 650000, 700000, DATEADD(DAY, -12, GETDATE()), N'Điều chỉnh theo thị trường'),
        (@BanaId, 'Tour', 'Combo Family 4 người', 2800000, 3000000, DATEADD(DAY, -8, GETDATE()), N'Gói gia đình mới');
END
GO

-- Vietravel - Tour packages
DECLARE @VietravelId INT = (SELECT ProviderId FROM Providers WHERE BusinessName = 'Vietravel Danang');
IF @VietravelId IS NOT NULL
BEGIN
    INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
    VALUES 
        (@VietravelId, 'Tour', 'Hội An - Cù Lao Chàm 1 ngày', 850000, 900000, DATEADD(DAY, -18, GETDATE()), N'Tăng chi phí xăng dầu'),
        (@VietravelId, 'Tour', 'Huế - Động Phong Nha 2N1Đ', 2500000, 2300000, DATEADD(DAY, -9, GETDATE()), N'Khuyến mãi cuối tuần'),
        (@VietravelId, 'Tour', 'City Tour Đà Nẵng', 450000, 450000, DATEADD(DAY, -3, GETDATE()), N'Giá cố định');
END
GO

-- Danang Bus - Transport prices
DECLARE @BusId INT = (SELECT ProviderId FROM Providers WHERE BusinessName = 'Danang Bus Company');
IF @BusId IS NOT NULL
BEGIN
    INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note)
    VALUES 
        (@BusId, 'Transport', 'Xe 16 chỗ (1 ngày)', 1200000, 1400000, DATEADD(DAY, -22, GETDATE()), N'Tăng giá xăng'),
        (@BusId, 'Transport', 'Xe 45 chỗ (1 ngày)', 2500000, 2800000, DATEADD(DAY, -14, GETDATE()), N'Bảo dưỡng xe mới'),
        (@BusId, 'Transport', 'Xe Limousine 9 chỗ', 1800000, 1700000, DATEADD(DAY, -6, GETDATE()), N'Giảm giá cạnh tranh');
END
GO

-- =============================================
-- 4. Thêm thêm 5 Providers nữa
-- =============================================

-- Provider 6: Hoi An Express
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'hoianexpress@tour.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('hoianexpress@tour.vn', 'hoianexpress', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 'Hoi An Express Tours', '0235 3 861 327', 1, GETDATE(), GETDATE());
    
    DECLARE @HoiAnUserId INT = SCOPE_IDENTITY();
    INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive)
    VALUES (@HoiAnUserId, 'Hoi An Express Tours', 'BL-HOI-2017-006', 'TourOperator', 4.4, 1, 18, 1);
END
GO

-- Provider 7: Marble Mountain Hotel
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'marble@hotel.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('marble@hotel.vn', 'marblehotel', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 'Marble Mountain Hotel', '0236 3 965 888', 1, GETDATE(), GETDATE());
    
    DECLARE @MarbleUserId INT = SCOPE_IDENTITY();
    INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive)
    VALUES (@MarbleUserId, 'Marble Mountain Hotel', 'BL-MAR-2019-007', 'Hotel', 4.3, 1, 10, 1);
END
GO

-- Provider 8: My Khe Beach Resort
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'mykhe@resort.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('mykhe@resort.vn', 'mykheresort', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 'My Khe Beach Resort', '0236 3 959 555', 1, GETDATE(), GETDATE());
    
    DECLARE @MyKheUserId INT = SCOPE_IDENTITY();
    INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive)
    VALUES (@MyKheUserId, 'My Khe Beach Resort', 'BL-MYK-2021-008', 'Hotel', 4.6, 1, 14, 1);
END
GO

-- Provider 9: Son Tra Transport
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'sontra@transport.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('sontra@transport.vn', 'sontratrans', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 'Son Tra Transport', '0236 3 777 444', 1, GETDATE(), GETDATE());
    
    DECLARE @SonTraUserId INT = SCOPE_IDENTITY();
    INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive)
    VALUES (@SonTraUserId, 'Son Tra Transport', 'BL-SON-2020-009', 'Transport', 4.2, 1, 6, 1);
END
GO

-- Provider 10: Asia Park Entertainment
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'asiapark@entertainment.vn')
BEGIN
    INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, IsActive, CreatedAt, UpdatedAt)
    VALUES ('asiapark@entertainment.vn', 'asiapark', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, 'Asia Park Entertainment', '0236 3 681 666', 1, GETDATE(), GETDATE());
    
    DECLARE @AsiaParkUserId INT = SCOPE_IDENTITY();
    INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive)
    VALUES (@AsiaParkUserId, 'Asia Park Entertainment', 'BL-ASI-2016-010', 'TourOperator', 4.5, 1, 20, 1);
END
GO

-- =============================================
-- 5. Verify Data
-- =============================================

PRINT '==============================================';
PRINT 'ĐÃ INSERT DỮ LIỆU MẪU THÀNH CÔNG!';
PRINT '==============================================';

SELECT 
    p.ProviderId,
    p.BusinessName,
    p.ProviderType,
    p.Rating,
    p.IsVerified,
    p.TotalTours,
    u.Email,
    u.PhoneNumber
FROM Providers p
INNER JOIN Users u ON p.ProviderId = u.UserId
ORDER BY p.ProviderId;

PRINT '==============================================';
PRINT 'TỔNG SỐ PROVIDERS: ' + CAST((SELECT COUNT(*) FROM Providers) AS VARCHAR);
PRINT 'TỔNG SỐ PRICE HISTORY: ' + CAST((SELECT COUNT(*) FROM ProviderPriceHistory) AS VARCHAR);
PRINT '==============================================';

GO

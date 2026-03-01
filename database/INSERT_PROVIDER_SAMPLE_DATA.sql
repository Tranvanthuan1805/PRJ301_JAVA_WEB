-- =============================================
-- SAMPLE DATA: Providers và Price History
-- PURPOSE: Dữ liệu mẫu cho chức năng NCC
-- DATE: 2026-03-01
-- =============================================

USE DaNangTravelHub;
GO

PRINT '==============================================';
PRINT 'BẮT ĐẦU INSERT SAMPLE DATA: Providers';
PRINT '==============================================';

-- Tạo Users cho Providers (RoleId = 2 là PROVIDER)
SET IDENTITY_INSERT Users ON;

INSERT INTO Users (UserId, Email, Username, PasswordHash, RoleId, FullName, PhoneNumber, Address, IsActive, CreatedAt) VALUES
(101, 'vinpearl@danang.com', 'vinpearl', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, N'Vinpearl Đà Nẵng', '0236 3777 888', N'Bãi Biển Mỹ Khê, Ngũ Hành Sơn', 1, '2024-01-15'),
(102, 'muongthanh@danang.com', 'muongthanh', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, N'Mường Thanh Luxury', '0236 3999 777', N'270 Võ Nguyên Giáp, Sơn Trà', 1, '2024-02-10'),
(103, 'novotel@danang.com', 'novotel', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, N'Novotel Đà Nẵng', '0236 3929 999', N'36 Bạch Đằng, Hải Châu', 1, '2024-01-20'),
(104, 'banahills@danang.com', 'banahills', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, N'Bà Nà Hills Tours', '0236 3791 999', N'Hòa Ninh, Hòa Vang', 1, '2023-12-05'),
(105, 'hoiantravel@danang.com', 'hoiantravel', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, N'Hội An Travel', '0235 3861 327', N'78 Trần Phú, Hội An', 1, '2024-02-28'),
(106, 'danangtours@danang.com', 'danangtours', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, N'Đà Nẵng Tours', '0236 3555 444', N'45 Lê Duẩn, Hải Châu', 1, '2024-03-01'),
(107, 'grab@danang.com', 'grabdn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, N'Grab Đà Nẵng', '1900 1234', N'Đà Nẵng', 1, '2023-09-15'),
(108, 'mailinh@danang.com', 'mailinh', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, N'Mai Linh Taxi', '0236 3565 656', N'Đà Nẵng', 1, '2023-08-20'),
(109, 'hyatt@danang.com', 'hyatt', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, N'Hyatt Regency', '0236 3981 234', N'5 Trường Sa, Ngũ Hành Sơn', 1, '2024-02-15'),
(110, 'sontratours@danang.com', 'sontratours', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, N'Sơn Trà Tours', '0236 3888 777', N'Sơn Trà, Đà Nẵng', 1, '2024-03-10');

SET IDENTITY_INSERT Users OFF;

PRINT '✓ Thêm 10 Users (Providers) thành công';
GO

-- Insert Providers
INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive) VALUES
(101, N'Vinpearl Đà Nẵng', 'BL-HOTEL-001', 'Hotel', 4.9, 1, 25, 1),
(102, N'Mường Thanh Luxury', 'BL-HOTEL-002', 'Hotel', 4.7, 1, 20, 1),
(103, N'Novotel Đà Nẵng', 'BL-HOTEL-003', 'Hotel', 4.6, 1, 18, 1),
(104, N'Bà Nà Hills Tours', 'BL-TOUR-001', 'TourOperator', 4.8, 1, 35, 1),
(105, N'Hội An Travel', 'BL-TOUR-002', 'TourOperator', 4.7, 1, 28, 1),
(106, N'Đà Nẵng Tours', 'BL-TOUR-003', 'TourOperator', 4.5, 1, 22, 1),
(107, N'Grab Đà Nẵng', 'BL-TRANS-001', 'Transport', 4.3, 1, 0, 1),
(108, N'Mai Linh Taxi', 'BL-TRANS-002', 'Transport', 4.4, 1, 0, 1),
(109, N'Hyatt Regency', 'BL-HOTEL-004', 'Hotel', 4.9, 1, 15, 1),
(110, N'Sơn Trà Tours', 'BL-TOUR-004', 'TourOperator', 4.6, 1, 18, 1);

PRINT '✓ Thêm 10 Providers thành công';
GO

-- Insert Price History (cho chức năng so sánh)
INSERT INTO ProviderPriceHistory (ProviderId, ServiceType, ServiceName, OldPrice, NewPrice, ChangeDate, Note) VALUES
-- Hotels
(101, 'Hotel', N'Phòng Deluxe Sea View', 2000000.00, 2200000.00, '2024-03-01', N'Tăng giá mùa cao điểm'),
(101, 'Hotel', N'Phòng Standard', 1500000.00, 1450000.00, '2024-02-15', N'Khuyến mãi đầu năm'),
(102, 'Hotel', N'Phòng Suite', 3000000.00, 2800000.00, '2024-02-20', N'Giảm giá sau Tết'),
(102, 'Hotel', N'Phòng Standard', 1200000.00, 1300000.00, '2024-03-01', N'Điều chỉnh giá'),
(103, 'Hotel', N'Phòng Deluxe', 1800000.00, 1750000.00, '2024-02-25', N'Khuyến mãi sinh nhật'),
(109, 'Hotel', N'Phòng Premium', 3500000.00, 3800000.00, '2024-03-01', N'Tăng giá cao điểm'),

-- Tours
(104, 'Tour', N'Tour Bà Nà 1 ngày', 1500000.00, 1600000.00, '2024-03-01', N'Tăng giá vé cáp treo'),
(104, 'Tour', N'Tour Bà Nà VIP', 2000000.00, 2200000.00, '2024-03-05', N'Bao gồm buffet'),
(105, 'Tour', N'Tour Hội An + Mỹ Sơn', 1200000.00, 1100000.00, '2024-02-15', N'Khuyến mãi nhóm'),
(105, 'Tour', N'Tour Phố Cổ Hội An', 800000.00, 750000.00, '2024-02-20', N'Giảm giá thấp điểm'),
(106, 'Tour', N'Tour Ngũ Hành Sơn', 600000.00, 650000.00, '2024-03-01', N'Điều chỉnh giá xăng'),
(110, 'Tour', N'Tour Sơn Trà', 700000.00, 680000.00, '2024-03-10', N'Khuyến mãi sinh viên'),

-- Transport
(107, 'Transport', N'Grab Car', 50000.00, 55000.00, '2024-03-01', N'Tăng giá giờ cao điểm'),
(107, 'Transport', N'Grab Bike', 20000.00, 18000.00, '2024-02-20', N'Khuyến mãi người dùng mới'),
(108, 'Transport', N'Mai Linh Taxi', 12000.00, 13000.00, '2024-03-01', N'Điều chỉnh giá xăng');

PRINT '✓ Thêm 15 Price History records thành công';
GO

PRINT '==============================================';
PRINT 'HOÀN TẤT INSERT SAMPLE DATA';
PRINT '==============================================';
PRINT 'TỔNG SỐ PROVIDERS: 10';
PRINT '  - Hotels: 4';
PRINT '  - Tours: 4';
PRINT '  - Transport: 2';
PRINT '==============================================';
PRINT 'TỔNG SỐ PRICE HISTORY: 15 records';
PRINT '==============================================';

-- =============================================
-- INSERT SAMPLE PROVIDERS
-- PURPOSE: Thêm dữ liệu mẫu cho bảng Providers
-- DATE: 2026-03-01
-- =============================================

USE DaNangTravelHub;
GO

-- Thêm 10 nhà cung cấp mẫu
INSERT INTO Providers (ProviderId, BusinessName, BusinessLicense, ProviderType, Rating, IsVerified, TotalTours, IsActive, JoinDate, Status, Description)
VALUES
-- Hotels
(101, N'Khách Sạn Mường Thanh Luxury', 'KS-DN-001', 'Hotel', 4.8, 1, 25, 1, '2024-01-15', 'Active', N'Khách sạn 5 sao sang trọng bên bờ biển Đà Nẵng'),
(102, N'Vinpearl Resort & Spa', 'KS-DN-002', 'Hotel', 4.9, 1, 30, 1, '2024-02-01', 'Active', N'Resort cao cấp với view biển tuyệt đẹp'),
(103, N'Fusion Maia Resort', 'KS-DN-003', 'Hotel', 4.7, 1, 20, 1, '2024-03-10', 'Active', N'Resort all-inclusive với spa miễn phí'),

-- Tour Operators
(104, N'Vietravel Đà Nẵng', 'TOUR-DN-001', 'TourOperator', 4.6, 1, 45, 1, '2023-11-20', 'Active', N'Công ty du lịch hàng đầu Việt Nam'),
(105, N'Saigontourist Đà Nẵng', 'TOUR-DN-002', 'TourOperator', 4.5, 1, 38, 1, '2024-01-05', 'Active', N'Chuyên tour trong nước và quốc tế'),
(106, N'Asia Pacific Travel', 'TOUR-DN-003', 'TourOperator', 4.7, 1, 42, 1, '2024-02-15', 'Active', N'Tour cao cấp và dịch vụ VIP'),

-- Transport
(107, N'Mai Linh Taxi Đà Nẵng', 'VT-DN-001', 'Transport', 4.4, 1, 15, 1, '2023-12-01', 'Active', N'Dịch vụ taxi uy tín tại Đà Nẵng'),
(108, N'Grab Đà Nẵng', 'VT-DN-002', 'Transport', 4.3, 1, 12, 1, '2024-01-20', 'Active', N'Dịch vụ đặt xe công nghệ'),
(109, N'Xe Limousine Phương Trang', 'VT-DN-003', 'Transport', 4.6, 1, 18, 1, '2024-02-28', 'Active', N'Xe limousine cao cấp đi các tỉnh'),
(110, N'Vinbus Đà Nẵng', 'VT-DN-004', 'Transport', 4.5, 1, 10, 1, '2024-03-05', 'Active', N'Xe buýt điện thân thiện môi trường');

PRINT '✓ Đã thêm 10 nhà cung cấp mẫu';
GO

-- Kiểm tra dữ liệu
SELECT 
    ProviderId,
    BusinessName,
    ProviderType,
    Rating,
    TotalTours,
    IsVerified,
    JoinDate
FROM Providers
ORDER BY ProviderId;
GO

-- =============================================
-- CUSTOMER MANAGEMENT MODULE - DATABASE SETUP
-- =============================================

USE AdminUser;
GO

-- =============================================
-- 1. Tạo bảng Customers
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Customers')
BEGIN
    CREATE TABLE Customers (
        CustomerId INT PRIMARY KEY IDENTITY(1,1),
        FullName NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) NOT NULL UNIQUE,
        Phone NVARCHAR(20),
        Address NVARCHAR(255),
        Status NVARCHAR(20) DEFAULT 'active' CHECK (Status IN ('active', 'inactive', 'banned')),
        CreatedAt DATETIME DEFAULT GETDATE(),
        UpdatedAt DATETIME DEFAULT GETDATE(),
        Notes NVARCHAR(500)
    );
    PRINT 'Table Customers created successfully';
END
GO

-- =============================================
-- 2. Tạo bảng CustomerActivities
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CustomerActivities')
BEGIN
    CREATE TABLE CustomerActivities (
        ActivityId INT PRIMARY KEY IDENTITY(1,1),
        CustomerId INT NOT NULL,
        ActionType NVARCHAR(50) NOT NULL CHECK (ActionType IN ('search', 'view_tour', 'booking', 'cancel_booking', 'update_profile', 'login')),
        ActionDescription NVARCHAR(500),
        Metadata NVARCHAR(MAX),
        CreatedAt DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId) ON DELETE CASCADE
    );
    PRINT 'Table CustomerActivities created successfully';
END
GO

-- =============================================
-- 3. Insert dữ liệu mẫu - 20 Customers
-- =============================================
IF NOT EXISTS (SELECT * FROM Customers)
BEGIN
    INSERT INTO Customers (FullName, Email, Phone, Address, Status, CreatedAt, Notes)
    VALUES 
    (N'Nguyễn Văn An', 'nguyenvanan@gmail.com', '0901234567', N'123 Lê Lợi, Đà Nẵng', 'active', '2024-01-15', N'Khách hàng VIP'),
    (N'Trần Thị Bình', 'tranthibinh@gmail.com', '0912345678', N'456 Trần Phú, Đà Nẵng', 'active', '2024-01-20', NULL),
    (N'Lê Hoàng Cường', 'lehoangcuong@gmail.com', '0923456789', N'789 Nguyễn Văn Linh, Đà Nẵng', 'active', '2024-02-05', NULL),
    (N'Phạm Thị Dung', 'phamthidung@gmail.com', '0934567890', N'321 Hùng Vương, Đà Nẵng', 'inactive', '2024-02-10', N'Tạm ngưng hoạt động'),
    (N'Hoàng Văn Em', 'hoangvanem@gmail.com', '0945678901', N'654 Điện Biên Phủ, Đà Nẵng', 'active', '2024-02-15', NULL),
    (N'Vũ Thị Phương', 'vuthiphuong@gmail.com', '0956789012', N'987 Phan Châu Trinh, Đà Nẵng', 'active', '2024-03-01', NULL),
    (N'Đặng Văn Giang', 'dangvangiang@gmail.com', '0967890123', N'147 Lý Thường Kiệt, Đà Nẵng', 'banned', '2024-03-05', N'Vi phạm chính sách'),
    (N'Bùi Thị Hoa', 'buithihoa@gmail.com', '0978901234', N'258 Hai Bà Trưng, Đà Nẵng', 'active', '2024-03-10', NULL),
    (N'Ngô Văn Inh', 'ngovaninh@gmail.com', '0989012345', N'369 Quang Trung, Đà Nẵng', 'active', '2024-03-15', NULL),
    (N'Trương Thị Kim', 'truongthikim@gmail.com', '0990123456', N'741 Lê Duẩn, Đà Nẵng', 'active', '2024-04-01', N'Khách hàng thân thiết'),
    (N'Phan Văn Long', 'phanvanlong@gmail.com', '0901234568', N'852 Ngô Quyền, Đà Nẵng', 'active', '2024-04-05', NULL),
    (N'Lý Thị Mai', 'lythimai@gmail.com', '0912345679', N'963 Trường Chinh, Đà Nẵng', 'inactive', '2024-04-10', NULL),
    (N'Võ Văn Nam', 'vovannam@gmail.com', '0923456780', N'159 Hoàng Diệu, Đà Nẵng', 'active', '2024-04-15', NULL),
    (N'Đinh Thị Oanh', 'dinhthioanh@gmail.com', '0934567891', N'357 Ông Ích Khiêm, Đà Nẵng', 'active', '2024-05-01', NULL),
    (N'Dương Văn Phúc', 'duongvanphuc@gmail.com', '0945678902', N'468 Núi Thành, Đà Nẵng', 'active', '2024-05-05', NULL),
    (N'Mai Thị Quỳnh', 'maithiquynh@gmail.com', '0956789013', N'579 Tôn Đức Thắng, Đà Nẵng', 'banned', '2024-05-10', N'Spam booking'),
    (N'Hồ Văn Rồng', 'hovanrong@gmail.com', '0967890124', N'680 Phan Đăng Lưu, Đà Nẵng', 'active', '2024-05-15', NULL),
    (N'Lâm Thị Sương', 'lamthisuong@gmail.com', '0978901235', N'791 Nguyễn Hữu Thọ, Đà Nẵng', 'active', '2024-06-01', NULL),
    (N'Tô Văn Tài', 'tovantai@gmail.com', '0989012346', N'802 Lê Văn Hiến, Đà Nẵng', 'active', '2024-06-05', NULL),
    (N'Cao Thị Uyên', 'caothiuyen@gmail.com', '0990123457', N'913 Võ Nguyên Giáp, Đà Nẵng', 'active', '2024-06-10', N'Khách hàng mới');
    
    PRINT 'Inserted 20 sample customers';
END
GO

-- =============================================
-- 4. Insert Activities mẫu
-- =============================================
IF NOT EXISTS (SELECT * FROM CustomerActivities)
BEGIN
    INSERT INTO CustomerActivities (CustomerId, ActionType, ActionDescription, Metadata, CreatedAt)
    VALUES 
    (1, 'login', N'Đăng nhập vào hệ thống', NULL, '2024-06-15 08:30:00'),
    (1, 'search', N'Tìm kiếm tour Bà Nà Hills', '{"keyword": "Bà Nà Hills"}', '2024-06-15 08:35:00'),
    (1, 'view_tour', N'Xem chi tiết tour Bà Nà Hills', '{"tourId": 1}', '2024-06-15 08:40:00'),
    (1, 'booking', N'Đặt tour Bà Nà Hills', '{"tourId": 1, "bookingCode": "BK001"}', '2024-06-15 09:00:00'),
    (2, 'login', N'Đăng nhập vào hệ thống', NULL, '2024-06-16 10:00:00'),
    (2, 'search', N'Tìm kiếm tour Hội An', '{"keyword": "Hội An"}', '2024-06-16 10:05:00'),
    (3, 'login', N'Đăng nhập vào hệ thống', NULL, '2024-06-17 14:00:00'),
    (3, 'booking', N'Đặt tour Cù Lao Chàm', '{"tourId": 3, "bookingCode": "BK002"}', '2024-06-17 14:30:00'),
    (3, 'cancel_booking', N'Hủy booking BK002', '{"bookingCode": "BK002"}', '2024-06-18 09:00:00');
    
    PRINT 'Inserted sample activities';
END
GO

PRINT 'Database setup completed successfully!';
GO

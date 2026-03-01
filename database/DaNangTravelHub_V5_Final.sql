-- =============================================
-- SYSTEM: DA NANG TRAVEL HUB
-- VERSION: 5.0 (Final - Full Modules)
-- DIALECT: SQL Server
-- DESCRIPTION: Database hoan chinh cho toan bo 8 modules
--              Bao gom tat ca bang moi + cot bo sung
-- DATE: 2026-03-01
-- =============================================

USE master;
GO

-- Xoa database cu neu ton tai
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'DaNangTravelHub')
BEGIN
    ALTER DATABASE DaNangTravelHub SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DaNangTravelHub;
END
GO

CREATE DATABASE DaNangTravelHub;
GO

USE DaNangTravelHub;
GO

-- =============================================
-- MODULE AUTH: Roles + Users (CHUNG)
-- =============================================

CREATE TABLE Roles (
    RoleId      INT IDENTITY(1,1) PRIMARY KEY,
    RoleName    NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Users (
    UserId       INT IDENTITY(1,1) PRIMARY KEY,
    Email        NVARCHAR(100) NOT NULL UNIQUE,
    Username     NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    RoleId       INT NOT NULL,
    FullName     NVARCHAR(100),
    PhoneNumber  NVARCHAR(20),
    Address      NVARCHAR(255),
    DateOfBirth  DATE,
    AvatarUrl    NVARCHAR(500),
    IsActive     BIT DEFAULT 1,
    CreatedAt    DATETIME DEFAULT GETDATE(),
    UpdatedAt    DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleId) REFERENCES Roles(RoleId)
);

-- =============================================
-- MODULE 1: PROVIDER - Nha cung cap (SANG)
-- Quan ly danh sach NCC + So sanh gia
-- =============================================

CREATE TABLE Providers (
    ProviderId      INT PRIMARY KEY,  -- Linked 1:1 voi Users (RoleId = PROVIDER)
    BusinessName    NVARCHAR(200) NOT NULL,
    BusinessLicense NVARCHAR(100),
    ProviderType    NVARCHAR(50),     -- Hotel, Transport, TourOperator
    Rating          DECIMAL(3,2) DEFAULT 0,
    IsVerified      BIT DEFAULT 0,
    TotalTours      INT DEFAULT 0,
    IsActive        BIT DEFAULT 1,
    CONSTRAINT FK_Providers_Users FOREIGN KEY (ProviderId) REFERENCES Users(UserId)
);

-- [MOI] Lich su gia cua NCC - phuc vu so sanh gia giua cac NCC
CREATE TABLE ProviderPriceHistory (
    PriceId      INT IDENTITY(1,1) PRIMARY KEY,
    ProviderId   INT NOT NULL,
    ServiceType  NVARCHAR(50) NOT NULL,   -- Hotel, Flight, Tour, Transport
    ServiceName  NVARCHAR(200) NOT NULL,  -- Ten dich vu cu the
    OldPrice     DECIMAL(18,2),
    NewPrice     DECIMAL(18,2) NOT NULL,
    ChangeDate   DATETIME DEFAULT GETDATE(),
    Note         NVARCHAR(500),
    CONSTRAINT FK_PriceHist_Providers FOREIGN KEY (ProviderId) REFERENCES Providers(ProviderId)
);

-- =============================================
-- MODULE 2: CUSTOMER - Khach hang (MINH)
-- Danh sach KH + Lich su tuong tac
-- =============================================

CREATE TABLE Customers (
    CustomerId  INT PRIMARY KEY,  -- Linked 1:1 voi Users (RoleId = CUSTOMER)
    Address     NVARCHAR(255),
    DateOfBirth DATE,
    Status      NVARCHAR(20) DEFAULT 'active',  -- active, inactive, banned
    CONSTRAINT FK_Customers_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
);

-- Hoat dong cua khach hang (hanh vi chi tiet)
CREATE TABLE CustomerActivities (
    Id          INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId  INT NOT NULL,
    ActionType  NVARCHAR(50) NOT NULL,  -- SEARCH, BOOKING, CANCEL, LOGIN, VIEW_TOUR, ADD_CART
    Description NVARCHAR(500),
    Metadata    NVARCHAR(MAX),          -- JSON data (tour_id, search_keyword, etc.)
    CreatedAt   DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_CustAct_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
);

-- Lich su tuong tac (timeline don gian)
CREATE TABLE InteractionHistory (
    Id          INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId  INT NOT NULL,
    Action      NVARCHAR(100) NOT NULL, -- Noi dung tuong tac
    CreatedAt   DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_IntHist_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
);

-- =============================================
-- MODULE 3: CATALOG - Danh muc + Tour (MINH)
-- Thong tin tour + Lich khoi hanh + Gia theo mua
-- =============================================

CREATE TABLE Categories (
    CategoryId   INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    IconUrl      NVARCHAR(500),
    Description  NVARCHAR(500)
);

CREATE TABLE Tours (
    TourId          INT IDENTITY(1,1) PRIMARY KEY,
    ProviderId      INT NOT NULL,
    CategoryId      INT NOT NULL,
    TourName        NVARCHAR(255) NOT NULL,
    ShortDesc       NVARCHAR(500),
    Description     NVARCHAR(MAX),
    Price           DECIMAL(18,2) NOT NULL,       -- Gia goc
    SeasonalPrice   DECIMAL(18,2),                -- [MOI] Gia theo mua (tinh tu TourPriceSeasons)
    MaxPeople       INT DEFAULT 20,
    CurrentBookings INT DEFAULT 0,                -- [MOI] So booking hien tai
    Duration        NVARCHAR(50),                 -- VD: "3 ngay 2 dem"
    Transport       NVARCHAR(100),
    StartLocation   NVARCHAR(200),
    Destination     NVARCHAR(200),
    ImageUrl        NVARCHAR(500),
    Itinerary       NVARCHAR(MAX),
    IsActive        BIT DEFAULT 1,
    PopularityScore FLOAT DEFAULT 0,              -- [MOI] Diem pho bien cho AI goi y
    CreatedAt       DATETIME DEFAULT GETDATE(),
    UpdatedAt       DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Tours_Providers  FOREIGN KEY (ProviderId) REFERENCES Providers(ProviderId),
    CONSTRAINT FK_Tours_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);

-- Nhieu anh cho 1 tour
CREATE TABLE TourImages (
    ImageId   INT IDENTITY(1,1) PRIMARY KEY,
    TourId    INT NOT NULL,
    ImageUrl  NVARCHAR(500) NOT NULL,
    Caption   NVARCHAR(200),
    SortOrder INT DEFAULT 0,
    CONSTRAINT FK_TourImages_Tours FOREIGN KEY (TourId) REFERENCES Tours(TourId) ON DELETE CASCADE
);

-- [MOI] Lich khoi hanh cu the - tu dong dong/mo tour
CREATE TABLE TourSchedules (
    ScheduleId     INT IDENTITY(1,1) PRIMARY KEY,
    TourId         INT NOT NULL,
    DepartureDate  DATE NOT NULL,        -- Ngay khoi hanh
    ReturnDate     DATE,                 -- Ngay ket thuc
    AvailableSlots INT NOT NULL,         -- So cho con trong
    Status         NVARCHAR(20) DEFAULT 'Open',  -- Open, Closed, Full, Cancelled
    CONSTRAINT FK_Schedule_Tours FOREIGN KEY (TourId) REFERENCES Tours(TourId) ON DELETE CASCADE
);

-- [MOI] Dieu chinh gia theo mua - cao diem / thap diem
CREATE TABLE TourPriceSeasons (
    SeasonId        INT IDENTITY(1,1) PRIMARY KEY,
    TourId          INT NOT NULL,
    SeasonName      NVARCHAR(100) NOT NULL,  -- VD: "Tet Nguyen Dan", "He 2026", "Thap diem"
    StartDate       DATE NOT NULL,
    EndDate         DATE NOT NULL,
    PriceMultiplier DECIMAL(4,2) NOT NULL,   -- VD: 1.5 (tang 50%), 0.8 (giam 20%)
    IsActive        BIT DEFAULT 1,
    CONSTRAINT FK_PriceSeason_Tours FOREIGN KEY (TourId) REFERENCES Tours(TourId) ON DELETE CASCADE
);

-- =============================================
-- MODULE 4: CART - Gio hang (DAI)
-- Luu tru phien + Theo doi abandoned bookings
-- =============================================

-- [MOI] Gio hang persistent (luu DB thay vi chi session)
CREATE TABLE Carts (
    CartId      INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId  INT NOT NULL,
    SessionId   NVARCHAR(100),             -- Session ID de link voi browser session
    Status      NVARCHAR(20) DEFAULT 'Active', -- Active, Converted, Abandoned
    CreatedAt   DATETIME DEFAULT GETDATE(),
    UpdatedAt   DATETIME DEFAULT GETDATE(),
    AbandonedAt DATETIME NULL,             -- [MOI] Thoi diem bo quen gio hang (AI reminder)
    CONSTRAINT FK_Carts_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
);

-- [MOI] Chi tiet items trong gio hang
CREATE TABLE CartItems (
    CartItemId INT IDENTITY(1,1) PRIMARY KEY,
    CartId     INT NOT NULL,
    TourId     INT NOT NULL,
    TravelDate DATE NOT NULL,              -- Ngay du lich
    Quantity   INT DEFAULT 1,
    UnitPrice  DECIMAL(18,2) NOT NULL,     -- Gia tai thoi diem them vao gio
    SubTotal   AS (Quantity * UnitPrice),   -- Computed column
    AddedAt    DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_CartItems_Carts FOREIGN KEY (CartId) REFERENCES Carts(CartId) ON DELETE CASCADE,
    CONSTRAINT FK_CartItems_Tours FOREIGN KEY (TourId) REFERENCES Tours(TourId)
);

-- =============================================
-- MODULE 5: ORDER & BOOKING (HIEU)
-- Quy trinh xu ly don + Huy tour / Hoan tien
-- =============================================

CREATE TABLE Orders (
    OrderId       INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId    INT NOT NULL,
    TotalAmount   DECIMAL(18,2) NOT NULL,
    OrderStatus   NVARCHAR(50) DEFAULT 'Pending',   -- Pending -> Confirmed -> Completed / Cancelled
    PaymentStatus NVARCHAR(20) DEFAULT 'Unpaid',     -- Unpaid, Paid, Refunded
    CancelReason  NVARCHAR(500),
    RefundAmount  DECIMAL(18,2) DEFAULT 0,           -- [MOI] So tien hoan tra khi huy
    OrderDate     DATETIME DEFAULT GETDATE(),
    UpdatedAt     DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Orders_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
);

CREATE TABLE Bookings (
    BookingId     INT IDENTITY(1,1) PRIMARY KEY,
    OrderId       INT NOT NULL,
    TourId        INT NOT NULL,
    BookingDate   DATETIME NOT NULL,          -- Ngay du lich
    Quantity      INT DEFAULT 1,
    SubTotal      DECIMAL(18,2) NOT NULL,
    BookingStatus NVARCHAR(50) DEFAULT 'Pending',  -- Pending, Confirmed, Refunded, Finished
    CONSTRAINT FK_Bookings_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_Bookings_Tours  FOREIGN KEY (TourId)  REFERENCES Tours(TourId)
);

-- =============================================
-- MODULE 6: PAYMENT & SUBSCRIPTION (HIEU)
-- Phan tang dich vu + Cong thanh toan SePay
-- =============================================

CREATE TABLE Payments (
    PaymentId      INT IDENTITY(1,1) PRIMARY KEY,
    OrderId        INT NOT NULL,
    PaymentMethod  NVARCHAR(50),        -- VNPAY, BankTransfer, SePay, Cash
    TransactionId  NVARCHAR(100),
    Amount         DECIMAL(18,2),
    PaymentStatus  NVARCHAR(50),        -- Success, Failed, Pending
    PaidAt         DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);

-- Cac goi dich vu (Free, Pro Thang/Quy/Nam)
CREATE TABLE SubscriptionPlans (
    PlanId       INT IDENTITY(1,1) PRIMARY KEY,
    PlanName     NVARCHAR(100) NOT NULL,
    PlanCode     NVARCHAR(50) NOT NULL UNIQUE,  -- FREE, PRO_MONTHLY, PRO_QUARTERLY, PRO_YEARLY
    Price        DECIMAL(18,2) NOT NULL,
    DurationDays INT DEFAULT 30,
    Description  NVARCHAR(500),
    Features     NVARCHAR(MAX),          -- JSON: ["bao_cao_co_ban", "AI_forecasting", "chatbot"]
    IsActive     BIT DEFAULT 1
);

-- Lich su dang ky goi cua NCC
CREATE TABLE ProviderSubscriptions (
    SubId         INT IDENTITY(1,1) PRIMARY KEY,
    ProviderId    INT NOT NULL,
    PlanId        INT NOT NULL,
    StartDate     DATETIME,
    EndDate       DATETIME,
    Status        NVARCHAR(20) DEFAULT 'Active',  -- Active, Expired, Cancelled
    PaymentStatus NVARCHAR(20) DEFAULT 'Unpaid',
    Amount        DECIMAL(18,2),
    IsActive      BIT DEFAULT 1,
    CONSTRAINT FK_Subs_Providers FOREIGN KEY (ProviderId) REFERENCES Providers(ProviderId),
    CONSTRAINT FK_Subs_Plans     FOREIGN KEY (PlanId)     REFERENCES SubscriptionPlans(PlanId)
);

-- Giao dich thanh toan tong quat (Subscription + Order)
CREATE TABLE PaymentTransactions (
    TransactionId   INT IDENTITY(1,1) PRIMARY KEY,
    UserId          INT NOT NULL,
    PlanId          INT,                           -- NULL neu la thanh toan Order
    OrderId         INT,                           -- NULL neu la thanh toan Subscription
    Amount          DECIMAL(18,2) NOT NULL,
    TransactionCode NVARCHAR(100) UNIQUE NOT NULL,
    Status          NVARCHAR(20) DEFAULT 'Pending',  -- Pending, Paid, Failed
    PaymentGateway  NVARCHAR(50),                    -- SePay, VNPAY, BankTransfer
    SePayReference  NVARCHAR(100),
    CreatedDate     DATETIME DEFAULT GETDATE(),
    PaidDate        DATETIME,
    CONSTRAINT FK_PayTrans_Users  FOREIGN KEY (UserId)  REFERENCES Users(UserId),
    CONSTRAINT FK_PayTrans_Plans  FOREIGN KEY (PlanId)  REFERENCES SubscriptionPlans(PlanId),
    CONSTRAINT FK_PayTrans_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);

-- Du lieu webhook tu SePay API
CREATE TABLE SepayTransactions (
    Id              INT PRIMARY KEY,          -- Tu SePay API
    Gateway         NVARCHAR(50),
    TransactionDate NVARCHAR(50),
    AccountNumber   NVARCHAR(50),
    Code            NVARCHAR(100),
    Content         NVARCHAR(500),
    TransferType    NVARCHAR(20),
    TransferAmount  DECIMAL(18,2),
    Accumulated     DECIMAL(18,2),
    SubAccount      NVARCHAR(50),
    ReferenceCode   NVARCHAR(100),
    Description     NVARCHAR(500),
    CreatedAt       DATETIME DEFAULT GETDATE()
);

-- =============================================
-- MODULE 7: MONTHLY REVENUE & AI FORECASTING (THUAN)
-- Bao cao doanh thu + Du lieu cho AI du bao
-- =============================================

CREATE TABLE MonthlyRevenue (
    RevenueId       INT IDENTITY(1,1) PRIMARY KEY,
    ReportMonth     INT,
    ReportYear      INT,
    TotalBookings   INT,
    GrossVolume     DECIMAL(18,2),       -- Tong doanh thu gop
    PlatformFee     DECIMAL(18,2),       -- Hoa hong 10-15%
    NetRevenue      DECIMAL(18,2),       -- [MOI] Doanh thu rong
    CancelledOrders INT DEFAULT 0,       -- [MOI] So don huy
    CancelRate      DECIMAL(5,2) DEFAULT 0,  -- [MOI] Ty le huy (%) - du lieu cho AI
    CreatedAt       DATETIME DEFAULT GETDATE()
);

-- =============================================
-- MODULE 8: AI CHATBOT & LOGS (THUAN)
-- Luu log AI + Kiem tra quyen truy cap
-- =============================================

CREATE TABLE AILogs (
    LogId           INT IDENTITY(1,1) PRIMARY KEY,
    UserId          INT,
    ActionType      NVARCHAR(50),        -- ChatbotRequest, ForecastEngine, Recommendation
    InputData       NVARCHAR(MAX),
    OutputData      NVARCHAR(MAX),
    ExecutionTimeMs INT,
    CreatedAt       DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_AILogs_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- =============================================
-- INDEXES - Toi uu hieu nang truy van
-- =============================================

-- Users
CREATE INDEX IDX_Users_Email      ON Users(Email);
CREATE INDEX IDX_Users_Username   ON Users(Username);
CREATE INDEX IDX_Users_RoleId     ON Users(RoleId);

-- Tours
CREATE INDEX IDX_Tour_Provider    ON Tours(ProviderId);
CREATE INDEX IDX_Tour_Category    ON Tours(CategoryId);
CREATE INDEX IDX_Tour_Active      ON Tours(IsActive);
CREATE INDEX IDX_Tour_Popularity  ON Tours(PopularityScore);

-- Bookings & Orders
CREATE INDEX IDX_Booking_Order    ON Bookings(OrderId);
CREATE INDEX IDX_Booking_Tour     ON Bookings(TourId);
CREATE INDEX IDX_Order_Customer   ON Orders(CustomerId);
CREATE INDEX IDX_Order_Status     ON Orders(OrderStatus);

-- Payments
CREATE INDEX IDX_Payment_Order    ON Payments(OrderId);
CREATE INDEX IDX_PayTrans_User    ON PaymentTransactions(UserId);
CREATE INDEX IDX_PayTrans_Status  ON PaymentTransactions(Status);

-- Customer Activity
CREATE INDEX IDX_CustAct_Customer ON CustomerActivities(CustomerId);
CREATE INDEX IDX_IntHist_Customer ON InteractionHistory(CustomerId);

-- Cart
CREATE INDEX IDX_Cart_Customer    ON Carts(CustomerId);
CREATE INDEX IDX_Cart_Status      ON Carts(Status);
CREATE INDEX IDX_CartItem_Tour    ON CartItems(TourId);

-- Tour Schedules & Seasons
CREATE INDEX IDX_Schedule_Tour    ON TourSchedules(TourId);
CREATE INDEX IDX_Schedule_Date    ON TourSchedules(DepartureDate);
CREATE INDEX IDX_PriceSeason_Tour ON TourPriceSeasons(TourId);

-- Provider Price History
CREATE INDEX IDX_PriceHist_Provider ON ProviderPriceHistory(ProviderId);
CREATE INDEX IDX_PriceHist_ServiceType ON ProviderPriceHistory(ServiceType);
CREATE INDEX IDX_PriceHist_ChangeDate ON ProviderPriceHistory(ChangeDate DESC);

-- Revenue
CREATE INDEX IDX_Revenue_Period ON MonthlyRevenue(ReportYear, ReportMonth);

-- =============================================
-- INITIAL DATA (Du lieu ban dau)
-- =============================================

-- 3 Roles co ban
SET IDENTITY_INSERT Roles ON;
INSERT INTO Roles (RoleId, RoleName) VALUES (1, 'ADMIN'), (2, 'PROVIDER'), (3, 'CUSTOMER');
SET IDENTITY_INSERT Roles OFF;

-- Tai khoan Admin mac dinh (Password: 123456 - SHA256)
INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName)
VALUES ('admin@dananghub.com', 'admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, 'System Admin');

-- Goi dich vu (Free + Pro Thang/Quy/Nam)
INSERT INTO SubscriptionPlans (PlanName, PlanCode, Price, DurationDays, Description, Features, IsActive) VALUES
(N'Free',          'FREE',           0,       30,  N'Goi mien phi co ban',
 N'["Xem bao cao co ban", "So luong don dat tour", "Doanh thu tong"]', 1),
(N'Pro Thang',     'PRO_MONTHLY',    299000,  30,  N'Goi Pro theo thang',
 N'["Phan tich nang cao", "Du bao doanh thu AI", "Chatbot AI", "Bao cao chi tiet"]', 1),
(N'Pro Quy',       'PRO_QUARTERLY',  799000,  90,  N'Goi Pro theo quy - Tiet kiem 11%',
 N'["Phan tich nang cao", "Du bao doanh thu AI", "Chatbot AI", "Bao cao chi tiet", "Uu tien ho tro"]', 1),
(N'Pro Nam',       'PRO_YEARLY',     2999000, 365, N'Goi Pro theo nam - Tiet kiem 16%',
 N'["Phan tich nang cao", "Du bao doanh thu AI", "Chatbot AI", "Bao cao chi tiet", "Uu tien ho tro", "API access"]', 1);

-- Danh muc tour mac dinh
INSERT INTO Categories (CategoryName, Description) VALUES
(N'Tour Tham Quan',  N'Tour tham quan cac diem du lich noi tieng Da Nang'),
(N'Tour Mao Hiem',   N'Tour trai nghiem mao hiem va the thao'),
(N'Tour Van Hoa',    N'Tour tim hieu van hoa va lich su mien Trung'),
(N'Tour Am Thuc',    N'Tour kham pha am thuc dia phuong Da Nang'),
(N'Tour Sinh Thai',  N'Tour du lich sinh thai va thien nhien'),
(N'Tour Bien Dao',   N'Tour du lich bien va dao Cu Lao Cham, Son Tra');

GO

-- =============================================
-- VIEWS huu ich cho bao cao
-- =============================================

-- View: Thong tin tour day du (kem ten NCC va Category)
CREATE VIEW vw_TourFull AS
SELECT
    t.TourId, t.TourName, t.ShortDesc, t.Description,
    t.Price, t.SeasonalPrice,
    COALESCE(t.SeasonalPrice, t.Price) AS EffectivePrice,
    t.MaxPeople, t.CurrentBookings,
    (t.MaxPeople - t.CurrentBookings) AS AvailableSlots,
    t.Duration, t.Transport, t.StartLocation, t.Destination,
    t.ImageUrl, t.IsActive, t.PopularityScore,
    t.CreatedAt, t.UpdatedAt,
    p.ProviderId, p.BusinessName AS ProviderName, p.ProviderType,
    c.CategoryId, c.CategoryName
FROM Tours t
JOIN Providers p ON t.ProviderId = p.ProviderId
JOIN Categories c ON t.CategoryId = c.CategoryId;
GO

-- View: Don dat tour day du (kem ten khach + tong bookings)
CREATE VIEW vw_OrderFull AS
SELECT
    o.OrderId, o.TotalAmount, o.OrderStatus, o.PaymentStatus,
    o.CancelReason, o.RefundAmount, o.OrderDate, o.UpdatedAt,
    u.UserId AS CustomerId, u.FullName AS CustomerName,
    u.Email AS CustomerEmail, u.PhoneNumber AS CustomerPhone,
    (SELECT COUNT(*) FROM Bookings b WHERE b.OrderId = o.OrderId) AS TotalBookings
FROM Orders o
JOIN Users u ON o.CustomerId = u.UserId;
GO

-- View: Gio hang bi bo quen (cho AI nhac nho)
CREATE VIEW vw_AbandonedCarts AS
SELECT
    c.CartId, c.CustomerId, c.AbandonedAt, c.CreatedAt,
    u.FullName, u.Email,
    COUNT(ci.CartItemId) AS ItemCount,
    SUM(ci.Quantity * ci.UnitPrice) AS TotalValue
FROM Carts c
JOIN Users u ON c.CustomerId = u.UserId
JOIN CartItems ci ON c.CartId = ci.CartId
WHERE c.Status = 'Abandoned'
GROUP BY c.CartId, c.CustomerId, c.AbandonedAt, c.CreatedAt,
         u.FullName, u.Email;
GO

PRINT '==============================================';
PRINT 'DATABASE DaNangTravelHub V5.0 DA TAO THANH CONG!';
PRINT '==============================================';
PRINT 'THONG TIN DANG NHAP:';
PRINT 'Username: admin | Password: 123456 | Role: ADMIN';
PRINT '==============================================';
PRINT 'TONG SO BANG: 20';
PRINT 'TONG SO VIEW: 3';
PRINT '==============================================';

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
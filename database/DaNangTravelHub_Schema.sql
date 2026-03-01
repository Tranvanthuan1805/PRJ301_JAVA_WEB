-- =============================================
-- SYSTEM: DA NANG TRAVEL HUB
-- VERSION: 4.0 (Maven JPA - Clean Schema)
-- DIALECT: SQL Server
-- DESCRIPTION: Database chung cho toan bo project
--              Chi co structure, KHONG co data mau
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

-- Tao database moi
CREATE DATABASE DaNangTravelHub;
GO

USE DaNangTravelHub;
GO

-- =============================================
-- MODULE 1: AUTH (Roles + Users)
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
-- MODULE 2: PROVIDER (Nha cung cap tour)
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

-- =============================================
-- MODULE 3: CATALOG (Danh muc + Tour)
-- =============================================

CREATE TABLE Categories (
    CategoryId   INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    IconUrl      NVARCHAR(500),
    Description  NVARCHAR(500)
);

CREATE TABLE Tours (
    TourId        INT IDENTITY(1,1) PRIMARY KEY,
    ProviderId    INT NOT NULL,
    CategoryId    INT NOT NULL,
    TourName      NVARCHAR(255) NOT NULL,
    ShortDesc     NVARCHAR(500),
    Description   NVARCHAR(MAX),
    Price         DECIMAL(18,2) NOT NULL,
    MaxPeople     INT DEFAULT 20,
    Duration      NVARCHAR(50),
    Transport     NVARCHAR(100),
    StartLocation NVARCHAR(200),
    Destination   NVARCHAR(200),
    ImageUrl      NVARCHAR(500),
    Itinerary     NVARCHAR(MAX),
    IsActive      BIT DEFAULT 1,
    CreatedAt     DATETIME DEFAULT GETDATE(),
    UpdatedAt     DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Tours_Providers  FOREIGN KEY (ProviderId) REFERENCES Providers(ProviderId),
    CONSTRAINT FK_Tours_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);

-- Anh cua tour (1 tour co nhieu anh)
CREATE TABLE TourImages (
    ImageId   INT IDENTITY(1,1) PRIMARY KEY,
    TourId    INT NOT NULL,
    ImageUrl  NVARCHAR(500) NOT NULL,
    Caption   NVARCHAR(200),
    SortOrder INT DEFAULT 0,
    CONSTRAINT FK_TourImages_Tours FOREIGN KEY (TourId) REFERENCES Tours(TourId) ON DELETE CASCADE
);

-- =============================================
-- MODULE 4: CUSTOMER (Mo rong tu Users)
-- =============================================

CREATE TABLE Customers (
    CustomerId  INT PRIMARY KEY,  -- Linked 1:1 voi Users (RoleId = CUSTOMER)
    Address     NVARCHAR(255),
    DateOfBirth DATE,
    Status      NVARCHAR(20) DEFAULT 'active',  -- active, inactive, banned
    CONSTRAINT FK_Customers_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
);

-- =============================================
-- MODULE 5: ORDER & BOOKING
-- =============================================

CREATE TABLE Orders (
    OrderId      INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId   INT NOT NULL,
    TotalAmount  DECIMAL(18,2) NOT NULL,
    OrderStatus  NVARCHAR(50) DEFAULT 'Pending',  -- Pending, Confirmed, Completed, Cancelled
    PaymentStatus NVARCHAR(20) DEFAULT 'Unpaid',   -- Unpaid, Paid, Refunded
    CancelReason NVARCHAR(500),
    OrderDate    DATETIME DEFAULT GETDATE(),
    UpdatedAt    DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Orders_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
);

CREATE TABLE Bookings (
    BookingId     INT IDENTITY(1,1) PRIMARY KEY,
    OrderId       INT NOT NULL,
    TourId        INT NOT NULL,
    BookingDate   DATETIME NOT NULL,  -- Ngay du lich
    Quantity      INT DEFAULT 1,
    SubTotal      DECIMAL(18,2) NOT NULL,
    BookingStatus NVARCHAR(50) DEFAULT 'Pending',  -- Pending, Confirmed, Refunded, Finished
    CONSTRAINT FK_Bookings_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_Bookings_Tours  FOREIGN KEY (TourId)  REFERENCES Tours(TourId)
);

-- =============================================
-- MODULE 6: PAYMENT & REVENUE
-- =============================================

CREATE TABLE Payments (
    PaymentId      INT IDENTITY(1,1) PRIMARY KEY,
    OrderId        INT NOT NULL,
    PaymentMethod  NVARCHAR(50),   -- VNPAY, BankTransfer, SePay, Cash
    TransactionId  NVARCHAR(100),
    Amount         DECIMAL(18,2),
    PaymentStatus  NVARCHAR(50),   -- Success, Failed, Pending
    PaidAt         DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);

CREATE TABLE MonthlyRevenue (
    RevenueId     INT IDENTITY(1,1) PRIMARY KEY,
    ReportMonth   INT,
    ReportYear    INT,
    TotalBookings INT,
    GrossVolume   DECIMAL(18,2),
    PlatformFee   DECIMAL(18,2),   -- 10-15% hoa hong
    CreatedAt     DATETIME DEFAULT GETDATE()
);

-- =============================================
-- MODULE 7: SUBSCRIPTION (Goi Provider)
-- =============================================

CREATE TABLE SubscriptionPlans (
    PlanId       INT IDENTITY(1,1) PRIMARY KEY,
    PlanName     NVARCHAR(100) NOT NULL,
    PlanCode     NVARCHAR(50) NOT NULL UNIQUE,  -- BASIC, PREMIUM, GOLD
    Price        DECIMAL(18,2) NOT NULL,
    DurationDays INT DEFAULT 30,
    Description  NVARCHAR(500),
    Features     NVARCHAR(MAX),
    IsActive     BIT DEFAULT 1
);

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

-- =============================================
-- MODULE 8: PAYMENT TRANSACTIONS (SePay)
-- =============================================

CREATE TABLE PaymentTransactions (
    TransactionId   INT IDENTITY(1,1) PRIMARY KEY,
    UserId          INT NOT NULL,
    PlanId          INT,
    OrderId         INT,
    Amount          DECIMAL(18,2) NOT NULL,
    TransactionCode NVARCHAR(100) UNIQUE NOT NULL,
    Status          NVARCHAR(20) DEFAULT 'Pending',  -- Pending, Paid, Failed
    PaymentGateway  NVARCHAR(50),    -- SePay, VNPAY, BankTransfer
    SePayReference  NVARCHAR(100),
    CreatedDate     DATETIME DEFAULT GETDATE(),
    PaidDate        DATETIME,
    CONSTRAINT FK_PayTrans_Users FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT FK_PayTrans_Plans FOREIGN KEY (PlanId) REFERENCES SubscriptionPlans(PlanId),
    CONSTRAINT FK_PayTrans_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);

CREATE TABLE SepayTransactions (
    Id              INT PRIMARY KEY,  -- Tu SePay API
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
-- MODULE 9: CUSTOMER ACTIVITY & AI LOGS
-- =============================================

CREATE TABLE CustomerActivities (
    Id          INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId  INT NOT NULL,
    ActionType  NVARCHAR(50) NOT NULL,  -- SEARCH, BOOKING, CANCEL, LOGIN, VIEW_TOUR
    Description NVARCHAR(500),
    Metadata    NVARCHAR(MAX),          -- JSON data
    CreatedAt   DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_CustAct_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
);

CREATE TABLE InteractionHistory (
    Id          INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId  INT NOT NULL,
    Action      NVARCHAR(100) NOT NULL,
    CreatedAt   DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_IntHist_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
);

CREATE TABLE AILogs (
    LogId          INT IDENTITY(1,1) PRIMARY KEY,
    UserId         INT,
    ActionType     NVARCHAR(50),    -- ChatbotRequest, ForecastEngine
    InputData      NVARCHAR(MAX),
    OutputData     NVARCHAR(MAX),
    ExecutionTimeMs INT,
    CreatedAt      DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_AILogs_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- =============================================
-- MODULE 11: PROVIDER PRICE MANAGEMENT
-- =============================================

CREATE TABLE ProviderPriceHistory (
    PriceId      INT IDENTITY(1,1) PRIMARY KEY,
    ProviderId   INT NOT NULL,
    ServiceType  NVARCHAR(50) NOT NULL,    -- Hotel, Flight, Tour, Transport
    ServiceName  NVARCHAR(200) NOT NULL,
    OldPrice     DECIMAL(18,2) NULL,
    NewPrice     DECIMAL(18,2) NOT NULL,
    ChangeDate   DATETIME NOT NULL DEFAULT GETDATE(),
    Note         NVARCHAR(500) NULL,
    CONSTRAINT FK_ProviderPriceHistory_Provider 
        FOREIGN KEY (ProviderId) REFERENCES Providers(ProviderId)
        ON DELETE CASCADE
);

-- =============================================
-- MODULE 10: INDEXES
-- =============================================

CREATE INDEX IDX_Users_Email      ON Users(Email);
CREATE INDEX IDX_Users_Username   ON Users(Username);
CREATE INDEX IDX_Users_RoleId     ON Users(RoleId);
CREATE INDEX IDX_Tour_Provider    ON Tours(ProviderId);
CREATE INDEX IDX_Tour_Category    ON Tours(CategoryId);
CREATE INDEX IDX_Tour_Active      ON Tours(IsActive);
CREATE INDEX IDX_Booking_Order    ON Bookings(OrderId);
CREATE INDEX IDX_Booking_Tour     ON Bookings(TourId);
CREATE INDEX IDX_Order_Customer   ON Orders(CustomerId);
CREATE INDEX IDX_Order_Status     ON Orders(OrderStatus);
CREATE INDEX IDX_ProviderPrice_Provider   ON ProviderPriceHistory(ProviderId);
CREATE INDEX IDX_ProviderPrice_ServiceType ON ProviderPriceHistory(ServiceType);
CREATE INDEX IDX_ProviderPrice_ChangeDate  ON ProviderPriceHistory(ChangeDate DESC);
CREATE INDEX IDX_Payment_Order    ON Payments(OrderId);
CREATE INDEX IDX_CustAct_Customer ON CustomerActivities(CustomerId);
CREATE INDEX IDX_IntHist_Customer ON InteractionHistory(CustomerId);

-- =============================================
-- INITIAL DATA: Chi co Roles va Admin account
-- =============================================

-- 3 roles co ban
SET IDENTITY_INSERT Roles ON;
INSERT INTO Roles (RoleId, RoleName) VALUES (1, 'ADMIN'), (2, 'PROVIDER'), (3, 'CUSTOMER');
SET IDENTITY_INSERT Roles OFF;

-- Tai khoan Admin mac dinh (Password: 123456 - SHA256)
INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName)
VALUES ('admin@dananghub.com', 'admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, 'System Admin');

-- Default subscription plans
INSERT INTO SubscriptionPlans (PlanName, PlanCode, Price, DurationDays, Description, Features, IsActive) VALUES
(N'Basic', 'BASIC', 0, 30, N'Goi mien phi co ban', N'Dang 5 tour, Hien thi co ban', 1),
(N'Premium', 'PREMIUM', 299000, 30, N'Goi nang cao', N'Dang 20 tour, Uu tien hien thi, Bao cao', 1),
(N'Gold', 'GOLD', 599000, 30, N'Goi cao cap', N'Dang khong gioi han, Uu tien #1, Bao cao chi tiet, Ho tro 24/7', 1);

-- Default categories
INSERT INTO Categories (CategoryName, Description) VALUES
(N'Tour Tham Quan', N'Tour tham quan cac diem du lich noi tieng'),
(N'Tour Mao Hiem', N'Tour trai nghiem mao hiem va the thao'),
(N'Tour Van Hoa', N'Tour tim hieu van hoa va lich su'),
(N'Tour Am Thuc', N'Tour kham pha am thuc dia phuong'),
(N'Tour Sinh Thai', N'Tour du lich sinh thai va thien nhien'),
(N'Tour Bien Dao', N'Tour du lich bien va dao');

GO

PRINT '==============================================';
PRINT 'DATABASE DaNangTravelHub DA TAO THANH CONG!';
PRINT '==============================================';
PRINT 'THONG TIN DANG NHAP:';
PRINT 'Username: admin | Password: 123456 | Role: ADMIN';
PRINT '==============================================';

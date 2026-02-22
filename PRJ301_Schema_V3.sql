-- =============================================
-- SYSTEM: DA NANG TRAVEL HUB
-- VERSION: 3.2 (Modular Arch)
-- DIALECT: SQL Server
-- =============================================

-- 1. CLEANUP (Optional - Use with caution)
/*
DROP TABLE IF EXISTS AILogs;
DROP TABLE IF EXISTS MonthlyRevenue;
DROP TABLE IF EXISTS ProviderSubscriptions;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Tours;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Providers;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Roles;
*/

-- 2. CORE AUTH MODULE
CREATE TABLE Roles (
    RoleId INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    RoleId INT NOT NULL,
    FullName NVARCHAR(100),
    PhoneNumber NVARCHAR(20),
    AvatarUrl NVARCHAR(500),
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleId) REFERENCES Roles(RoleId)
);

-- 3. PROVIDER MODULE
CREATE TABLE Providers (
    ProviderId INT PRIMARY KEY, -- Linked 1:1 with Users for roles=PROVIDER
    BusinessName NVARCHAR(200) NOT NULL,
    BusinessLicense NVARCHAR(100),
    Rating DECIMAL(3,2) DEFAULT 0,
    IsVerified BIT DEFAULT 0,
    TotalTours INT DEFAULT 0,
    CONSTRAINT FK_Providers_Users FOREIGN KEY (ProviderId) REFERENCES Users(UserId)
);

-- 4. CATALOG MODULE
CREATE TABLE Categories (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    IconUrl NVARCHAR(500)
);

CREATE TABLE Tours (
    TourId INT IDENTITY(1,1) PRIMARY KEY,
    ProviderId INT NOT NULL,
    CategoryId INT NOT NULL,
    TourName NVARCHAR(255) NOT NULL,
    ShortDesc NVARCHAR(500),
    Description NVARCHAR(MAX),
    Price DECIMAL(18,2) NOT NULL,
    MaxPeople INT DEFAULT 20,
    Duration NVARCHAR(50), 
    Transport NVARCHAR(100),
    StartLocation NVARCHAR(200),
    ImageUrl NVARCHAR(500),
    Itinerary NVARCHAR(MAX),
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Tours_Providers FOREIGN KEY (ProviderId) REFERENCES Providers(ProviderId),
    CONSTRAINT FK_Tours_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);

-- 5. ORDER & BOOKING MODULE
-- Orders serve as the master record for a checkout transaction
CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT NOT NULL,
    TotalAmount DECIMAL(18,2) NOT NULL,
    OrderStatus NVARCHAR(50) DEFAULT 'Pending', -- Pending, Completed, Cancelled
    OrderDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Orders_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
);

-- Bookings are the individual line items (specific tours on specific dates)
CREATE TABLE Bookings (
    BookingId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    TourId INT NOT NULL,
    BookingDate DATETIME NOT NULL, -- The date the tour takes place
    Quantity INT DEFAULT 1,
    SubTotal DECIMAL(18,2) NOT NULL,
    BookingStatus NVARCHAR(50) DEFAULT 'Pending', -- Confirmed, Refunded, Finished
    CONSTRAINT FK_Bookings_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_Bookings_Tours FOREIGN KEY (TourId) REFERENCES Tours(TourId)
);

-- 6. PAYMENT & REVENUE MODULE
CREATE TABLE Payments (
    PaymentId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    PaymentMethod NVARCHAR(50), -- PayPal, Stripe, VNPAY, Bank Transfer
    TransactionId NVARCHAR(100),
    PaymentStatus NVARCHAR(50), -- Success, Failed
    PaidAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);

-- Tracking platform revenue (Commission from providers)
CREATE TABLE MonthlyRevenue (
    RevenueId INT IDENTITY(1,1) PRIMARY KEY,
    ReportMonth INT,
    ReportYear INT,
    TotalBookings INT,
    GrossVolume DECIMAL(18,2),
    PlatformFee DECIMAL(18,2), -- Usually 10-15%
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Provider Subscription (Premium placement in Da Nang Hub)
CREATE TABLE ProviderSubscriptions (
    SubId INT IDENTITY(1,1) PRIMARY KEY,
    ProviderId INT NOT NULL,
    PlanName NVARCHAR(50), -- Basic, Premium, Gold
    StartDate DATETIME,
    EndDate DATETIME,
    IsActive BIT DEFAULT 1,
    CONSTRAINT FK_Subs_Providers FOREIGN KEY (ProviderId) REFERENCES Providers(ProviderId)
);

-- 7. INTELLIGENCE MODULE (AI LOGS)
CREATE TABLE AILogs (
    LogId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT,
    ActionType NVARCHAR(50), -- ChatbotRequest, ForecastEngine
    InputData NVARCHAR(MAX),
    OutputData NVARCHAR(MAX),
    ExecutionTimeMs INT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_AILogs_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- 8. INDEXING FOR PERFORMANCE
CREATE INDEX IDX_Tour_Provider ON Tours(ProviderId);
CREATE INDEX IDX_Booking_Order ON Bookings(OrderId);
CREATE INDEX IDX_Order_Customer ON Orders(CustomerId);

-- 9. INITIAL DATA
SET IDENTITY_INSERT Roles ON;
INSERT INTO Roles (RoleId, RoleName) VALUES (1, 'ADMIN'), (2, 'PROVIDER'), (3, 'CUSTOMER');
SET IDENTITY_INSERT Roles OFF;

-- System Admin Account (Hash: 'admin' if using standard SHA256/BCrypt)
INSERT INTO Users (Email, Username, PasswordHash, RoleId, FullName) 
VALUES ('admin@dananghub.com', 'admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, 'Hub Master');

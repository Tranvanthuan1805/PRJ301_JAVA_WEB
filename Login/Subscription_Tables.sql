-- =====================================================
-- SUBSCRIPTION & PAYMENT MODULE
-- Database: AdminUser
-- =====================================================

-- 1. Ensure PROVIDER Role exists
IF NOT EXISTS (SELECT 1 FROM Roles WHERE RoleName = 'PROVIDER')
BEGIN
    INSERT INTO Roles (RoleName) VALUES ('PROVIDER');
END
GO

-- 2. Create SubscriptionPlans Table
IF OBJECT_ID('dbo.SubscriptionPlans', 'U') IS NOT NULL DROP TABLE dbo.SubscriptionPlans;
CREATE TABLE SubscriptionPlans (
    PlanId INT IDENTITY(1,1) PRIMARY KEY,
    PlanName NVARCHAR(50) NOT NULL,        
    PlanCode NVARCHAR(20) NOT NULL UNIQUE, 
    Price DECIMAL(18,2) NOT NULL,          
    DurationDays INT DEFAULT 30,
    Description NVARCHAR(500),
    Features NVARCHAR(MAX),                
    IsActive BIT DEFAULT 1
);

-- 3. Create ProviderSubscriptions Table
IF OBJECT_ID('dbo.ProviderSubscriptions', 'U') IS NOT NULL DROP TABLE dbo.ProviderSubscriptions;
CREATE TABLE ProviderSubscriptions (
    SubscriptionId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,                   
    PlanId INT NOT NULL,                   
    StartDate DATETIME DEFAULT GETDATE(),
    EndDate DATETIME NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Active',  
    PaymentStatus NVARCHAR(20) DEFAULT 'Pending', 
    Amount DECIMAL(18,2) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_Subs_Users FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT FK_Subs_Plans FOREIGN KEY (PlanId) REFERENCES SubscriptionPlans(PlanId)
);

-- 4. Create PaymentTransactions Table
IF OBJECT_ID('dbo.PaymentTransactions', 'U') IS NOT NULL DROP TABLE dbo.PaymentTransactions;
CREATE TABLE PaymentTransactions (
    TransactionId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    PlanId INT NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    TransactionCode NVARCHAR(50) NOT NULL UNIQUE, 
    Status NVARCHAR(20) DEFAULT 'Pending',        
    CreatedDate DATETIME DEFAULT GETDATE(),
    PaidDate DATETIME NULL,
    PaymentGateway NVARCHAR(50) DEFAULT 'SePay',
    SePayReference NVARCHAR(100) NULL,            
    
    CONSTRAINT FK_Trans_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- 5. Seed Subscription Plans (NEW PRICES)
INSERT INTO SubscriptionPlans (PlanName, PlanCode, Price, DurationDays, Description, Features)
VALUES 
('Explorer', 'EXPLORER', 0, 36500, 'Gói miễn phí cơ bản', 'Quản lý Tour cơ bản,Hỗ trợ tiêu chuẩn'),
('Professional', 'PRO', 5000, 30, 'Dành cho đối tác chuyên nghiệp', 'Tất cả tính năng Explorer,AI Forecast (Dự báo),Ưu tiên hỗ trợ'),
('Elite', 'ELITE', 10000, 30, 'Dành cho doanh nghiệp lớn', 'Tất cả tính năng Pro,Chatbot thông minh,API truy cập,Quản lý đa chi nhánh');

-- 6. Indexes
CREATE INDEX IX_Subs_UserId ON ProviderSubscriptions(UserId);
CREATE INDEX IX_Trans_Code ON PaymentTransactions(TransactionCode);

SELECT * FROM PaymentTransactions;
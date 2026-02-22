-- =====================================================
-- Order Management Module - Database Script
-- Run this script in SQL Server Management Studio
-- Database: AdminUser
-- =====================================================

-- Create Orders table
CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    TourId INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    NumberOfPeople INT NOT NULL,
    TotalPrice DECIMAL(18, 2) NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Pending',         -- Pending, Confirmed, Completed, Cancelled
    PaymentStatus NVARCHAR(20) DEFAULT 'Unpaid',   -- Unpaid, Paid, Refunded
    UpdatedAt DATETIME NULL,
    CancelReason NVARCHAR(500) NULL,
    
    -- Foreign Keys
    CONSTRAINT FK_Orders_Users FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT FK_Orders_Tours FOREIGN KEY (TourId) REFERENCES Tours(TourId),
    
    -- Check constraints
    CONSTRAINT CK_Orders_Status CHECK (Status IN ('Pending', 'Confirmed', 'Completed', 'Cancelled')),
    CONSTRAINT CK_Orders_PaymentStatus CHECK (PaymentStatus IN ('Unpaid', 'Paid', 'Refunded')),
    CONSTRAINT CK_Orders_NumberOfPeople CHECK (NumberOfPeople > 0),
    CONSTRAINT CK_Orders_TotalPrice CHECK (TotalPrice >= 0)
);

-- Create indexes for faster queries
CREATE INDEX IX_Orders_UserId ON Orders(UserId);
CREATE INDEX IX_Orders_TourId ON Orders(TourId);
CREATE INDEX IX_Orders_Status ON Orders(Status);
CREATE INDEX IX_Orders_OrderDate ON Orders(OrderDate DESC);

-- =====================================================
-- Sample Data for Testing
-- Run AFTER the table is created
-- Modify UserId and TourId based on your existing data
-- =====================================================

-- Step 1: Check existing Users and Tours first
SELECT UserId, Username FROM Users;
SELECT TourId, TourName, Price FROM Tours;

-- Step 2: Insert sample orders (MODIFY UserId and TourId based on Step 1 results!)
-- Example assumes: UserId 1 = admin, UserId 2 = normal user, TourId 1,2,3 exist
INSERT INTO Orders (UserId, TourId, NumberOfPeople, TotalPrice, Status, PaymentStatus, OrderDate) VALUES
(1, 1, 2, 5000000, 'Pending', 'Unpaid', DATEADD(DAY, -1, GETDATE())),
(2, 1, 4, 10000000, 'Confirmed', 'Paid', DATEADD(DAY, -3, GETDATE())),
(1, 2, 1, 3500000, 'Completed', 'Paid', DATEADD(DAY, -7, GETDATE())),
(2, 2, 3, 10500000, 'Cancelled', 'Refunded', DATEADD(DAY, -5, GETDATE())),
(2, 1, 2, 5000000, 'Pending', 'Unpaid', GETDATE());


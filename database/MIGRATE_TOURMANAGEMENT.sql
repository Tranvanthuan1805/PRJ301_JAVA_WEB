-- Migration script for TourManagement database
-- Add missing columns to Users table and create Customers table for user profiles

USE TourManagement;
GO

PRINT 'Starting migration for TourManagement database...';
GO

-- =============================================
-- STEP 1: Add columns to Users table
-- =============================================

PRINT 'Step 1: Adding columns to Users table...';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'Email')
BEGIN
    ALTER TABLE Users ADD Email NVARCHAR(100);
    PRINT '  Added column: Email';
END
ELSE PRINT '  Column Email already exists';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'FullName')
BEGIN
    ALTER TABLE Users ADD FullName NVARCHAR(100);
    PRINT '  Added column: FullName';
END
ELSE PRINT '  Column FullName already exists';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'PhoneNumber')
BEGIN
    ALTER TABLE Users ADD PhoneNumber NVARCHAR(20);
    PRINT '  Added column: PhoneNumber';
END
ELSE PRINT '  Column PhoneNumber already exists';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'Address')
BEGIN
    ALTER TABLE Users ADD Address NVARCHAR(255);
    PRINT '  Added column: Address';
END
ELSE PRINT '  Column Address already exists';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'DateOfBirth')
BEGIN
    ALTER TABLE Users ADD DateOfBirth DATE;
    PRINT '  Added column: DateOfBirth';
END
ELSE PRINT '  Column DateOfBirth already exists';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'AvatarUrl')
BEGIN
    ALTER TABLE Users ADD AvatarUrl NVARCHAR(500);
    PRINT '  Added column: AvatarUrl';
END
ELSE PRINT '  Column AvatarUrl already exists';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'UpdatedAt')
BEGIN
    ALTER TABLE Users ADD UpdatedAt DATETIME DEFAULT GETDATE();
    PRINT '  Added column: UpdatedAt';
END
ELSE PRINT '  Column UpdatedAt already exists';
GO

-- =============================================
-- STEP 2: Update existing users with default email
-- =============================================

PRINT 'Step 2: Updating existing users with default emails...';
GO

UPDATE Users 
SET Email = Username + '@eztravel.com'
WHERE Email IS NULL;
GO

PRINT '  Updated ' + CAST(@@ROWCOUNT AS VARCHAR) + ' users with default emails';
GO

-- =============================================
-- STEP 3: Add CUSTOMER role if not exists
-- =============================================

PRINT 'Step 3: Checking roles...';
GO

IF NOT EXISTS (SELECT * FROM Roles WHERE RoleName = 'CUSTOMER')
BEGIN
    INSERT INTO Roles (RoleName) VALUES ('CUSTOMER');
    PRINT '  Added CUSTOMER role';
END
ELSE PRINT '  CUSTOMER role already exists';
GO

-- =============================================
-- STEP 4: Rename or create Customers table for profile management
-- =============================================

PRINT 'Step 4: Setting up Customers table for profile management...';
GO

-- Check if old Customers table exists (from SETUP_DATABASE.sql)
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customers')
BEGIN
    -- Check if it has the old structure (id, fullName, email, etc.)
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Customers' AND COLUMN_NAME = 'id')
    BEGIN
        PRINT '  Found old Customers table structure. Renaming to Customers_OLD...';
        
        -- Rename old table
        EXEC sp_rename 'Customers', 'Customers_OLD';
        
        -- Drop foreign keys from Bookings if they exist
        IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK__Bookings__custom__5EBF139D')
            ALTER TABLE Bookings DROP CONSTRAINT FK__Bookings__custom__5EBF139D;
        
        PRINT '  Old table renamed successfully';
    END
    ELSE
    BEGIN
        PRINT '  Customers table already has correct structure';
    END
END
GO

-- Create new Customers table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customers')
BEGIN
    CREATE TABLE Customers (
        CustomerId INT PRIMARY KEY,
        Address NVARCHAR(255),
        DateOfBirth DATE,
        Status NVARCHAR(20) DEFAULT 'active',
        CONSTRAINT FK_Customers_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
    );
    PRINT '  Created new Customers table';
    
    -- Create customer records for users with USER or CUSTOMER role
    INSERT INTO Customers (CustomerId, Status)
    SELECT u.UserId, 'active'
    FROM Users u
    INNER JOIN Roles r ON u.RoleId = r.RoleId
    WHERE r.RoleName IN ('USER', 'CUSTOMER');
    
    PRINT '  Created ' + CAST(@@ROWCOUNT AS VARCHAR) + ' customer records';
END
ELSE
BEGIN
    PRINT '  Customers table already exists';
    
    -- Make sure all USER/CUSTOMER role users have customer records
    INSERT INTO Customers (CustomerId, Status)
    SELECT u.UserId, 'active'
    FROM Users u
    INNER JOIN Roles r ON u.RoleId = r.RoleId
    WHERE r.RoleName IN ('USER', 'CUSTOMER')
    AND u.UserId NOT IN (SELECT CustomerId FROM Customers);
    
    IF @@ROWCOUNT > 0
        PRINT '  Added ' + CAST(@@ROWCOUNT AS VARCHAR) + ' missing customer records';
END
GO

-- =============================================
-- STEP 5: Create CustomerActivities table
-- =============================================

PRINT 'Step 5: Creating CustomerActivities table...';
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CustomerActivities')
BEGIN
    CREATE TABLE CustomerActivities (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        CustomerId INT NOT NULL,
        ActionType NVARCHAR(50) NOT NULL,
        Description NVARCHAR(500),
        Metadata NVARCHAR(MAX),
        CreatedAt DATETIME DEFAULT GETDATE(),
        CONSTRAINT FK_CustAct_Users FOREIGN KEY (CustomerId) REFERENCES Users(UserId)
    );
    PRINT '  Created CustomerActivities table';
END
ELSE PRINT '  CustomerActivities table already exists';
GO

-- =============================================
-- STEP 6: Add unique constraint to Email
-- =============================================

PRINT 'Step 6: Adding unique constraint to Email...';
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Users') AND name = 'UQ_Users_Email')
BEGIN
    -- Check for duplicates first
    IF NOT EXISTS (
        SELECT Email 
        FROM Users 
        WHERE Email IS NOT NULL 
        GROUP BY Email 
        HAVING COUNT(*) > 1
    )
    BEGIN
        ALTER TABLE Users ADD CONSTRAINT UQ_Users_Email UNIQUE (Email);
        PRINT '  Added unique constraint on Email';
    END
    ELSE
    BEGIN
        PRINT '  WARNING: Cannot add unique constraint - duplicate emails exist!';
        PRINT '  Please fix duplicate emails manually';
    END
END
ELSE PRINT '  Unique constraint on Email already exists';
GO

-- =============================================
-- FINAL: Show results
-- =============================================

PRINT '';
PRINT '==============================================';
PRINT 'MIGRATION COMPLETED SUCCESSFULLY!';
PRINT '==============================================';
PRINT '';
PRINT 'Users table structure:';
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Users'
ORDER BY ORDINAL_POSITION;
GO

PRINT '';
PRINT 'Available tables:';
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO

PRINT '';
PRINT '==============================================';
PRINT 'NEXT STEPS:';
PRINT '1. Restart Tomcat server';
PRINT '2. Login with: admin / 123456';
PRINT '3. Update your profile to test';
PRINT '==============================================';
GO

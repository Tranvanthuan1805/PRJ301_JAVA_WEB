-- Sync data between Users and Customers tables
-- Chạy file này khi cần đồng bộ thủ công
USE TourManagement;
GO

PRINT '=== SYNCING USERS <-> CUSTOMERS ===';
PRINT '';

-- Step 1: Tạo Customer records nếu thiếu
PRINT 'Step 1: Creating missing Customer records...';
INSERT INTO Customers (CustomerId, Address, DateOfBirth, Status)
SELECT 
    u.UserId,
    u.Address,
    u.DateOfBirth,
    'active'
FROM Users u
LEFT JOIN Customers c ON u.UserId = c.CustomerId
WHERE c.CustomerId IS NULL
AND u.RoleId IN (SELECT RoleId FROM Roles WHERE RoleName IN ('USER', 'CUSTOMER'));

IF @@ROWCOUNT > 0
    PRINT '  Created ' + CAST(@@ROWCOUNT AS VARCHAR) + ' Customer record(s)';
ELSE
    PRINT '  All Customer records exist';
GO

PRINT '';

-- Step 2: Sync Users → Customers
PRINT 'Step 2: Syncing Users → Customers...';
UPDATE c
SET 
    c.Address = u.Address,
    c.DateOfBirth = u.DateOfBirth
FROM Customers c
INNER JOIN Users u ON c.CustomerId = u.UserId;

PRINT '  Synced ' + CAST(@@ROWCOUNT AS VARCHAR) + ' record(s)';
GO

PRINT '';

-- Step 3: Verify
PRINT 'Step 3: Verification...';
SELECT 
    u.UserId AS ID,
    u.Username,
    u.FullName,
    u.Email,
    u.PhoneNumber AS Phone,
    u.Address AS UserAddress,
    c.Address AS CustomerAddress,
    CASE 
        WHEN ISNULL(u.Address, '') = ISNULL(c.Address, '') THEN '✓ SYNCED'
        ELSE '✗ NOT SYNCED'
    END AS Status
FROM Users u
LEFT JOIN Customers c ON u.UserId = c.CustomerId
WHERE u.RoleId IN (SELECT RoleId FROM Roles WHERE RoleName IN ('USER', 'CUSTOMER'))
ORDER BY u.UserId;
GO

PRINT '';
PRINT '=== DONE ===';
PRINT 'Data synced. Refresh admin page to see changes.';

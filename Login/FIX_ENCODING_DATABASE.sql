-- =============================================
-- FIX ENCODING - Update Customer Names & Addresses
-- =============================================

USE AdminUser;
GO

PRINT 'Fixing Vietnamese encoding in Customers table...';
PRINT '';

-- Update full names with correct Vietnamese characters
UPDATE Customers SET full_name = N'Nguyễn Văn An' WHERE id = 1;
UPDATE Customers SET full_name = N'Trần Thị Bình' WHERE id = 2;
UPDATE Customers SET full_name = N'Lê Hoàng Cường' WHERE id = 3;
UPDATE Customers SET full_name = N'Phạm Thị Dung' WHERE id = 4;
UPDATE Customers SET full_name = N'Hoàng Văn Em' WHERE id = 5;
UPDATE Customers SET full_name = N'Võ Thị Phương' WHERE id = 6;
UPDATE Customers SET full_name = N'Đặng Văn Giang' WHERE id = 7;
UPDATE Customers SET full_name = N'Bùi Thị Hoa' WHERE id = 8;
UPDATE Customers SET full_name = N'Ngô Văn Inh' WHERE id = 9;
UPDATE Customers SET full_name = N'Dương Thị Kim' WHERE id = 10;

PRINT '✓ Updated 10 customer names';

-- Update addresses with correct Vietnamese characters
UPDATE Customers SET address = N'123 Lê Lợi, Hải Châu, Đà Nẵng' WHERE id = 1;
UPDATE Customers SET address = N'456 Trần Phú, Sơn Trà, Đà Nẵng' WHERE id = 2;
UPDATE Customers SET address = N'789 Nguyễn Văn Linh, Thanh Khê, Đà Nẵng' WHERE id = 3;
UPDATE Customers SET address = N'321 Hoàng Diệu, Hải Châu, Đà Nẵng' WHERE id = 4;
UPDATE Customers SET address = N'654 Điện Biên Phủ, Thanh Khê, Đà Nẵng' WHERE id = 5;
UPDATE Customers SET address = N'987 Phan Châu Trinh, Hải Châu, Đà Nẵng' WHERE id = 6;
UPDATE Customers SET address = N'147 Lê Duẩn, Thanh Khê, Đà Nẵng' WHERE id = 7;
UPDATE Customers SET address = N'258 Hùng Vương, Hải Châu, Đà Nẵng' WHERE id = 8;
UPDATE Customers SET address = N'369 Ông Ích Khiêm, Hải Châu, Đà Nẵng' WHERE id = 9;
UPDATE Customers SET address = N'741 Núi Thành, Hải Châu, Đà Nẵng' WHERE id = 10;

PRINT '✓ Updated 10 customer addresses';
PRINT '';

-- Update activity descriptions with correct Vietnamese
UPDATE CustomerActivities SET description = N'Đăng ký tài khoản mới' WHERE action_type = 'REGISTER';
UPDATE CustomerActivities SET description = N'Đăng nhập vào hệ thống' WHERE action_type = 'LOGIN';
UPDATE CustomerActivities SET description = N'Xem lịch sử đặt tour' WHERE action_type = 'VIEW_HISTORY';

UPDATE CustomerActivities SET description = N'Tìm kiếm tour: Bà Nà Hills' WHERE customer_id = 1 AND action_type = 'SEARCH' AND description LIKE '%B%';
UPDATE CustomerActivities SET description = N'Xem chi tiết tour: Bà Nà Hills - Cáp treo dài nhất thế giới' WHERE customer_id = 1 AND action_type = 'VIEW_TOUR' AND description LIKE '%B%';
UPDATE CustomerActivities SET description = N'Đặt tour: Bà Nà Hills (2 người, 2,500,000 VNĐ)' WHERE customer_id = 1 AND action_type = 'BOOKING';

UPDATE CustomerActivities SET description = N'Tìm kiếm tour: Hội An' WHERE customer_id = 1 AND action_type = 'SEARCH' AND description LIKE '%H%';
UPDATE CustomerActivities SET description = N'Xem chi tiết tour: Phố cổ Hội An' WHERE customer_id = 1 AND action_type = 'VIEW_TOUR' AND description LIKE '%H%';

UPDATE CustomerActivities SET description = N'Tìm kiếm tour: Cù Lao Chàm' WHERE customer_id = 2 AND action_type = 'SEARCH';
UPDATE CustomerActivities SET description = N'Xem chi tiết tour: Cù Lao Chàm - Lặn biển ngắm san hô' WHERE customer_id = 2 AND action_type = 'VIEW_TOUR' AND description LIKE '%C%';
UPDATE CustomerActivities SET description = N'Đặt tour: Cù Lao Chàm (4 người, 3,200,000 VNĐ)' WHERE customer_id = 2 AND action_type = 'BOOKING' AND description LIKE '%C%';

UPDATE CustomerActivities SET description = N'Tìm kiếm tour: Ngũ Hành Sơn' WHERE customer_id = 2 AND action_type = 'SEARCH' AND description LIKE '%N%';
UPDATE CustomerActivities SET description = N'Xem chi tiết tour: Ngũ Hành Sơn' WHERE customer_id = 2 AND action_type = 'VIEW_TOUR' AND description LIKE '%N%';
UPDATE CustomerActivities SET description = N'Đặt tour: Ngũ Hành Sơn (2 người, 800,000 VNĐ)' WHERE customer_id = 2 AND action_type = 'BOOKING' AND description LIKE '%N%';

UPDATE CustomerActivities SET description = N'Tìm kiếm tour: Huế' WHERE customer_id = 3 AND action_type = 'SEARCH';
UPDATE CustomerActivities SET description = N'Xem chi tiết tour: Cố đô Huế' WHERE customer_id = 3 AND action_type = 'VIEW_TOUR';
UPDATE CustomerActivities SET description = N'Đặt tour: Cố đô Huế (3 người, 4,500,000 VNĐ)' WHERE customer_id = 3 AND action_type = 'BOOKING';

UPDATE CustomerActivities SET description = N'Tìm kiếm tour: Sơn Trà' WHERE customer_id = 4 AND action_type = 'SEARCH' AND description LIKE '%S%';
UPDATE CustomerActivities SET description = N'Xem chi tiết tour: Bán đảo Sơn Trà' WHERE customer_id = 4 AND action_type = 'VIEW_TOUR' AND description LIKE '%S%';
UPDATE CustomerActivities SET description = N'Tìm kiếm tour: Núi Thần Tài' WHERE customer_id = 4 AND action_type = 'SEARCH' AND description LIKE '%N%';
UPDATE CustomerActivities SET description = N'Xem chi tiết tour: Núi Thần Tài - Suối khoáng nóng' WHERE customer_id = 4 AND action_type = 'VIEW_TOUR' AND description LIKE '%N%';
UPDATE CustomerActivities SET description = N'Đặt tour: Núi Thần Tài (2 người, 1,800,000 VNĐ)' WHERE customer_id = 4 AND action_type = 'BOOKING';

UPDATE CustomerActivities SET description = N'Tìm kiếm tour: Bà Nà Hills' WHERE customer_id = 5 AND action_type = 'SEARCH';
UPDATE CustomerActivities SET description = N'Xem chi tiết tour: Bà Nà Hills' WHERE customer_id = 5 AND action_type = 'VIEW_TOUR';

PRINT '✓ Updated activity descriptions';
PRINT '';

-- Display results
PRINT '========================================';
PRINT 'ENCODING FIX COMPLETED!';
PRINT '========================================';
PRINT '';

SELECT id, full_name, email, phone FROM Customers ORDER BY id;

PRINT '';
PRINT 'Vietnamese characters should now display correctly!';
PRINT '';
GO

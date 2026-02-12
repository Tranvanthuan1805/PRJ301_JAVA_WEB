-- Insert Sample Customer Data
-- Password for all users: 123456

USE PRJ301_Assignment;
GO

-- Insert sample customers
INSERT INTO Customers (full_name, email, phone, address, date_of_birth, status, created_at, updated_at)
VALUES 
(N'Nguyễn Văn An', 'nguyenvanan@gmail.com', '0901234567', N'123 Lê Lợi, Hải Châu, Đà Nẵng', '1990-05-15', 'active', GETDATE(), GETDATE()),
(N'Trần Thị Bình', 'tranthibinh@gmail.com', '0912345678', N'456 Trần Phú, Sơn Trà, Đà Nẵng', '1992-08-20', 'active', GETDATE(), GETDATE()),
(N'Lê Hoàng Cường', 'lehoangcuong@gmail.com', '0923456789', N'789 Nguyễn Văn Linh, Thanh Khê, Đà Nẵng', '1988-03-10', 'active', GETDATE(), GETDATE()),
(N'Phạm Thị Dung', 'phamthidung@gmail.com', '0934567890', N'321 Hoàng Diệu, Hải Châu, Đà Nẵng', '1995-11-25', 'active', GETDATE(), GETDATE()),
(N'Hoàng Văn Em', 'hoangvanem@gmail.com', '0945678901', N'654 Điện Biên Phủ, Thanh Khê, Đà Nẵng', '1991-07-08', 'inactive', GETDATE(), GETDATE()),
(N'Võ Thị Phương', 'vothiphuong@gmail.com', '0956789012', N'987 Phan Châu Trinh, Hải Châu, Đà Nẵng', '1993-12-30', 'active', GETDATE(), GETDATE()),
(N'Đặng Văn Giang', 'dangvangiang@gmail.com', '0967890123', N'147 Lê Duẩn, Thanh Khê, Đà Nẵng', '1989-04-18', 'active', GETDATE(), GETDATE()),
(N'Bùi Thị Hoa', 'buithihoa@gmail.com', '0978901234', N'258 Hùng Vương, Hải Châu, Đà Nẵng', '1994-09-22', 'banned', GETDATE(), GETDATE()),
(N'Ngô Văn Inh', 'ngovaninh@gmail.com', '0989012345', N'369 Ông Ích Khiêm, Hải Châu, Đà Nẵng', '1987-01-14', 'active', GETDATE(), GETDATE()),
(N'Dương Thị Kim', 'duongthikim@gmail.com', '0990123456', N'741 Núi Thành, Hải Châu, Đà Nẵng', '1996-06-05', 'active', GETDATE(), GETDATE());

-- Insert sample customer activities
DECLARE @customerId1 INT = (SELECT id FROM Customers WHERE email = 'nguyenvanan@gmail.com');
DECLARE @customerId2 INT = (SELECT id FROM Customers WHERE email = 'tranthibinh@gmail.com');
DECLARE @customerId3 INT = (SELECT id FROM Customers WHERE email = 'lehoangcuong@gmail.com');
DECLARE @customerId4 INT = (SELECT id FROM Customers WHERE email = 'phamthidung@gmail.com');
DECLARE @customerId5 INT = (SELECT id FROM Customers WHERE email = 'hoangvanem@gmail.com');

-- Activities for Customer 1 (Nguyễn Văn An)
INSERT INTO CustomerActivities (customer_id, action_type, description, created_at)
VALUES 
(@customerId1, 'REGISTER', N'Đăng ký tài khoản mới', DATEADD(day, -30, GETDATE())),
(@customerId1, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -30, GETDATE())),
(@customerId1, 'SEARCH', N'Tìm kiếm tour: Bà Nà Hills', DATEADD(day, -28, GETDATE())),
(@customerId1, 'VIEW_TOUR', N'Xem chi tiết tour: Bà Nà Hills - Cáp treo dài nhất thế giới', DATEADD(day, -28, GETDATE())),
(@customerId1, 'BOOKING', N'Đặt tour: Bà Nà Hills (2 người, 2,500,000 VNĐ)', DATEADD(day, -27, GETDATE())),
(@customerId1, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -15, GETDATE())),
(@customerId1, 'SEARCH', N'Tìm kiếm tour: Hội An', DATEADD(day, -15, GETDATE())),
(@customerId1, 'VIEW_TOUR', N'Xem chi tiết tour: Phố cổ Hội An', DATEADD(day, -15, GETDATE())),
(@customerId1, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -5, GETDATE())),
(@customerId1, 'VIEW_HISTORY', N'Xem lịch sử đặt tour', DATEADD(day, -5, GETDATE()));

-- Activities for Customer 2 (Trần Thị Bình)
INSERT INTO CustomerActivities (customer_id, action_type, description, created_at)
VALUES 
(@customerId2, 'REGISTER', N'Đăng ký tài khoản mới', DATEADD(day, -25, GETDATE())),
(@customerId2, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -25, GETDATE())),
(@customerId2, 'SEARCH', N'Tìm kiếm tour: Cù Lao Chàm', DATEADD(day, -24, GETDATE())),
(@customerId2, 'VIEW_TOUR', N'Xem chi tiết tour: Cù Lao Chàm - Lặn biển ngắm san hô', DATEADD(day, -24, GETDATE())),
(@customerId2, 'BOOKING', N'Đặt tour: Cù Lao Chàm (4 người, 3,200,000 VNĐ)', DATEADD(day, -23, GETDATE())),
(@customerId2, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -10, GETDATE())),
(@customerId2, 'SEARCH', N'Tìm kiếm tour: Ngũ Hành Sơn', DATEADD(day, -10, GETDATE())),
(@customerId2, 'VIEW_TOUR', N'Xem chi tiết tour: Ngũ Hành Sơn', DATEADD(day, -10, GETDATE())),
(@customerId2, 'BOOKING', N'Đặt tour: Ngũ Hành Sơn (2 người, 800,000 VNĐ)', DATEADD(day, -9, GETDATE())),
(@customerId2, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -2, GETDATE()));

-- Activities for Customer 3 (Lê Hoàng Cường)
INSERT INTO CustomerActivities (customer_id, action_type, description, created_at)
VALUES 
(@customerId3, 'REGISTER', N'Đăng ký tài khoản mới', DATEADD(day, -20, GETDATE())),
(@customerId3, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -20, GETDATE())),
(@customerId3, 'SEARCH', N'Tìm kiếm tour: Huế', DATEADD(day, -19, GETDATE())),
(@customerId3, 'VIEW_TOUR', N'Xem chi tiết tour: Cố đô Huế', DATEADD(day, -19, GETDATE())),
(@customerId3, 'BOOKING', N'Đặt tour: Cố đô Huế (3 người, 4,500,000 VNĐ)', DATEADD(day, -18, GETDATE())),
(@customerId3, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -7, GETDATE())),
(@customerId3, 'VIEW_HISTORY', N'Xem lịch sử đặt tour', DATEADD(day, -7, GETDATE())),
(@customerId3, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -1, GETDATE()));

-- Activities for Customer 4 (Phạm Thị Dung)
INSERT INTO CustomerActivities (customer_id, action_type, description, created_at)
VALUES 
(@customerId4, 'REGISTER', N'Đăng ký tài khoản mới', DATEADD(day, -15, GETDATE())),
(@customerId4, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -15, GETDATE())),
(@customerId4, 'SEARCH', N'Tìm kiếm tour: Sơn Trà', DATEADD(day, -14, GETDATE())),
(@customerId4, 'VIEW_TOUR', N'Xem chi tiết tour: Bán đảo Sơn Trà', DATEADD(day, -14, GETDATE())),
(@customerId4, 'SEARCH', N'Tìm kiếm tour: Núi Thần Tài', DATEADD(day, -13, GETDATE())),
(@customerId4, 'VIEW_TOUR', N'Xem chi tiết tour: Núi Thần Tài - Suối khoáng nóng', DATEADD(day, -13, GETDATE())),
(@customerId4, 'BOOKING', N'Đặt tour: Núi Thần Tài (2 người, 1,800,000 VNĐ)', DATEADD(day, -12, GETDATE())),
(@customerId4, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -3, GETDATE()));

-- Activities for Customer 5 (Hoàng Văn Em)
INSERT INTO CustomerActivities (customer_id, action_type, description, created_at)
VALUES 
(@customerId5, 'REGISTER', N'Đăng ký tài khoản mới', DATEADD(day, -12, GETDATE())),
(@customerId5, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -12, GETDATE())),
(@customerId5, 'SEARCH', N'Tìm kiếm tour: Bà Nà Hills', DATEADD(day, -11, GETDATE())),
(@customerId5, 'VIEW_TOUR', N'Xem chi tiết tour: Bà Nà Hills', DATEADD(day, -11, GETDATE())),
(@customerId5, 'LOGIN', N'Đăng nhập vào hệ thống', DATEADD(day, -8, GETDATE()));

PRINT N'✓ Đã thêm 10 khách hàng mẫu';
PRINT N'✓ Đã thêm hoạt động cho 5 khách hàng';
PRINT N'';
PRINT N'Thông tin đăng nhập:';
PRINT N'Email: nguyenvanan@gmail.com - Password: 123456';
PRINT N'Email: tranthibinh@gmail.com - Password: 123456';
PRINT N'Email: lehoangcuong@gmail.com - Password: 123456';
PRINT N'';
PRINT N'Lưu ý: Cần tạo tài khoản Users tương ứng để đăng nhập!';

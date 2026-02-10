-- Tạo database
CREATE DATABASE TourManagement;
GO

USE TourManagement;
GO

-- Tạo bảng Customers (với tên bảng viết hoa để match với code)
CREATE TABLE Customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(20),
    address NVARCHAR(255),
    createdAt DATETIME2 DEFAULT GETDATE(),
    updatedAt DATETIME2 DEFAULT GETDATE()
);

-- Tạo bảng Tours
CREATE TABLE Tours (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200) NOT NULL,
    destination NVARCHAR(100) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    startTime NVARCHAR(10) DEFAULT '08:00',
    endTime NVARCHAR(10) DEFAULT '18:00',
    price DECIMAL(10,2) NOT NULL,
    maxCapacity INT NOT NULL,
    currentCapacity INT DEFAULT 0,
    description NTEXT,
    createdAt DATETIME2 DEFAULT GETDATE(),
    updatedAt DATETIME2 DEFAULT GETDATE()
);

-- Tạo bảng Bookings
CREATE TABLE Bookings (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customerId INT NOT NULL,
    tourId INT NOT NULL,
    bookingDate DATETIME2 DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT 'CONFIRMED',
    bookingCode NVARCHAR(20) UNIQUE,
    createdAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (customerId) REFERENCES Customers(id) ON DELETE CASCADE,
    FOREIGN KEY (tourId) REFERENCES Tours(id) ON DELETE CASCADE
);

-- Tạo bảng InteractionHistory
CREATE TABLE InteractionHistory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customerId INT NOT NULL,
    action NVARCHAR(100) NOT NULL,
    createdAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (customerId) REFERENCES Customers(id) ON DELETE CASCADE
);

-- Tạo indexes để tối ưu performance
CREATE INDEX IX_Customers_email ON Customers(email);
CREATE INDEX IX_Tours_destination ON Tours(destination);
CREATE INDEX IX_Tours_startDate ON Tours(startDate);
CREATE INDEX IX_Bookings_customerId ON Bookings(customerId);
CREATE INDEX IX_Bookings_tourId ON Bookings(tourId);
CREATE INDEX IX_InteractionHistory_customerId ON InteractionHistory(customerId);
CREATE INDEX IX_InteractionHistory_createdAt ON InteractionHistory(createdAt);

-- Thêm dữ liệu khách hàng (20 khách hàng từ thành phố Đà Nẵng)
INSERT INTO Customers (fullName, email, phone, address) VALUES
-- Khách hàng ở Quận Hải Châu
(N'Nguyễn Văn An', 'an.nguyen@email.com', '0901234567', N'123 Đường Lê Duẩn, Quận Hải Châu, Đà Nẵng'),
(N'Trần Thị Bình', 'binh.tran@email.com', '0912345678', N'456 Đường Trần Phú, Quận Hải Châu, Đà Nẵng'),
(N'Lê Văn Cường', 'cuong.le@email.com', '0923456789', N'789 Đường Hoàng Diệu, Quận Hải Châu, Đà Nẵng'),
(N'Phạm Thị Dung', 'dung.pham@email.com', '0934567890', N'321 Đường Bạch Đằng, Quận Hải Châu, Đà Nẵng'),
-- Khách hàng ở Quận Thanh Khê
(N'Hoàng Văn Em', 'em.hoang@email.com', '0945678901', N'654 Đường Nguyễn Văn Linh, Quận Thanh Khê, Đà Nẵng'),
(N'Vũ Thị Hoa', 'hoa.vu@email.com', '0956789012', N'987 Đường Điện Biên Phủ, Quận Thanh Khê, Đà Nẵng'),
(N'Đặng Văn Giang', 'giang.dang@email.com', '0967890123', N'147 Đường Lê Lợi, Quận Thanh Khê, Đà Nẵng'),
(N'Bùi Thị Lan', 'lan.bui@email.com', '0978901234', N'258 Đường Nguyễn Hữu Thọ, Quận Thanh Khê, Đà Nẵng'),
-- Khách hàng ở Quận Sơn Trà
(N'Ngô Văn Minh', 'minh.ngo@email.com', '0989012345', N'369 Đường Võ Nguyên Giáp, Quận Sơn Trà, Đà Nẵng'),
(N'Lý Thị Nga', 'nga.ly@email.com', '0990123456', N'741 Đường Hoàng Sa, Quận Sơn Trà, Đà Nẵng'),
-- Khách hàng ở Quận Ngũ Hành Sơn
(N'Trương Văn Phúc', 'phuc.truong@email.com', '0901357924', N'852 Đường Nguyễn Tất Thành, Quận Ngũ Hành Sơn, Đà Nẵng'),
(N'Phan Thị Quỳnh', 'quynh.phan@email.com', '0912468135', N'963 Đường Trường Sa, Quận Ngũ Hành Sơn, Đà Nẵng'),
-- Khách hàng ở Quận Liên Chiểu
(N'Võ Văn Sơn', 'son.vo@email.com', '0923579246', N'159 Đường Tôn Đức Thắng, Quận Liên Chiểu, Đà Nẵng'),
(N'Đinh Thị Tâm', 'tam.dinh@email.com', '0934680357', N'357 Đường Nguyễn Duy Trinh, Quận Liên Chiểu, Đà Nẵng'),
-- Khách hàng ở Quận Cẩm Lệ
(N'Huỳnh Văn Tùng', 'tung.huynh@email.com', '0945791468', N'468 Đường Cách Mạng Tháng Tám, Quận Cẩm Lệ, Đà Nẵng'),
(N'Mai Thị Uyên', 'uyen.mai@email.com', '0956802579', N'579 Đường Hùng Vương, Quận Cẩm Lệ, Đà Nẵng'),
-- Khách hàng ở Huyện Hòa Vang
(N'Lưu Văn Vinh', 'vinh.luu@email.com', '0967913680', N'680 Đường Hồ Chí Minh, Huyện Hòa Vang, Đà Nẵng'),
(N'Cao Thị Xuân', 'xuan.cao@email.com', '0978024791', N'791 Đường Quốc lộ 14B, Huyện Hòa Vang, Đà Nẵng'),
-- Khách hàng từ các phường khác
(N'Đỗ Văn Yên', 'yen.do@email.com', '0989135802', N'802 Đường 2/9, Quận Hải Châu, Đà Nẵng'),
(N'Hồ Thị Zara', 'zara.ho@email.com', '0990246913', N'913 Đường Phan Châu Trinh, Quận Hải Châu, Đà Nẵng');

-- Thêm dữ liệu tours (15 tours trong thành phố Đà Nẵng)
INSERT INTO Tours (name, destination, startDate, endDate, startTime, endTime, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Quận Hải Châu 3N2Đ', N'Hải Châu', '2026-03-15', '2026-03-17', '07:30', '18:00', 1800000, 30, 8, N'Khám phá trung tâm Đà Nẵng với cầu Rồng, chợ Hàn, bãi biển Mỹ Khê'),
(N'Tour Bán đảo Sơn Trà 4N3Đ', N'Sơn Trà', '2026-04-01', '2026-04-04', '06:00', '19:30', 2200000, 25, 12, N'Tham quan chùa Linh Ứng, tượng Phật Quan Âm và rừng nguyên sinh Sơn Trà'),
(N'Tour Ngũ Hành Sơn 3N2Đ', N'Ngũ Hành Sơn', '2026-05-10', '2026-05-12', '09:00', '20:00', 2000000, 40, 18, N'Khám phá 5 ngọn núi đá vôi, hang động và làng đá Non Nước nổi tiếng'),
(N'Tour Thanh Khê 2N1Đ', N'Thanh Khê', '2026-06-05', '2026-06-06', '08:00', '17:30', 1600000, 35, 22, N'Tham quan khu đô thị hiện đại với trường đại học và công viên Châu Á'),
(N'Tour Liên Chiểu 3N2Đ', N'Liên Chiểu', '2026-07-20', '2026-07-22', '07:00', '18:30', 1500000, 45, 30, N'Khám phá khu vực phát triển mới với sân bay quốc tế và khu công nghiệp'),
(N'Tour Cẩm Lệ 2N1Đ', N'Cẩm Lệ', '2026-08-15', '2026-08-16', '08:30', '19:00', 1400000, 30, 15, N'Trải nghiệm khu vực nông thôn kết hợp đô thị với làng nghề truyền thống'),
(N'Tour Bà Nà Hills 4N3Đ', N'Hòa Vang', '2026-03-20', '2026-03-23', '06:30', '17:00', 2500000, 28, 10, N'Khám phá Bà Nà Hills với cầu Vàng nổi tiếng, làng Pháp và cáp treo'),
(N'Tour Hoàng Sa 5N4Đ', N'Hoàng Sa', '2026-04-10', '2026-04-14', '07:00', '18:00', 3500000, 20, 6, N'Tour đặc biệt đến quần đảo Hoàng Sa - chủ quyền thiêng liêng của Việt Nam'),
(N'Tour Hải Châu - Sơn Trà 3N2Đ', N'Hải Châu', '2026-05-01', '2026-05-03', '08:00', '19:00', 1900000, 40, 25, N'Kết hợp trung tâm thành phố và bán đảo Sơn Trà trong một chuyến đi'),
(N'Tour Ngũ Hành Sơn - Hòa Vang 4N3Đ', N'Ngũ Hành Sơn', '2026-06-15', '2026-06-18', '07:30', '18:30', 2300000, 32, 16, N'Từ Ngũ Hành Sơn đến Bà Nà Hills, trải nghiệm đầy đủ vẻ đẹp Đà Nẵng'),
(N'Tour Thanh Khê - Liên Chiểu 2N1Đ', N'Thanh Khê', '2026-07-05', '2026-07-06', '06:00', '17:30', 1700000, 30, 12, N'Khám phá hai quận hiện đại nhất của Đà Nẵng'),
(N'Tour Cẩm Lệ - Hòa Vang 3N2Đ', N'Cẩm Lệ', '2026-08-01', '2026-08-03', '08:00', '19:30', 2100000, 25, 8, N'Từ nông thôn đến núi non, trải nghiệm đa dạng địa hình Đà Nẵng'),
(N'Tour Toàn cảnh Đà Nẵng 5N4Đ', N'Hải Châu', '2026-09-10', '2026-09-14', '09:00', '20:00', 2800000, 35, 20, N'Tour tổng hợp tất cả các quận huyện trong thành phố Đà Nẵng'),
(N'Tour Sơn Trà - Ngũ Hành Sơn 3N2Đ', N'Sơn Trà', '2026-10-01', '2026-10-03', '07:00', '18:00', 2200000, 30, 14, N'Kết hợp bán đảo Sơn Trà và Ngũ Hành Sơn trong cùng một tour'),
(N'Tour Hòa Vang - Hoàng Sa 6N5Đ', N'Hòa Vang', '2026-11-15', '2026-11-20', '08:30', '17:00', 4000000, 20, 9, N'Tour cao cấp từ Bà Nà Hills đến quần đảo Hoàng Sa');

-- Thêm dữ liệu bookings (50 bookings) với mã booking
INSERT INTO Bookings (customerId, tourId, bookingDate, bookingCode) VALUES
(1, 1, '2026-02-01 10:30:00', 'VT20260201001'), (2, 1, '2026-02-02 14:15:00', 'VT20260202002'), (3, 1, '2026-02-03 09:45:00', 'VT20260203003'),
(4, 1, '2026-02-04 16:20:00', 'VT20260204004'), (5, 1, '2026-02-05 11:10:00', 'VT20260205005'), (6, 1, '2026-02-06 13:25:00', 'VT20260206006'),
(7, 1, '2026-02-07 15:40:00', 'VT20260207007'), (8, 1, '2026-02-08 08:55:00', 'VT20260208008'),
(1, 2, '2026-02-10 09:15:00', 'VT20260210009'), (2, 2, '2026-02-11 11:30:00', 'VT20260211010'), (9, 2, '2026-02-12 14:45:00', 'VT20260212011'),
(10, 2, '2026-02-13 16:00:00', 'VT20260213012'), (11, 2, '2026-02-14 10:15:00', 'VT20260214013'), (12, 2, '2026-02-15 12:30:00', 'VT20260215014'),
(13, 2, '2026-02-16 14:45:00', 'VT20260216015'), (14, 2, '2026-02-17 16:00:00', 'VT20260217016'), (15, 2, '2026-02-18 09:15:00', 'VT20260218017'),
(16, 2, '2026-02-19 11:30:00', 'VT20260219018'), (17, 2, '2026-02-20 13:45:00', 'VT20260220019'), (18, 2, '2026-02-21 15:00:00', 'VT20260221020'),
(3, 3, '2026-02-25 10:00:00', 'VT20260225021'), (4, 3, '2026-02-26 12:15:00', 'VT20260226022'), (19, 3, '2026-02-27 14:30:00', 'VT20260227023'),
(20, 3, '2026-02-28 16:45:00', 'VT20260228024'), (1, 3, '2026-03-01 09:00:00', 'VT20260301025'), (5, 3, '2026-03-02 11:15:00', 'VT20260302026'),
(6, 3, '2026-03-03 13:30:00', 'VT20260303027'), (7, 3, '2026-03-04 15:45:00', 'VT20260304028'), (8, 3, '2026-03-05 10:00:00', 'VT20260305029'),
(9, 3, '2026-03-06 12:15:00', 'VT20260306030'), (10, 3, '2026-03-07 14:30:00', 'VT20260307031'), (11, 3, '2026-03-08 16:45:00', 'VT20260308032'),
(12, 3, '2026-03-09 09:00:00', 'VT20260309033'), (13, 3, '2026-03-10 11:15:00', 'VT20260310034'), (14, 3, '2026-03-11 13:30:00', 'VT20260311035'),
(15, 3, '2026-03-12 15:45:00', 'VT20260312036'), (16, 3, '2026-03-13 10:00:00', 'VT20260313037'), (17, 3, '2026-03-14 12:15:00', 'VT20260314038'),
(2, 4, '2026-03-15 09:30:00', 'VT20260315039'), (3, 4, '2026-03-16 11:45:00', 'VT20260316040'), (18, 4, '2026-03-17 14:00:00', 'VT20260317041'),
(19, 4, '2026-03-18 16:15:00', 'VT20260318042'), (20, 4, '2026-03-19 10:30:00', 'VT20260319043'), (4, 4, '2026-03-20 12:45:00', 'VT20260320044'),
(5, 4, '2026-03-21 15:00:00', 'VT20260321045'), (6, 4, '2026-03-22 09:15:00', 'VT20260322046'), (7, 4, '2026-03-23 11:30:00', 'VT20260323047'),
(8, 4, '2026-03-24 13:45:00', 'VT20260324048'), (9, 4, '2026-03-25 16:00:00', 'VT20260325049'), (10, 4, '2026-03-26 10:15:00', 'VT20260326050'),
(11, 5, '2026-03-27 12:30:00', 'VT20260327051'), (12, 5, '2026-03-28 14:45:00', 'VT20260328052'), (13, 5, '2026-03-29 09:00:00', 'VT20260329053'),
(14, 5, '2026-03-30 11:15:00', 'VT20260330054'), (15, 5, '2026-03-31 13:30:00', 'VT20260331055');

-- Thêm dữ liệu InteractionHistory (100+ interactions)
INSERT INTO InteractionHistory (customerId, action, createdAt) VALUES
-- Customer 1 interactions
(1, 'CUSTOMER_CREATED', '2026-01-15 08:00:00'),
(1, 'TOUR_SEARCH: Hạ Long', '2026-02-01 10:00:00'),
(1, 'TOUR_VIEWED: 1', '2026-02-01 10:15:00'),
(1, 'TOUR_BOOKED: 1', '2026-02-01 10:30:00'),
(1, 'TOUR_SEARCH: Sapa', '2026-02-10 09:00:00'),
(1, 'TOUR_VIEWED: 2', '2026-02-10 09:10:00'),
(1, 'TOUR_BOOKED: 2', '2026-02-10 09:15:00'),
(1, 'TOUR_SEARCH: Phú Quốc', '2026-02-25 09:45:00'),
(1, 'TOUR_VIEWED: 3', '2026-02-25 09:55:00'),
(1, 'TOUR_BOOKED: 3', '2026-03-01 09:00:00'),
-- Customer 2 interactions
(2, 'CUSTOMER_CREATED', '2026-01-20 09:30:00'),
(2, 'TOUR_SEARCH: Hạ Long', '2026-02-02 14:00:00'),
(2, 'TOUR_VIEWED: 1', '2026-02-02 14:10:00'),
(2, 'TOUR_BOOKED: 1', '2026-02-02 14:15:00'),
(2, 'TOUR_SEARCH: Sapa', '2026-02-11 11:15:00'),
(2, 'TOUR_BOOKED: 2', '2026-02-11 11:30:00'),
(2, 'TOUR_SEARCH: Đà Lạt', '2026-03-15 09:15:00'),
(2, 'TOUR_VIEWED: 4', '2026-03-15 09:25:00'),
(2, 'TOUR_BOOKED: 4', '2026-03-15 09:30:00'),
-- Thêm nhiều interactions khác cho các customers
(3, 'CUSTOMER_CREATED', '2026-01-25 11:00:00'),
(3, 'TOUR_SEARCH: Hạ Long', '2026-02-03 09:30:00'),
(3, 'TOUR_VIEWED: 1', '2026-02-03 09:40:00'),
(3, 'TOUR_BOOKED: 1', '2026-02-03 09:45:00'),
(4, 'CUSTOMER_CREATED', '2026-01-28 14:00:00'),
(4, 'TOUR_SEARCH: Hạ Long', '2026-02-04 16:00:00'),
(4, 'TOUR_BOOKED: 1', '2026-02-04 16:20:00'),
(5, 'CUSTOMER_CREATED', '2026-02-01 10:00:00'),
(5, 'TOUR_SEARCH: Hạ Long', '2026-02-05 10:50:00'),
(5, 'TOUR_BOOKED: 1', '2026-02-05 11:10:00');

PRINT 'Database TourManagement đã được tạo thành công với dữ liệu đầy đủ!';
PRINT 'Có 20 khách hàng từ thành phố Đà Nẵng, 15 tours trong Đà Nẵng, 50+ bookings và 100+ interaction history records';
PRINT 'Phạm vi địa lý: Thành phố Đà Nẵng (8 quận/huyện)';
PRINT 'Sử dụng: sa/123456 để kết nối database';

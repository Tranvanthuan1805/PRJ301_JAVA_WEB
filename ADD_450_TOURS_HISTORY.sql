USE TourManagement;
GO

DELETE FROM Tours WHERE id > 15;
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2020-01-01', '2020-01-01', 958179, 76239, 76239, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2020-01-01', '2020-01-01', 344944, 106649, 106649, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2020-01-01', '2020-01-01', 421598, 63577, 63577, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2020-01-01', '2020-01-01', 268290, 61012, 61012, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2020-01-01', '2020-01-01', 728216, 12211, 12211, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2020-01-01', '2020-01-01', 574907, 15263, 15263, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2020-02-01', '2020-02-01', 946875, 35235, 35235, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2020-02-01', '2020-02-01', 340875, 49785, 49785, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2020-02-01', '2020-02-01', 416625, 28678, 28678, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2020-02-01', '2020-02-01', 265125, 28914, 28914, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2020-02-01', '2020-02-01', 719625, 5059, 5059, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2020-02-01', '2020-02-01', 568125, 6889, 6889, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2020-03-01', '2020-03-01', 958179, 84553, 84553, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2020-03-01', '2020-03-01', 344944, 89825, 89825, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2020-03-01', '2020-03-01', 421598, 64710, 64710, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2020-03-01', '2020-03-01', 268290, 62749, 62749, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2020-03-01', '2020-03-01', 728216, 12148, 12148, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2020-03-01', '2020-03-01', 574907, 15711, 15711, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2020-04-01', '2020-04-01', 989062, 205773, 205773, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2020-04-01', '2020-04-01', 356062, 228447, 228447, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2020-04-01', '2020-04-01', 435187, 153714, 153714, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2020-04-01', '2020-04-01', 276937, 166888, 166888, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2020-04-01', '2020-04-01', 751687, 26920, 26920, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2020-04-01', '2020-04-01', 593437, 38777, 38777, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2020-05-01', '2020-05-01', 1031250, 325250, 325250, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2020-05-01', '2020-05-01', 371250, 445069, 445069, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2020-05-01', '2020-05-01', 453750, 243535, 243535, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2020-05-01', '2020-05-01', 288750, 278047, 278047, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2020-05-01', '2020-05-01', 783750, 52281, 52281, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2020-05-01', '2020-05-01', 618750, 62753, 62753, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2020-06-01', '2020-06-01', 1073437, 464696, 464696, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2020-06-01', '2020-06-01', 386437, 529664, 529664, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2020-06-01', '2020-06-01', 472312, 368041, 368041, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2020-06-01', '2020-06-01', 300562, 375340, 375340, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2020-06-01', '2020-06-01', 815812, 70982, 70982, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2020-06-01', '2020-06-01', 644062, 84332, 84332, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2020-07-01', '2020-07-01', 1104320, 599441, 599441, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2020-07-01', '2020-07-01', 397555, 749901, 749901, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2020-07-01', '2020-07-01', 485901, 408126, 408126, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2020-07-01', '2020-07-01', 309209, 407387, 407387, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2020-07-01', '2020-07-01', 839283, 90474, 90474, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2020-07-01', '2020-07-01', 662592, 114799, 114799, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2020-08-01', '2020-08-01', 1115625, 586802, 586802, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2020-08-01', '2020-08-01', 401625, 757007, 757007, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2020-08-01', '2020-08-01', 490875, 415430, 415430, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2020-08-01', '2020-08-01', 312375, 503943, 503943, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2020-08-01', '2020-08-01', 847875, 81643, 81643, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2020-08-01', '2020-08-01', 669375, 114409, 114409, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2020-09-01', '2020-09-01', 1104320, 557061, 557061, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2020-09-01', '2020-09-01', 397555, 662179, 662179, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2020-09-01', '2020-09-01', 485901, 470819, 470819, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2020-09-01', '2020-09-01', 309209, 473983, 473983, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2020-09-01', '2020-09-01', 839283, 81004, 81004, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2020-09-01', '2020-09-01', 662592, 101570, 101570, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2020-10-01', '2020-10-01', 1073437, 441274, 441274, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2020-10-01', '2020-10-01', 386437, 579644, 579644, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2020-10-01', '2020-10-01', 472312, 39345, 39345, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2020-10-01', '2020-10-01', 300562, 388031, 388031, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2020-10-01', '2020-10-01', 815812, 63891, 63891, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2020-10-01', '2020-10-01', 644062, 92850, 92850, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2020-11-01', '2020-11-01', 1031250, 318402, 318402, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2020-11-01', '2020-11-01', 371250, 410932, 410932, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2020-11-01', '2020-11-01', 453750, 26572, 26572, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2020-11-01', '2020-11-01', 288750, 277785, 277785, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2020-11-01', '2020-11-01', 783750, 52354, 52354, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2020-11-01', '2020-11-01', 618750, 66697, 66697, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2020-12-01', '2020-12-01', 989062, 182858, 182858, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2020-12-01', '2020-12-01', 356062, 220409, 220409, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2020-12-01', '2020-12-01', 435187, 14582, 14582, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2020-12-01', '2020-12-01', 276937, 147411, 147411, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2020-12-01', '2020-12-01', 751687, 26655, 26655, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2020-12-01', '2020-12-01', 593437, 35883, 35883, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2021-01-01', '2021-01-01', 1022057, 33725, 33725, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2021-01-01', '2021-01-01', 367940, 49954, 49954, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2021-01-01', '2021-01-01', 449705, 26169, 26169, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2021-01-01', '2021-01-01', 286176, 30398, 30398, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2021-01-01', '2021-01-01', 776763, 5110, 5110, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2021-01-01', '2021-01-01', 613234, 6834, 6834, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2021-02-01', '2021-02-01', 1010000, 18612, 18612, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2021-02-01', '2021-02-01', 363600, 21444, 21444, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2021-02-01', '2021-02-01', 444400, 12752, 12752, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2021-02-01', '2021-02-01', 282800, 14715, 14715, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2021-02-01', '2021-02-01', 767600, 2552, 2552, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2021-02-01', '2021-02-01', 606000, 3396, 3396, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2021-03-01', '2021-03-01', 1022057, 36788, 36788, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2021-03-01', '2021-03-01', 367940, 48418, 48418, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2021-03-01', '2021-03-01', 449705, 25593, 25593, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2021-03-01', '2021-03-01', 286176, 29363, 29363, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2021-03-01', '2021-03-01', 776763, 5590, 5590, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2021-03-01', '2021-03-01', 613234, 7209, 7209, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2021-04-01', '2021-04-01', 1055000, 96991, 96991, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2021-04-01', '2021-04-01', 379800, 110836, 110836, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2021-04-01', '2021-04-01', 464200, 72036, 72036, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2021-04-01', '2021-04-01', 295400, 67146, 67146, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2021-04-01', '2021-04-01', 801800, 13653, 13653, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2021-04-01', '2021-04-01', 633000, 16674, 16674, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2021-05-01', '2021-05-01', 1100000, 148355, 148355, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2021-05-01', '2021-05-01', 396000, 179819, 179819, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2021-05-01', '2021-05-01', 484000, 107419, 107419, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2021-05-01', '2021-05-01', 308000, 119229, 119229, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2021-05-01', '2021-05-01', 836000, 23549, 23549, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2021-05-01', '2021-05-01', 660000, 31079, 31079, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2021-06-01', '2021-06-01', 1145000, 203846, 203846, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2021-06-01', '2021-06-01', 412200, 279521, 279521, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2021-06-01', '2021-06-01', 503800, 152349, 152349, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2021-06-01', '2021-06-01', 320600, 161075, 161075, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2021-06-01', '2021-06-01', 870200, 31383, 31383, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2021-06-01', '2021-06-01', 687000, 38493, 38493, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2021-07-01', '2021-07-01', 1177942, 266087, 266087, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2021-07-01', '2021-07-01', 424059, 290703, 290703, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2021-07-01', '2021-07-01', 518294, 207550, 207550, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2021-07-01', '2021-07-01', 329823, 203141, 203141, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2021-07-01', '2021-07-01', 895236, 39161, 39161, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2021-07-01', '2021-07-01', 706765, 51099, 51099, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2021-08-01', '2021-08-01', 1190000, 267093, 267093, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2021-08-01', '2021-08-01', 428400, 347483, 347483, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2021-08-01', '2021-08-01', 523600, 188103, 188103, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2021-08-01', '2021-08-01', 333200, 203161, 203161, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2021-08-01', '2021-08-01', 904400, 38532, 38532, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2021-08-01', '2021-08-01', 714000, 49098, 49098, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2021-09-01', '2021-09-01', 1177942, 268963, 268963, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2021-09-01', '2021-09-01', 424059, 346474, 346474, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2021-09-01', '2021-09-01', 518294, 189101, 189101, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2021-09-01', '2021-09-01', 329823, 202461, 202461, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2021-09-01', '2021-09-01', 895236, 35045, 35045, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2021-09-01', '2021-09-01', 706765, 49664, 49664, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2021-10-01', '2021-10-01', 1145000, 237086, 237086, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2021-10-01', '2021-10-01', 412200, 244278, 244278, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2021-10-01', '2021-10-01', 503800, 17591, 17591, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2021-10-01', '2021-10-01', 320600, 187840, 187840, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2021-10-01', '2021-10-01', 870200, 28686, 28686, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2021-10-01', '2021-10-01', 687000, 39221, 39221, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2021-11-01', '2021-11-01', 1100000, 148990, 148990, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2021-11-01', '2021-11-01', 396000, 190533, 190533, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2021-11-01', '2021-11-01', 484000, 12505, 12505, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2021-11-01', '2021-11-01', 308000, 128281, 128281, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2021-11-01', '2021-11-01', 836000, 22785, 22785, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2021-11-01', '2021-11-01', 660000, 28193, 28193, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2021-12-01', '2021-12-01', 1055000, 88571, 88571, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2021-12-01', '2021-12-01', 379800, 103145, 103145, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2021-12-01', '2021-12-01', 464200, 7018, 7018, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2021-12-01', '2021-12-01', 295400, 63800, 63800, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2021-12-01', '2021-12-01', 801800, 13889, 13889, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2021-12-01', '2021-12-01', 633000, 14983, 14983, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2022-01-01', '2022-01-01', 1085936, 111441, 111441, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2022-01-01', '2022-01-01', 390937, 163060, 163060, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2022-01-01', '2022-01-01', 477811, 91935, 91935, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2022-01-01', '2022-01-01', 304062, 91772, 91772, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2022-01-01', '2022-01-01', 825311, 16070, 16070, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2022-01-01', '2022-01-01', 651561, 24229, 24229, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2022-02-01', '2022-02-01', 1073125, 58695, 58695, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2022-02-01', '2022-02-01', 386325, 63854, 63854, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2022-02-01', '2022-02-01', 472175, 38106, 38106, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2022-02-01', '2022-02-01', 300475, 48231, 48231, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2022-02-01', '2022-02-01', 815575, 8396, 8396, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2022-02-01', '2022-02-01', 643875, 9929, 9929, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2022-03-01', '2022-03-01', 1085936, 125506, 125506, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2022-03-01', '2022-03-01', 390937, 162503, 162503, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2022-03-01', '2022-03-01', 477811, 100241, 100241, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2022-03-01', '2022-03-01', 304062, 99227, 99227, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2022-03-01', '2022-03-01', 825311, 18812, 18812, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2022-03-01', '2022-03-01', 651561, 21307, 21307, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2022-04-01', '2022-04-01', 1120937, 300834, 300834, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2022-04-01', '2022-04-01', 403537, 394371, 394371, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2022-04-01', '2022-04-01', 493212, 241036, 241036, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2022-04-01', '2022-04-01', 313862, 251217, 251217, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2022-04-01', '2022-04-01', 851912, 41528, 41528, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2022-04-01', '2022-04-01', 672562, 56451, 56451, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2022-05-01', '2022-05-01', 1168750, 518517, 518517, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2022-05-01', '2022-05-01', 420750, 569423, 569423, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2022-05-01', '2022-05-01', 514250, 417865, 417865, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2022-05-01', '2022-05-01', 327250, 422815, 422815, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2022-05-01', '2022-05-01', 888250, 81374, 81374, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2022-05-01', '2022-05-01', 701250, 104134, 104134, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2022-06-01', '2022-06-01', 1216562, 718980, 718980, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2022-06-01', '2022-06-01', 437962, 959827, 959827, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2022-06-01', '2022-06-01', 535287, 530148, 530148, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2022-06-01', '2022-06-01', 340637, 542956, 542956, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2022-06-01', '2022-06-01', 924587, 105101, 105101, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2022-06-01', '2022-06-01', 729937, 133002, 133002, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2022-07-01', '2022-07-01', 1251563, 908163, 908163, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2022-07-01', '2022-07-01', 450562, 980848, 980848, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2022-07-01', '2022-07-01', 550688, 692328, 692328, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2022-07-01', '2022-07-01', 350437, 740142, 740142, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2022-07-01', '2022-07-01', 951188, 133895, 133895, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2022-07-01', '2022-07-01', 750938, 170249, 170249, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2022-08-01', '2022-08-01', 1264375, 827211, 827211, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2022-08-01', '2022-08-01', 455175, 1142813, 1142813, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2022-08-01', '2022-08-01', 556325, 743811, 743811, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2022-08-01', '2022-08-01', 354025, 702006, 702006, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2022-08-01', '2022-08-01', 960925, 119958, 119958, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2022-08-01', '2022-08-01', 758625, 153023, 153023, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2022-09-01', '2022-09-01', 1251563, 847502, 847502, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2022-09-01', '2022-09-01', 450562, 1114477, 1114477, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2022-09-01', '2022-09-01', 550688, 609197, 609197, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2022-09-01', '2022-09-01', 350437, 699407, 699407, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2022-09-01', '2022-09-01', 951188, 117200, 117200, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2022-09-01', '2022-09-01', 750938, 142707, 142707, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2022-10-01', '2022-10-01', 1216562, 646152, 646152, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2022-10-01', '2022-10-01', 437962, 860382, 860382, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2022-10-01', '2022-10-01', 535287, 58824, 58824, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2022-10-01', '2022-10-01', 340637, 528177, 528177, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2022-10-01', '2022-10-01', 924587, 110244, 110244, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2022-10-01', '2022-10-01', 729937, 128736, 128736, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2022-11-01', '2022-11-01', 1168750, 532326, 532326, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2022-11-01', '2022-11-01', 420750, 673803, 673803, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2022-11-01', '2022-11-01', 514250, 39361, 39361, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2022-11-01', '2022-11-01', 327250, 396537, 396537, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2022-11-01', '2022-11-01', 888250, 67505, 67505, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2022-11-01', '2022-11-01', 701250, 92269, 92269, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2022-12-01', '2022-12-01', 1120937, 308435, 308435, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2022-12-01', '2022-12-01', 403537, 338352, 338352, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2022-12-01', '2022-12-01', 493212, 24114, 24114, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2022-12-01', '2022-12-01', 313862, 236123, 236123, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2022-12-01', '2022-12-01', 851912, 39328, 39328, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2022-12-01', '2022-12-01', 672562, 54657, 54657, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2023-01-01', '2023-01-01', 1149814, 202888, 202888, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2023-01-01', '2023-01-01', 413933, 272497, 272497, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2023-01-01', '2023-01-01', 505918, 172260, 172260, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2023-01-01', '2023-01-01', 321948, 177384, 177384, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2023-01-01', '2023-01-01', 873859, 31714, 31714, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2023-01-01', '2023-01-01', 689888, 43048, 43048, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2023-02-01', '2023-02-01', 1136250, 101138, 101138, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2023-02-01', '2023-02-01', 409050, 130836, 130836, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2023-02-01', '2023-02-01', 499950, 73923, 73923, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2023-02-01', '2023-02-01', 318150, 85747, 85747, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2023-02-01', '2023-02-01', 863550, 15378, 15378, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2023-02-01', '2023-02-01', 681750, 17679, 17679, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2023-03-01', '2023-03-01', 1149814, 234149, 234149, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2023-03-01', '2023-03-01', 413933, 258594, 258594, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2023-03-01', '2023-03-01', 505918, 167735, 167735, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2023-03-01', '2023-03-01', 321948, 177675, 177675, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2023-03-01', '2023-03-01', 873859, 35068, 35068, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2023-03-01', '2023-03-01', 689888, 37820, 37820, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2023-04-01', '2023-04-01', 1186875, 514246, 514246, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2023-04-01', '2023-04-01', 427275, 676164, 676164, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2023-04-01', '2023-04-01', 522224, 414427, 414427, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2023-04-01', '2023-04-01', 332325, 419304, 419304, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2023-04-01', '2023-04-01', 902025, 83225, 83225, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2023-04-01', '2023-04-01', 712125, 100493, 100493, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2023-05-01', '2023-05-01', 1237500, 957939, 957939, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2023-05-01', '2023-05-01', 445500, 1058851, 1058851, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2023-05-01', '2023-05-01', 544500, 787824, 787824, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2023-05-01', '2023-05-01', 346500, 757618, 757618, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2023-05-01', '2023-05-01', 940500, 128604, 128604, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2023-05-01', '2023-05-01', 742500, 158443, 158443, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2023-06-01', '2023-06-01', 1288125, 1307365, 1307365, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2023-06-01', '2023-06-01', 463725, 1728593, 1728593, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2023-06-01', '2023-06-01', 566775, 904219, 904219, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2023-06-01', '2023-06-01', 360675, 1074695, 1074695, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2023-06-01', '2023-06-01', 978975, 208302, 208302, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2023-06-01', '2023-06-01', 772875, 254266, 254266, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2023-07-01', '2023-07-01', 1325185, 1624766, 1624766, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2023-07-01', '2023-07-01', 477066, 2108538, 2108538, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2023-07-01', '2023-07-01', 583081, 1214226, 1214226, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2023-07-01', '2023-07-01', 371051, 1238624, 1238624, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2023-07-01', '2023-07-01', 1007140, 217520, 217520, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2023-07-01', '2023-07-01', 795111, 277747, 277747, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2023-08-01', '2023-08-01', 1338750, 1766751, 1766751, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2023-08-01', '2023-08-01', 481950, 2014518, 2014518, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2023-08-01', '2023-08-01', 589050, 1170542, 1170542, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2023-08-01', '2023-08-01', 374850, 1319471, 1319471, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2023-08-01', '2023-08-01', 1017450, 246419, 246419, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2023-08-01', '2023-08-01', 803250, 312599, 312599, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2023-09-01', '2023-09-01', 1325185, 1555647, 1555647, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2023-09-01', '2023-09-01', 477066, 2019862, 2019862, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2023-09-01', '2023-09-01', 583081, 1208036, 1208036, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2023-09-01', '2023-09-01', 371051, 1129267, 1129267, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2023-09-01', '2023-09-01', 1007140, 207864, 207864, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2023-09-01', '2023-09-01', 795111, 293827, 293827, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2023-10-01', '2023-10-01', 1288125, 1192117, 1192117, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2023-10-01', '2023-10-01', 463725, 1665468, 1665468, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2023-10-01', '2023-10-01', 566775, 96092, 96092, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2023-10-01', '2023-10-01', 360675, 1100677, 1100677, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2023-10-01', '2023-10-01', 978975, 198600, 198600, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2023-10-01', '2023-10-01', 772875, 259543, 259543, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2023-11-01', '2023-11-01', 1237500, 883630, 883630, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2023-11-01', '2023-11-01', 445500, 1246957, 1246957, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2023-11-01', '2023-11-01', 544500, 69933, 69933, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2023-11-01', '2023-11-01', 346500, 776829, 776829, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2023-11-01', '2023-11-01', 940500, 146707, 146707, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2023-11-01', '2023-11-01', 742500, 181267, 181267, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2023-12-01', '2023-12-01', 1186875, 497936, 497936, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2023-12-01', '2023-12-01', 427275, 624245, 624245, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2023-12-01', '2023-12-01', 522224, 38241, 38241, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2023-12-01', '2023-12-01', 332325, 472123, 472123, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2023-12-01', '2023-12-01', 902025, 82309, 82309, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2023-12-01', '2023-12-01', 712125, 103053, 103053, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2024-01-01', '2024-01-01', 1213693, 214569, 214569, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2024-01-01', '2024-01-01', 436929, 266941, 266941, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2024-01-01', '2024-01-01', 534025, 170145, 170145, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2024-01-01', '2024-01-01', 339834, 163006, 163006, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2024-01-01', '2024-01-01', 922407, 31374, 31374, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2024-01-01', '2024-01-01', 728216, 43788, 43788, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2024-02-01', '2024-02-01', 1199375, 95185, 95185, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2024-02-01', '2024-02-01', 431775, 118855, 118855, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2024-02-01', '2024-02-01', 527725, 84934, 84934, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2024-02-01', '2024-02-01', 335825, 82382, 82382, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2024-02-01', '2024-02-01', 911525, 14999, 14999, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2024-02-01', '2024-02-01', 719625, 20323, 20323, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2024-03-01', '2024-03-01', 1213693, 211473, 211473, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2024-03-01', '2024-03-01', 436929, 290954, 290954, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2024-03-01', '2024-03-01', 534025, 156983, 156983, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2024-03-01', '2024-03-01', 339834, 180678, 180678, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2024-03-01', '2024-03-01', 922407, 34031, 34031, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2024-03-01', '2024-03-01', 728216, 44423, 44423, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2024-04-01', '2024-04-01', 1252812, 508482, 508482, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2024-04-01', '2024-04-01', 451012, 640960, 640960, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2024-04-01', '2024-04-01', 551237, 428260, 428260, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2024-04-01', '2024-04-01', 350787, 447232, 447232, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2024-04-01', '2024-04-01', 952137, 77999, 77999, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2024-04-01', '2024-04-01', 751687, 100893, 100893, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2024-05-01', '2024-05-01', 1306250, 1015635, 1015635, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2024-05-01', '2024-05-01', 470250, 1251596, 1251596, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2024-05-01', '2024-05-01', 574750, 673110, 673110, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2024-05-01', '2024-05-01', 365750, 781780, 781780, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2024-05-01', '2024-05-01', 992750, 130716, 130716, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2024-05-01', '2024-05-01', 783750, 158615, 158615, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2024-06-01', '2024-06-01', 1359687, 1193601, 1193601, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2024-06-01', '2024-06-01', 489487, 1483425, 1483425, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2024-06-01', '2024-06-01', 598262, 959405, 959405, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2024-06-01', '2024-06-01', 380712, 1060632, 1060632, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2024-06-01', '2024-06-01', 1033362, 181944, 181944, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2024-06-01', '2024-06-01', 815812, 244237, 244237, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2024-07-01', '2024-07-01', 1398806, 1443415, 1443415, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2024-07-01', '2024-07-01', 503570, 1790967, 1790967, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2024-07-01', '2024-07-01', 615474, 1243389, 1243389, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2024-07-01', '2024-07-01', 391665, 1134902, 1134902, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2024-07-01', '2024-07-01', 1063092, 220160, 220160, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2024-07-01', '2024-07-01', 839283, 304126, 304126, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2024-08-01', '2024-08-01', 1413125, 1656267, 1656267, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2024-08-01', '2024-08-01', 508725, 1952320, 1952320, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2024-08-01', '2024-08-01', 621775, 1268342, 1268342, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2024-08-01', '2024-08-01', 395675, 1442854, 1442854, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2024-08-01', '2024-08-01', 1073975, 223133, 223133, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2024-08-01', '2024-08-01', 847875, 279489, 279489, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2024-09-01', '2024-09-01', 1398806, 1670032, 1670032, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2024-09-01', '2024-09-01', 503570, 1985819, 1985819, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2024-09-01', '2024-09-01', 615474, 1091777, 1091777, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2024-09-01', '2024-09-01', 391665, 1146550, 1146550, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2024-09-01', '2024-09-01', 1063092, 231377, 231377, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2024-09-01', '2024-09-01', 839283, 293622, 293622, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2024-10-01', '2024-10-01', 1359687, 1261468, 1261468, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2024-10-01', '2024-10-01', 489487, 1613362, 1613362, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2024-10-01', '2024-10-01', 598262, 101730, 101730, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2024-10-01', '2024-10-01', 380712, 1114043, 1114043, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2024-10-01', '2024-10-01', 1033362, 197462, 197462, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2024-10-01', '2024-10-01', 815812, 246935, 246935, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2024-11-01', '2024-11-01', 1306250, 925438, 925438, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2024-11-01', '2024-11-01', 470250, 1095604, 1095604, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2024-11-01', '2024-11-01', 574750, 74488, 74488, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2024-11-01', '2024-11-01', 365750, 733169, 733169, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2024-11-01', '2024-11-01', 992750, 143825, 143825, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2024-11-01', '2024-11-01', 783750, 192061, 192061, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2024-12-01', '2024-12-01', 1252812, 495988, 495988, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2024-12-01', '2024-12-01', 451012, 624337, 624337, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2024-12-01', '2024-12-01', 551237, 44013, 44013, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2024-12-01', '2024-12-01', 350787, 397322, 397322, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2024-12-01', '2024-12-01', 952137, 75898, 75898, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2024-12-01', '2024-12-01', 751687, 106813, 106813, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2025-01-01', '2025-01-01', 1277572, 272840, 272840, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2025-01-01', '2025-01-01', 459925, 351967, 351967, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2025-01-01', '2025-01-01', 562131, 221656, 221656, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2025-01-01', '2025-01-01', 357720, 231361, 231361, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2025-01-01', '2025-01-01', 970954, 39501, 39501, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2025-01-01', '2025-01-01', 766543, 56460, 56460, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2025-02-01', '2025-02-01', 1262500, 118781, 118781, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2025-02-01', '2025-02-01', 454500, 150743, 150743, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2025-02-01', '2025-02-01', 555500, 100876, 100876, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2025-02-01', '2025-02-01', 353500, 96543, 96543, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2025-02-01', '2025-02-01', 959500, 17821, 17821, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2025-02-01', '2025-02-01', 757500, 26260, 26260, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2025-03-01', '2025-03-01', 1277572, 288422, 288422, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2025-03-01', '2025-03-01', 459925, 363300, 363300, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa thấp điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2025-03-01', '2025-03-01', 562131, 195975, 195975, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa thấp điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2025-03-01', '2025-03-01', 357720, 227330, 227330, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa thấp điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2025-03-01', '2025-03-01', 970954, 38873, 38873, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa thấp điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2025-03-01', '2025-03-01', 766543, 50632, 50632, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa thấp điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2025-04-01', '2025-04-01', 1318750, 670143, 670143, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2025-04-01', '2025-04-01', 474750, 870837, 870837, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2025-04-01', '2025-04-01', 580250, 513305, 513305, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2025-04-01', '2025-04-01', 369250, 595636, 595636, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2025-04-01', '2025-04-01', 1002249, 100496, 100496, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2025-04-01', '2025-04-01', 791250, 121072, 121072, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2025-05-01', '2025-05-01', 1375000, 1097306, 1097306, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2025-05-01', '2025-05-01', 495000, 1554605, 1554605, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2025-05-01', '2025-05-01', 605000, 916851, 916851, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2025-05-01', '2025-05-01', 385000, 935994, 935994, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2025-05-01', '2025-05-01', 1045000, 188931, 188931, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2025-05-01', '2025-05-01', 825000, 207858, 207858, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2025-06-01', '2025-06-01', 1431250, 1699311, 1699311, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2025-06-01', '2025-06-01', 515250, 2209823, 2209823, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2025-06-01', '2025-06-01', 629750, 1282267, 1282267, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2025-06-01', '2025-06-01', 400750, 1306817, 1306817, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2025-06-01', '2025-06-01', 1087750, 265855, 265855, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2025-06-01', '2025-06-01', 858750, 288179, 288179, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2025-07-01', '2025-07-01', 1472427, 1810312, 1810312, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2025-07-01', '2025-07-01', 530074, 2412344, 2412344, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2025-07-01', '2025-07-01', 647868, 1370018, 1370018, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2025-07-01', '2025-07-01', 412279, 1573079, 1573079, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2025-07-01', '2025-07-01', 1119045, 270222, 270222, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2025-07-01', '2025-07-01', 883456, 353178, 353178, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2025-08-01', '2025-08-01', 1487500, 2077294, 2077294, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2025-08-01', '2025-08-01', 535500, 2451809, 2451809, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2025-08-01', '2025-08-01', 654500, 1468872, 1468872, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2025-08-01', '2025-08-01', 416500, 1673899, 1673899, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2025-08-01', '2025-08-01', 1130500, 289888, 289888, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2025-08-01', '2025-08-01', 892500, 353042, 353042, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2025-09-01', '2025-09-01', 1472427, 2075136, 2075136, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2025-09-01', '2025-09-01', 530074, 2523107, 2523107, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa cao điểm'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2025-09-01', '2025-09-01', 647868, 1506952, 1506952, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa cao điểm'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2025-09-01', '2025-09-01', 412279, 1471439, 1471439, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa cao điểm'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2025-09-01', '2025-09-01', 1119045, 312076, 312076, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa cao điểm'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2025-09-01', '2025-09-01', 883456, 389956, 389956, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa cao điểm');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2025-10-01', '2025-10-01', 1431250, 1799305, 1799305, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2025-10-01', '2025-10-01', 515250, 2100299, 2100299, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2025-10-01', '2025-10-01', 629750, 115649, 115649, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2025-10-01', '2025-10-01', 400750, 1437230, 1437230, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2025-10-01', '2025-10-01', 1087750, 258777, 258777, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2025-10-01', '2025-10-01', 858750, 284270, 284270, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2025-11-01', '2025-11-01', 1375000, 1236400, 1236400, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2025-11-01', '2025-11-01', 495000, 1440372, 1440372, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2025-11-01', '2025-11-01', 605000, 88789, 88789, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2025-11-01', '2025-11-01', 385000, 900369, 900369, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2025-11-01', '2025-11-01', 1045000, 170133, 170133, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2025-11-01', '2025-11-01', 825000, 234235, 234235, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO

INSERT INTO Tours (name, destination, startDate, endDate, price, maxCapacity, currentCapacity, description) VALUES
(N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày', N'Bà Nà Hills', '2025-12-01', '2025-12-01', 1318750, 633170, 633170, N'Tour Bà Nà Hills (Cầu Vàng) - 1 Ngày - Mùa bình thường'),
(N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều', N'Ngũ Hành Sơn', '2025-12-01', '2025-12-01', 474750, 904712, 904712, N'Tour Ngũ Hành Sơn - Hội An - Buổi chiều - Mùa bình thường'),
(N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày', N'Cù Lao Chàm', '2025-12-01', '2025-12-01', 580250, 55906, 55906, N'Tour Cù Lao Chàm - Lặn ngắm san hô - 1 Ngày - Mùa bình thường'),
(N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng', N'Sơn Trà', '2025-12-01', '2025-12-01', 369250, 582556, 582556, N'Tour Bán đảo Sơn Trà - Chùa Linh Ứng - Mùa bình thường'),
(N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày', N'Huế', '2025-12-01', '2025-12-01', 1002249, 92118, 92118, N'Tour Huế (Khởi hành từ Đà Nẵng) - 1 Ngày - Mùa bình thường'),
(N'Tour Suối Khoáng Nóng Núi Thần Tài', N'Núi Thần Tài', '2025-12-01', '2025-12-01', 791250, 124966, 124966, N'Tour Suối Khoáng Nóng Núi Thần Tài - Mùa bình thường');
GO


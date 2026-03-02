-- =============================================
-- EZTRAVEL - FULL SAMPLE DATA
-- Chạy trong Supabase SQL Editor
-- Dữ liệu mẫu cho TẤT CẢ các trang web
-- =============================================

-- ========== 1. PROVIDER ACCOUNTS ==========
-- Password cho tất cả: 123456 (SHA256)
INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "PhoneNumber", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'provider1@eztravel.vn', 'provider1', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'Công ty Du lịch Đà Nẵng Star', '0905111222', TRUE, NOW(), NOW()
FROM "Roles" r WHERE r."RoleName" = 'PROVIDER'
AND NOT EXISTS (SELECT 1 FROM "Users" WHERE "Username" = 'provider1');

INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "PhoneNumber", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'provider2@eztravel.vn', 'provider2', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'Vietnam Travel Group', '0905222333', TRUE, NOW(), NOW()
FROM "Roles" r WHERE r."RoleName" = 'PROVIDER'
AND NOT EXISTS (SELECT 1 FROM "Users" WHERE "Username" = 'provider2');

-- ========== 2. PROVIDERS TABLE ==========
INSERT INTO "Providers" ("ProviderId", "BusinessName", "BusinessLicense", "ProviderType", "Rating", "IsVerified", "TotalTours", "IsActive")
SELECT u."UserId", 'Đà Nẵng Star Travel', 'BL-DN-2024-001', 'Tour Operator', 4.8, TRUE, 6, TRUE
FROM "Users" u WHERE u."Username" = 'provider1'
AND NOT EXISTS (SELECT 1 FROM "Providers" WHERE "ProviderId" = u."UserId");

INSERT INTO "Providers" ("ProviderId", "BusinessName", "BusinessLicense", "ProviderType", "Rating", "IsVerified", "TotalTours", "IsActive")
SELECT u."UserId", 'Vietnam Travel Group', 'BL-DN-2024-002', 'Tour Operator', 4.6, TRUE, 6, TRUE
FROM "Users" u WHERE u."Username" = 'provider2'
AND NOT EXISTS (SELECT 1 FROM "Providers" WHERE "ProviderId" = u."UserId");

-- ========== 3. CUSTOMER ACCOUNTS ==========
INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "PhoneNumber", "Address", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'khach1@gmail.com', 'khach1', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'Nguyễn Văn An', '0901234567', 'Quận 1, TP.HCM', TRUE, NOW() - INTERVAL '30 days', NOW()
FROM "Roles" r WHERE r."RoleName" = 'CUSTOMER'
AND NOT EXISTS (SELECT 1 FROM "Users" WHERE "Username" = 'khach1');

INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "PhoneNumber", "Address", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'khach2@gmail.com', 'khach2', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'Trần Thị Bình', '0907654321', 'Quận 7, TP.HCM', TRUE, NOW() - INTERVAL '20 days', NOW()
FROM "Roles" r WHERE r."RoleName" = 'CUSTOMER'
AND NOT EXISTS (SELECT 1 FROM "Users" WHERE "Username" = 'khach2');

INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "PhoneNumber", "Address", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'khach3@gmail.com', 'khach3', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'Lê Hoàng Cường', '0912345678', 'Hà Nội', TRUE, NOW() - INTERVAL '10 days', NOW()
FROM "Roles" r WHERE r."RoleName" = 'CUSTOMER'
AND NOT EXISTS (SELECT 1 FROM "Users" WHERE "Username" = 'khach3');

-- ========== 4. TOURS (12 tours) ==========
-- Provider 1: 6 tours
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt")
SELECT p."ProviderId", 1,
'Tour Bà Nà Hills Trọn Gói',
'Khám phá Bà Nà Hills - Cầu Vàng nổi tiếng thế giới, công viên giải trí Fantasy Park',
'Tour Bà Nà Hills trọn gói bao gồm vé cáp treo, tham quan Cầu Vàng, làng Pháp, chùa Linh Ứng, vườn hoa Le Jardin D''Amour và công viên Fantasy Park. Bao gồm buffet trưa tại nhà hàng trên đỉnh núi.',
1500000, 30, '1 ngày', 'Xe du lịch + Cáp treo', 'Đà Nẵng', 'Bà Nà Hills',
'https://images.unsplash.com/photo-1570366583862-f91883984fde?w=800',
'08:00 Đón khách - 09:30 Cáp treo lên đỉnh - 10:00 Tham quan Cầu Vàng - 11:00 Làng Pháp - 12:00 Buffet trưa - 14:00 Fantasy Park - 16:30 Về khách sạn',
TRUE, NOW() - INTERVAL '60 days'
FROM "Providers" p
JOIN "Users" u ON p."ProviderId" = u."UserId"
WHERE u."Username" = 'provider1'
AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Bà Nà Hills Trọn Gói');

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt")
SELECT p."ProviderId", 1,
'Tour Ngũ Hành Sơn - Hội An',
'Tham quan Ngũ Hành Sơn và phố cổ Hội An với đèn lồng lung linh',
'Tour kết hợp tham quan Ngũ Hành Sơn (Marble Mountains) - danh thắng quốc gia và phố cổ Hội An - di sản văn hóa thế giới UNESCO. Trải nghiệm thả đèn hoa đăng trên sông Hoài.',
800000, 25, '1 ngày', 'Xe du lịch', 'Đà Nẵng', 'Hội An',
'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800',
'08:00 Đón khách - 09:00 Ngũ Hành Sơn - 11:30 Ăn trưa - 13:00 Phố cổ Hội An - 17:00 Thả đèn hoa đăng - 19:00 Về Đà Nẵng',
TRUE, NOW() - INTERVAL '55 days'
FROM "Providers" p
JOIN "Users" u ON p."ProviderId" = u."UserId"
WHERE u."Username" = 'provider1'
AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Ngũ Hành Sơn - Hội An');

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt")
SELECT p."ProviderId", 6,
'Tour Cù Lao Chàm Lặn Biển',
'Khám phá đảo Cù Lao Chàm - Khu dự trữ sinh quyển thế giới UNESCO',
'Tour lặn biển Cù Lao Chàm với san hô tuyệt đẹp. Bao gồm ca nô tốc hành, buffet hải sản, lặn biển ngắm san hô, tắm biển và tham quan làng chài.',
1200000, 20, '1 ngày', 'Ca nô tốc hành', 'Cửa Đại, Hội An', 'Cù Lao Chàm',
'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800',
'07:00 Đón khách - 08:00 Ca nô ra đảo - 09:30 Lặn biển ngắm san hô - 11:30 Buffet hải sản - 13:30 Tắm biển - 15:00 Tham quan làng chài - 16:30 Về đất liền',
TRUE, NOW() - INTERVAL '50 days'
FROM "Providers" p
JOIN "Users" u ON p."ProviderId" = u."UserId"
WHERE u."Username" = 'provider1'
AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Cù Lao Chàm Lặn Biển');

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt")
SELECT p."ProviderId", 3,
'Tour Đà Nẵng City Night',
'Khám phá vẻ đẹp Đà Nẵng về đêm - Cầu Rồng phun lửa',
'Tour Đà Nẵng về đêm: ngắm Cầu Rồng phun lửa phun nước cuối tuần, tham quan Cầu Tình Yêu, bờ sông Hàn lung linh, APEC Park, và thưởng thức ẩm thực đường phố.',
500000, 20, '4 giờ', 'Xe điện + Đi bộ', 'Cầu Rồng', 'Trung tâm Đà Nẵng',
'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800',
'18:00 Tập trung Cầu Rồng - 18:30 Cầu Tình Yêu - 19:00 Bờ sông Hàn - 20:00 APEC Park - 21:00 Cầu Rồng phun lửa - 21:30 Ẩm thực đường phố - 22:00 Kết thúc',
TRUE, NOW() - INTERVAL '45 days'
FROM "Providers" p
JOIN "Users" u ON p."ProviderId" = u."UserId"
WHERE u."Username" = 'provider1'
AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Đà Nẵng City Night');

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt")
SELECT p."ProviderId", 4,
'Tour Ẩm Thực Đà Nẵng',
'Khám phá 10 món ăn đặc sản Đà Nẵng nổi tiếng nhất',
'Tour ẩm thực trải nghiệm 10 món đặc sản: Mì Quảng, Bún mắm, Bánh tráng cuốn thịt heo, Bê thui Cầu Mống, Nem lụi, Chả bò, Bánh xèo, Hải sản tươi sống, Chè bắp, Kem Bạch Đằng.',
650000, 15, '5 giờ', 'Xe máy / Xích lô', 'Chợ Hàn', 'Đà Nẵng',
'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
'09:00 Chợ Hàn - 09:30 Mì Quảng Bà Vị - 10:15 Bún mắm Bà Dũ - 11:00 Bánh tráng cuốn thịt heo - 12:00 Bê thui Cầu Mống - 14:00 Nem lụi & Chả bò - 15:00 Kem Bạch Đằng',
TRUE, NOW() - INTERVAL '40 days'
FROM "Providers" p
JOIN "Users" u ON p."ProviderId" = u."UserId"
WHERE u."Username" = 'provider1'
AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Ẩm Thực Đà Nẵng');

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt")
SELECT p."ProviderId", 5,
'Tour Sơn Trà Bán Đảo',
'Khám phá bán đảo Sơn Trà - lá phổi xanh của Đà Nẵng',
'Tour sinh thái bán đảo Sơn Trà: ngắm voọc chà vá chân nâu, tham quan chùa Linh Ứng - tượng Phật Quan Âm cao 67m, bãi biển hoang sơ, ngắm bình minh/hoàng hôn tuyệt đẹp.',
700000, 15, '6 giờ', 'Xe Jeep', 'Đà Nẵng', 'Bán đảo Sơn Trà',
'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
'05:00 Đón khách (tour sáng) - 05:30 Ngắm bình minh đỉnh Sơn Trà - 07:00 Chùa Linh Ứng - 08:30 Tìm voọc chà vá - 10:00 Bãi biển Bãi Bụt - 11:00 Về khách sạn',
TRUE, NOW() - INTERVAL '35 days'
FROM "Providers" p
JOIN "Users" u ON p."ProviderId" = u."UserId"
WHERE u."Username" = 'provider1'
AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Sơn Trà Bán Đảo');

-- Provider 2: 6 tours
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt")
SELECT p."ProviderId", 2,
'Tour Mạo Hiểm Hải Vân Đèo',
'Đèo Hải Vân bằng Jeep - cung đường biển đẹp nhất Việt Nam',
'Tour mạo hiểm đèo Hải Vân bằng xe Jeep. Trải nghiệm cung đường đèo dốc ngoạn mục được CNN bình chọn đẹp nhất Việt Nam. Dừng chân tại đỉnh đèo ngắm toàn cảnh Đà Nẵng - Lăng Cô.',
900000, 8, '5 giờ', 'Xe Jeep', 'Đà Nẵng', 'Đèo Hải Vân',
'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800',
'07:00 Đón khách - 08:00 Bắt đầu lên đèo - 09:30 Đỉnh đèo Hải Vân - 10:30 Lăng Cô - 11:30 Ăn trưa hải sản - 13:00 Quay về Đà Nẵng',
TRUE, NOW() - INTERVAL '30 days'
FROM "Providers" p
JOIN "Users" u ON p."ProviderId" = u."UserId"
WHERE u."Username" = 'provider2'
AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Mạo Hiểm Hải Vân Đèo');

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt")
SELECT p."ProviderId", 1,
'Tour Huế Cố Đô 1 Ngày',
'Tham quan Đại Nội Huế - Di sản văn hóa thế giới UNESCO',
'Tour Huế trọn gói: Đại Nội, Lăng Tự Đức, Lăng Khải Định, Chùa Thiên Mụ, sông Hương. Thưởng thức bún bò Huế chính gốc và bánh bèo lọc Huế.',
1100000, 25, '1 ngày', 'Xe du lịch', 'Đà Nẵng', 'Huế',
'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800',
'06:00 Đón khách - 08:30 Đại Nội Huế - 10:30 Lăng Khải Định - 11:30 Bún bò Huế - 13:00 Lăng Tự Đức - 14:30 Chùa Thiên Mụ - 15:30 Sông Hương - 18:00 Về Đà Nẵng',
TRUE, NOW() - INTERVAL '25 days'
FROM "Providers" p
JOIN "Users" u ON p."ProviderId" = u."UserId"
WHERE u."Username" = 'provider2'
AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Huế Cố Đô 1 Ngày');

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt")
SELECT p."ProviderId", 2,
'Tour Kayak Sông Thu Bồn',
'Chèo kayak trên sông Thu Bồn - trải nghiệm sông nước miền Trung',
'Tour kayak sông Thu Bồn đoạn Hội An. Chèo kayak qua làng rau Trà Quế, bãi bồi sông Thu Bồn, ngắm cảnh đồng quê yên bình. Thích hợp cho mọi lứa tuổi.',
450000, 12, '3 giờ', 'Kayak', 'Hội An', 'Sông Thu Bồn',
'https://images.unsplash.com/photo-1472745942893-4b9f730c7668?w=800',
'07:00 Tập trung tại Hội An - 07:30 Hướng dẫn an toàn - 08:00 Bắt đầu chèo - 09:00 Làng rau Trà Quế - 10:00 Bãi bồi - 10:30 Về điểm xuất phát',
TRUE, NOW() - INTERVAL '20 days'
FROM "Providers" p
JOIN "Users" u ON p."ProviderId" = u."UserId"
WHERE u."Username" = 'provider2'
AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Kayak Sông Thu Bồn');

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt")
SELECT p."ProviderId", 6,
'Tour Biển Mỹ Khê Sunrise',
'Trải nghiệm bình minh tuyệt đẹp tại bãi biển Mỹ Khê',
'Tour bình minh bãi biển Mỹ Khê - Top 6 bãi biển quyến rũ nhất hành tinh (Forbes). Tập yoga, bơi lội, lướt sóng, ăn sáng hải sản ngay bờ biển.',
350000, 20, '3 giờ', 'Đi bộ', 'Biển Mỹ Khê', 'Đà Nẵng',
'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
'05:00 Tập trung bãi biển - 05:15 Yoga bình minh - 06:00 Bơi lội tự do - 06:30 Lướt sóng (tùy chọn) - 07:30 Ăn sáng hải sản - 08:00 Kết thúc',
TRUE, NOW() - INTERVAL '15 days'
FROM "Providers" p
JOIN "Users" u ON p."ProviderId" = u."UserId"
WHERE u."Username" = 'provider2'
AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Biển Mỹ Khê Sunrise');

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt")
SELECT p."ProviderId", 3,
'Tour Làng Đá Mỹ Nghệ Non Nước',
'Tham quan làng nghề chạm khắc đá truyền thống 400 năm',
'Tour tham quan và trải nghiệm làng đá mỹ nghệ Non Nước - làng nghề truyền thống hơn 400 năm tuổi. Tự tay chạm khắc đá dưới hướng dẫn của nghệ nhân.',
400000, 15, '3 giờ', 'Xe điện', 'Ngũ Hành Sơn', 'Làng đá Non Nước',
'https://images.unsplash.com/photo-1590674899484-d5640e854abe?w=800',
'08:00 Đón khách - 08:30 Giới thiệu lịch sử làng nghề - 09:00 Tham quan xưởng đá - 10:00 Trải nghiệm chạm khắc - 11:00 Mua sắm - 11:30 Kết thúc',
TRUE, NOW() - INTERVAL '10 days'
FROM "Providers" p
JOIN "Users" u ON p."ProviderId" = u."UserId"
WHERE u."Username" = 'provider2'
AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Làng Đá Mỹ Nghệ Non Nước');

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt")
SELECT p."ProviderId", 5,
'Tour Suối Hoa Lư Eco',
'Trải nghiệm suối khoáng nóng và thiên nhiên hoang sơ',
'Tour sinh thái suối Hoa Lư: tắm suối khoáng nóng tự nhiên, đi bộ rừng nguyên sinh, ngắm thác nước, picnic giữa thiên nhiên hoang sơ cách Đà Nẵng 30km.',
550000, 15, '1 ngày', 'Xe du lịch', 'Đà Nẵng', 'Hòa Vang',
'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800',
'07:30 Đón khách - 08:30 Đến suối Hoa Lư - 09:00 Đi bộ rừng - 10:30 Ngắm thác - 11:30 Picnic trưa - 13:00 Tắm suối khoáng nóng - 15:00 Về Đà Nẵng',
TRUE, NOW() - INTERVAL '5 days'
FROM "Providers" p
JOIN "Users" u ON p."ProviderId" = u."UserId"
WHERE u."Username" = 'provider2'
AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Suối Hoa Lư Eco');

-- ========== 5. SAMPLE ORDERS & BOOKINGS ==========
-- Khách 1: 3 đơn hàng
DO $$
DECLARE
    v_customer_id INT;
    v_tour1_id INT;
    v_tour2_id INT;
    v_tour3_id INT;
    v_order_id INT;
BEGIN
    SELECT "UserId" INTO v_customer_id FROM "Users" WHERE "Username" = 'khach1';
    SELECT "TourId" INTO v_tour1_id FROM "Tours" WHERE "TourName" = 'Tour Bà Nà Hills Trọn Gói' LIMIT 1;
    SELECT "TourId" INTO v_tour2_id FROM "Tours" WHERE "TourName" = 'Tour Cù Lao Chàm Lặn Biển' LIMIT 1;
    SELECT "TourId" INTO v_tour3_id FROM "Tours" WHERE "TourName" = 'Tour Ẩm Thực Đà Nẵng' LIMIT 1;

    IF v_customer_id IS NOT NULL AND v_tour1_id IS NOT NULL 
       AND NOT EXISTS (SELECT 1 FROM "Orders" WHERE "CustomerId" = v_customer_id) THEN
        
        -- Order 1: Completed
        INSERT INTO "Orders" ("CustomerId", "TotalAmount", "OrderStatus", "PaymentStatus", "OrderDate", "UpdatedAt")
        VALUES (v_customer_id, 4500000, 'Completed', 'Paid', NOW() - INTERVAL '25 days', NOW() - INTERVAL '20 days')
        RETURNING "OrderId" INTO v_order_id;
        
        INSERT INTO "Bookings" ("OrderId", "TourId", "BookingDate", "Quantity", "SubTotal", "BookingStatus")
        VALUES (v_order_id, v_tour1_id, NOW() - INTERVAL '25 days', 3, 4500000, 'Completed');

        -- Order 2: Confirmed
        INSERT INTO "Orders" ("CustomerId", "TotalAmount", "OrderStatus", "PaymentStatus", "OrderDate", "UpdatedAt")
        VALUES (v_customer_id, 2400000, 'Confirmed', 'Paid', NOW() - INTERVAL '5 days', NOW() - INTERVAL '3 days')
        RETURNING "OrderId" INTO v_order_id;
        
        IF v_tour2_id IS NOT NULL THEN
            INSERT INTO "Bookings" ("OrderId", "TourId", "BookingDate", "Quantity", "SubTotal", "BookingStatus")
            VALUES (v_order_id, v_tour2_id, NOW() - INTERVAL '5 days', 2, 2400000, 'Confirmed');
        END IF;

        -- Order 3: Pending
        INSERT INTO "Orders" ("CustomerId", "TotalAmount", "OrderStatus", "PaymentStatus", "OrderDate", "UpdatedAt")
        VALUES (v_customer_id, 1300000, 'Pending', 'Unpaid', NOW() - INTERVAL '1 day', NOW())
        RETURNING "OrderId" INTO v_order_id;
        
        IF v_tour3_id IS NOT NULL THEN
            INSERT INTO "Bookings" ("OrderId", "TourId", "BookingDate", "Quantity", "SubTotal", "BookingStatus")
            VALUES (v_order_id, v_tour3_id, NOW() - INTERVAL '1 day', 2, 1300000, 'Pending');
        END IF;
    END IF;
END $$;

-- Khách 2: 2 đơn hàng
DO $$
DECLARE
    v_customer_id INT;
    v_tour1_id INT;
    v_tour2_id INT;
    v_order_id INT;
BEGIN
    SELECT "UserId" INTO v_customer_id FROM "Users" WHERE "Username" = 'khach2';
    SELECT "TourId" INTO v_tour1_id FROM "Tours" WHERE "TourName" = 'Tour Huế Cố Đô 1 Ngày' LIMIT 1;
    SELECT "TourId" INTO v_tour2_id FROM "Tours" WHERE "TourName" = 'Tour Đà Nẵng City Night' LIMIT 1;

    IF v_customer_id IS NOT NULL AND v_tour1_id IS NOT NULL 
       AND NOT EXISTS (SELECT 1 FROM "Orders" WHERE "CustomerId" = v_customer_id) THEN
        
        -- Order 1: Completed
        INSERT INTO "Orders" ("CustomerId", "TotalAmount", "OrderStatus", "PaymentStatus", "OrderDate", "UpdatedAt")
        VALUES (v_customer_id, 2200000, 'Completed', 'Paid', NOW() - INTERVAL '15 days', NOW() - INTERVAL '10 days')
        RETURNING "OrderId" INTO v_order_id;
        
        INSERT INTO "Bookings" ("OrderId", "TourId", "BookingDate", "Quantity", "SubTotal", "BookingStatus")
        VALUES (v_order_id, v_tour1_id, NOW() - INTERVAL '15 days', 2, 2200000, 'Completed');

        -- Order 2: Cancelled
        INSERT INTO "Orders" ("CustomerId", "TotalAmount", "OrderStatus", "PaymentStatus", "CancelReason", "OrderDate", "UpdatedAt")
        VALUES (v_customer_id, 1000000, 'Cancelled', 'Refunded', 'Thay đổi kế hoạch', NOW() - INTERVAL '8 days', NOW() - INTERVAL '7 days')
        RETURNING "OrderId" INTO v_order_id;
        
        IF v_tour2_id IS NOT NULL THEN
            INSERT INTO "Bookings" ("OrderId", "TourId", "BookingDate", "Quantity", "SubTotal", "BookingStatus")
            VALUES (v_order_id, v_tour2_id, NOW() - INTERVAL '8 days', 2, 1000000, 'Cancelled');
        END IF;
    END IF;
END $$;

-- Khách 3: 1 đơn hàng
DO $$
DECLARE
    v_customer_id INT;
    v_tour_id INT;
    v_order_id INT;
BEGIN
    SELECT "UserId" INTO v_customer_id FROM "Users" WHERE "Username" = 'khach3';
    SELECT "TourId" INTO v_tour_id FROM "Tours" WHERE "TourName" = 'Tour Mạo Hiểm Hải Vân Đèo' LIMIT 1;

    IF v_customer_id IS NOT NULL AND v_tour_id IS NOT NULL 
       AND NOT EXISTS (SELECT 1 FROM "Orders" WHERE "CustomerId" = v_customer_id) THEN
        
        INSERT INTO "Orders" ("CustomerId", "TotalAmount", "OrderStatus", "PaymentStatus", "OrderDate", "UpdatedAt")
        VALUES (v_customer_id, 3600000, 'Confirmed', 'Paid', NOW() - INTERVAL '3 days', NOW() - INTERVAL '2 days')
        RETURNING "OrderId" INTO v_order_id;
        
        INSERT INTO "Bookings" ("OrderId", "TourId", "BookingDate", "Quantity", "SubTotal", "BookingStatus")
        VALUES (v_order_id, v_tour_id, NOW() - INTERVAL '3 days', 4, 3600000, 'Confirmed');
    END IF;
END $$;

-- ========== 6. MONTHLY REVENUE ==========
INSERT INTO "MonthlyRevenue" ("ReportMonth", "ReportYear", "TotalBookings", "GrossVolume", "PlatformFee", "CreatedAt")
SELECT m, 2026, 
       (m * 3 + 5),
       (m * 2500000 + 5000000),
       (m * 250000 + 500000),
       NOW()
FROM generate_series(1, 3) AS m
WHERE NOT EXISTS (SELECT 1 FROM "MonthlyRevenue" WHERE "ReportYear" = 2026 AND "ReportMonth" = m);

-- ========== 7. VERIFY DATA ==========
SELECT 'Roles' AS "Table", COUNT(*) AS "Count" FROM "Roles"
UNION ALL
SELECT 'Users', COUNT(*) FROM "Users"
UNION ALL
SELECT 'Providers', COUNT(*) FROM "Providers"
UNION ALL
SELECT 'Categories', COUNT(*) FROM "Categories"
UNION ALL
SELECT 'Tours', COUNT(*) FROM "Tours"
UNION ALL
SELECT 'Orders', COUNT(*) FROM "Orders"
UNION ALL
SELECT 'Bookings', COUNT(*) FROM "Bookings"
UNION ALL
SELECT 'SubscriptionPlans', COUNT(*) FROM "SubscriptionPlans"
UNION ALL
SELECT 'MonthlyRevenue', COUNT(*) FROM "MonthlyRevenue"
ORDER BY "Table";

-- =============================================
-- EZTRAVEL - SEED DATA: PROVIDERS & TOURS
-- Copy toàn bộ script này vào Supabase SQL Editor → Run
-- =============================================

-- ======================
-- 1. TẠO PROVIDER ACCOUNTS (skip nếu đã tồn tại)
-- ======================

-- Provider 1
INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "PhoneNumber", "Address", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'provider1@eztravel.vn', 'eztravel_official', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'EZTravel Official', '0905123456', '123 Bạch Đằng, Hải Châu, Đà Nẵng', TRUE, NOW(), NOW()
FROM "Roles" r WHERE r."RoleName" = 'PROVIDER'
ON CONFLICT ("Email") DO NOTHING;

-- Provider 2
INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "PhoneNumber", "Address", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'provider2@eztravel.vn', 'danang_tourism', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'DaNang Tourism Co.', '0911222333', '45 Nguyễn Văn Linh, Đà Nẵng', TRUE, NOW(), NOW()
FROM "Roles" r WHERE r."RoleName" = 'PROVIDER'
ON CONFLICT ("Email") DO NOTHING;

-- Provider 3
INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "PhoneNumber", "Address", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'provider3@eztravel.vn', 'vn_explorer', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'Vietnam Explorer', '0933444555', '78 Trần Phú, Hải Châu, Đà Nẵng', TRUE, NOW(), NOW()
FROM "Roles" r WHERE r."RoleName" = 'PROVIDER'
ON CONFLICT ("Email") DO NOTHING;

-- Providers table (skip nếu đã tồn tại)
INSERT INTO "Providers" ("ProviderId", "BusinessName", "BusinessLicense", "ProviderType", "Rating", "IsVerified", "TotalTours", "IsActive")
SELECT u."UserId", 'EZTravel Official', 'BL-2024-001', 'Premium', 4.9, TRUE, 0, TRUE
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn'
ON CONFLICT ("ProviderId") DO NOTHING;

INSERT INTO "Providers" ("ProviderId", "BusinessName", "BusinessLicense", "ProviderType", "Rating", "IsVerified", "TotalTours", "IsActive")
SELECT u."UserId", 'DaNang Tourism Co.', 'BL-2024-002', 'Standard', 4.7, TRUE, 0, TRUE
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn'
ON CONFLICT ("ProviderId") DO NOTHING;

INSERT INTO "Providers" ("ProviderId", "BusinessName", "BusinessLicense", "ProviderType", "Rating", "IsVerified", "TotalTours", "IsActive")
SELECT u."UserId", 'Vietnam Explorer', 'BL-2024-003', 'Premium', 4.8, TRUE, 0, TRUE
FROM "Users" u WHERE u."Email" = 'provider3@eztravel.vn'
ON CONFLICT ("ProviderId") DO NOTHING;

-- ======================
-- 2. TẠO CUSTOMER ACCOUNTS
-- ======================
INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "PhoneNumber", "Address", "DateOfBirth", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'customer1@gmail.com', 'nguyenvana', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'Nguyễn Văn A', '0901111222', '10 Lê Lợi, Quận 1, TP.HCM', '1995-05-15', TRUE, NOW(), NOW()
FROM "Roles" r WHERE r."RoleName" = 'CUSTOMER'
ON CONFLICT ("Email") DO NOTHING;

INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "PhoneNumber", "Address", "DateOfBirth", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'customer2@gmail.com', 'tranthib', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'Trần Thị B', '0912333444', '20 Hai Bà Trưng, Hà Nội', '1998-08-20', TRUE, NOW(), NOW()
FROM "Roles" r WHERE r."RoleName" = 'CUSTOMER'
ON CONFLICT ("Email") DO NOTHING;

INSERT INTO "Customers" ("CustomerId", "Address", "DateOfBirth", "Status")
SELECT u."UserId", u."Address", u."DateOfBirth", 'active'
FROM "Users" u WHERE u."Email" = 'customer1@gmail.com'
ON CONFLICT ("CustomerId") DO NOTHING;

INSERT INTO "Customers" ("CustomerId", "Address", "DateOfBirth", "Status")
SELECT u."UserId", u."Address", u."DateOfBirth", 'active'
FROM "Users" u WHERE u."Email" = 'customer2@gmail.com'
ON CONFLICT ("CustomerId") DO NOTHING;

-- ======================
-- 3. XÓA TOURS CŨ (nếu muốn reset) rồi thêm mới
-- ======================
DELETE FROM "Tours" WHERE "TourName" IN (
    'Bà Nà Hills - Cầu Vàng Trọn Gói',
    'Hội An Phố Cổ - Đêm Hoa Đăng',
    'Cù Lao Chàm - Lặn Biển San Hô',
    'Bán Đảo Sơn Trà - Ngắm Voọc Chà Vá',
    'Ngũ Hành Sơn - Khám Phá Hang Động',
    'Tour Ẩm Thực Đường Phố Đà Nẵng',
    'Zipline & Kayak Sông Cu Đê',
    'Đà Nẵng By Night - Cầu Rồng Phun Lửa',
    'Huế Cố Đô - Đại Nội & Lăng Tẩm',
    'Mỹ Khê Sunrise - SUP & Yoga Biển',
    'Sun World Asia Park - Vé Trọn Gói',
    'Combo Đà Nẵng - Hội An 2N1Đ'
);

-- ======================
-- 4. THÊM 12 TOURS ĐA DẠNG
-- ======================

-- TOUR 1: Bà Nà Hills - Cầu Vàng (Cat 1: Tour Tham Quan)
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 1,
    'Bà Nà Hills - Cầu Vàng Trọn Gói',
    'Khám phá Bà Nà Hills với cáp treo dài nhất thế giới, check-in Cầu Vàng nổi tiếng và thưởng thức Làng Pháp cổ kính.',
    'Tour Bà Nà Hills trọn gói bao gồm vé cáp treo, vé vào cổng Fantasy Park, tham quan Làng Pháp, chùa Linh Ứng trên đỉnh, check-in Cầu Vàng mang tính biểu tượng. Bao gồm bữa trưa buffet tại nhà hàng trên đỉnh núi với hơn 100 món ẩm thực Á-Âu.',
    1250000, 30, '1 ngày', 'Xe du lịch 16 chỗ', 'Đà Nẵng', 'Bà Nà Hills',
    'https://images.unsplash.com/photo-1570366583862-f91883984fde?auto=format&fit=crop&w=800&q=80',
    'Sáng: Đón khách → Cáp treo → Chùa Linh Ứng → Cầu Vàng. Trưa: Buffet Làng Pháp. Chiều: Fantasy Park → Về.',
    TRUE, NOW() - INTERVAL '10 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

-- TOUR 2: Hội An Phố Cổ (Cat 3: Tour Văn Hóa)
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 3,
    'Hội An Phố Cổ - Đêm Hoa Đăng',
    'Dạo phố cổ Hội An lung linh đèn lồng, thả hoa đăng trên sông Hoài và thưởng thức ẩm thực đường phố.',
    'Tour Hội An trọn gói đưa bạn đến phố cổ UNESCO với kiến trúc cổ kính, đèn lồng rực rỡ. Bao gồm vé tham quan 5 điểm di tích, thả hoa đăng trên sông Hoài lúc hoàng hôn, trải nghiệm may áo dài tại xưởng truyền thống.',
    650000, 25, '1 ngày', 'Xe du lịch 29 chỗ', 'Đà Nẵng', 'Hội An',
    'https://images.unsplash.com/photo-1555921015-5532091f6026?auto=format&fit=crop&w=800&q=80',
    'Sáng: Đến Hội An → Chùa Cầu, Nhà cổ Tấn Ký, Hội quán Phúc Kiến. Chiều: Làng nghề. Tối: Hoa đăng sông Hoài → Về.',
    TRUE, NOW() - INTERVAL '8 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

-- TOUR 3: Cù Lao Chàm (Cat 6: Tour Biển Đảo)
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 6,
    'Cù Lao Chàm - Lặn Biển San Hô',
    'Khám phá đảo Cù Lao Chàm với lặn ngắm san hô, tắm biển hoang sơ và thưởng thức hải sản tươi sống.',
    'Tour Cù Lao Chàm 1 ngày bao gồm cano tốc độ cao, lặn biển ngắm rạn san hô với hướng dẫn viên chuyên nghiệp, tắm biển tại Bãi Ông, thưởng thức bữa trưa hải sản tươi sống trên đảo.',
    850000, 20, '1 ngày', 'Cano cao tốc', 'Cửa Đại, Hội An', 'Cù Lao Chàm',
    'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80',
    'Sáng: Cano ra đảo → Lặn san hô → Tắm biển. Trưa: Hải sản trên đảo. Chiều: Làng chài → Về.',
    TRUE, NOW() - INTERVAL '5 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn';

-- TOUR 4: Sơn Trà (Cat 5: Tour Sinh Thái)
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 5,
    'Bán Đảo Sơn Trà - Ngắm Voọc Chà Vá',
    'Trekking bán đảo Sơn Trà, ngắm voọc chà vá chân nâu quý hiếm và ngắm hoàng hôn tuyệt đẹp.',
    'Tour sinh thái Sơn Trà cho bạn trải nghiệm trekking qua rừng nguyên sinh, ngắm đàn voọc chà vá chân nâu, ghé thăm Chùa Linh Ứng với tượng Phật Bà cao 67m, và ngắm toàn cảnh thành phố từ đỉnh Bàn Cờ.',
    480000, 15, 'Nửa ngày', 'Xe jeep', 'Đà Nẵng', 'Bán đảo Sơn Trà',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=800&q=80',
    'Sáng sớm: Đỉnh Bàn Cờ ngắm bình minh → Trekking tìm voọc → Chùa Linh Ứng → Bãi biển Tiên Sa → Về.',
    TRUE, NOW() - INTERVAL '3 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn';

-- TOUR 5: Ngũ Hành Sơn (Cat 1: Tour Tham Quan)
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 1,
    'Ngũ Hành Sơn - Khám Phá Hang Động',
    'Tham quan Ngũ Hành Sơn với hệ thống hang động kỳ bí, chùa cổ và làng đá mỹ nghệ Non Nước.',
    'Tour Ngũ Hành Sơn đưa bạn khám phá 5 ngọn núi đá vôi linh thiêng. Tham quan hang Huyền Không, Âm Phủ, Vân Thông. Ghé thăm Chùa Tam Thai và làng đá mỹ nghệ Non Nước.',
    350000, 25, 'Nửa ngày', 'Xe du lịch', 'Đà Nẵng', 'Ngũ Hành Sơn',
    'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=800&q=80',
    'Sáng: Leo Thủy Sơn → Hang Huyền Không → Chùa Tam Thai → Hang Âm Phủ → Làng đá Non Nước → Về.',
    TRUE, NOW() - INTERVAL '7 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider3@eztravel.vn';

-- TOUR 6: Ẩm Thực (Cat 4: Tour Ẩm Thực)
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 4,
    'Tour Ẩm Thực Đường Phố Đà Nẵng',
    'Khám phá tinh hoa ẩm thực Đà Nẵng với mì Quảng, bánh tráng cuốn thịt heo, bún chả cá và nhiều hơn nữa.',
    'Tour food walk qua 8 quán ăn nổi tiếng: Mì Quảng Bà Mua, Bánh Tráng Cuốn Thịt Heo, Bún Chả Cá 109, Bánh Xèo Bà Dưỡng, Kem Bơ Thanh Long... với hướng dẫn viên am hiểu ẩm thực.',
    420000, 12, 'Nửa ngày', 'Xe đạp / Đi bộ', 'Đà Nẵng', 'Đà Nẵng',
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80',
    'Sáng: Mì Quảng Bà Mua → Bánh Tráng Cuốn → Chợ Hàn → Bún Chả Cá. Chiều: Bánh Xèo → Kem Bơ → Cafe sông Hàn.',
    TRUE, NOW() - INTERVAL '2 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

-- TOUR 7: Mạo Hiểm (Cat 2: Tour Mạo Hiểm)
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 2,
    'Zipline & Kayak Sông Cu Đê',
    'Trải nghiệm mạo hiểm với đu dây zipline qua thung lũng, chèo kayak trên sông Cu Đê và cắm trại giữa thiên nhiên.',
    'Tour mạo hiểm: đu dây zipline 400m, chèo kayak sông Cu Đê, leo vách đá, cắm trại BBQ. Hướng dẫn viên chuyên nghiệp, trang bị an toàn đầy đủ.',
    950000, 15, '1 ngày', 'Xe bán tải off-road', 'Đà Nẵng', 'Hòa Vang, Đà Nẵng',
    'https://images.unsplash.com/photo-1551632811-561732d1e306?auto=format&fit=crop&w=800&q=80',
    'Sáng: Zipline 400m → Nghỉ giải lao. Trưa: BBQ bên suối. Chiều: Kayak sông Cu Đê → Leo vách đá → Tắm suối → Về.',
    TRUE, NOW() - INTERVAL '4 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider3@eztravel.vn';

-- TOUR 8: Đà Nẵng By Night (Cat 1: Tour Tham Quan)
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 1,
    'Đà Nẵng By Night - Cầu Rồng Phun Lửa',
    'Tour đêm Đà Nẵng ngắm Cầu Rồng phun lửa, du thuyền sông Hàn và thưởng thức ẩm thực đêm.',
    'Tour đêm: ngắm Cầu Rồng phun lửa & phun nước (T7, CN), du thuyền sông Hàn ngắm 7 cây cầu lung linh, APEC Park, hải sản chợ đêm Sơn Trà.',
    550000, 20, 'Buổi tối', 'Xe du lịch + Du thuyền', 'Đà Nẵng', 'Đà Nẵng',
    'https://images.unsplash.com/photo-1563911302283-d2bc129e7570?auto=format&fit=crop&w=800&q=80',
    'Tối: Cầu Tình Yêu → Du thuyền sông Hàn → Cầu Rồng phun lửa → Chợ đêm Sơn Trà → Hải sản → Về.',
    TRUE, NOW() - INTERVAL '1 day', NOW()
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn';

-- TOUR 9: Huế Cố Đô (Cat 3: Tour Văn Hóa)
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 3,
    'Huế Cố Đô - Đại Nội & Lăng Tẩm',
    'Tour 1 ngày khám phá kinh thành Huế, Đại Nội, lăng Khải Định, lăng Tự Đức và thưởng thức bún bò Huế chính gốc.',
    'Tour Huế trọn gói từ Đà Nẵng, đi qua đèo Hải Vân huyền thoại. Tham quan Đại Nội, lăng Khải Định, lăng Tự Đức. Bún bò Huế, bánh bèo, bánh nậm chính gốc.',
    890000, 25, '1 ngày', 'Xe du lịch 29 chỗ', 'Đà Nẵng', 'Huế',
    'https://images.unsplash.com/photo-1583417319070-4a69db38a482?auto=format&fit=crop&w=800&q=80',
    'Sáng: Đèo Hải Vân → Đại Nội → Lăng Khải Định. Trưa: Bún bò Huế. Chiều: Lăng Tự Đức → Chùa Thiên Mụ → Về.',
    TRUE, NOW() - INTERVAL '6 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

-- TOUR 10: Mỹ Khê (Cat 6: Tour Biển Đảo)
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 6,
    'Mỹ Khê Sunrise - SUP & Yoga Biển',
    'Trải nghiệm yoga bình minh trên bãi biển Mỹ Khê, chèo SUP (Stand Up Paddle) và tắm biển thư giãn.',
    'Tour wellness: yoga bình minh, chèo SUP trên biển yên bình, tắm biển và bữa sáng healthy bên bờ biển.',
    380000, 10, 'Buổi sáng', 'Tự túc / Xe đạp', 'Mỹ Khê, Đà Nẵng', 'Biển Mỹ Khê',
    'https://images.unsplash.com/photo-1506929562872-bb421503ef21?auto=format&fit=crop&w=800&q=80',
    'Sáng sớm: Yoga bình minh → Hướng dẫn SUP → Chèo SUP 1 tiếng → Tắm biển → Bữa sáng healthy → Xong.',
    TRUE, NOW() - INTERVAL '1 day', NOW()
FROM "Users" u WHERE u."Email" = 'provider3@eztravel.vn';

-- TOUR 11: Asia Park (Cat 1: Tour Tham Quan)
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 1,
    'Sun World Asia Park - Vé Trọn Gói',
    'Vui chơi thỏa thích tại Sun World Asia Park với vòng quay Sun Wheel, monorail và hàng chục trò chơi cảm giác mạnh.',
    'Tour Asia Park trọn gói: vé vào cổng, tất cả trò chơi, Sun Wheel cao 115m, tàu monorail, khu Dragon. Show nhạc nước buổi tối.',
    600000, 30, 'Buổi chiều - tối', 'Tự túc', 'Đà Nẵng', 'Asia Park, Đà Nẵng',
    'https://images.unsplash.com/photo-1513407030348-c983a97b98d8?auto=format&fit=crop&w=800&q=80',
    'Chiều: Tự do vui chơi → Sun Wheel → Monorail. Tối: Show nhạc nước → Ẩm thực → Kết thúc.',
    TRUE, NOW() - INTERVAL '9 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn';

-- TOUR 12: Combo 2N1Đ (Cat 1: Tour Tham Quan)
INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 1,
    'Combo Đà Nẵng - Hội An 2N1Đ',
    'Combo tour 2 ngày 1 đêm khám phá trọn vẹn Đà Nẵng và Hội An, bao gồm khách sạn 4 sao.',
    'Package 2N1Đ hoàn hảo: Ngày 1 Đà Nẵng (Ngũ Hành Sơn, Mỹ Khê). Ngày 2 Hội An phố cổ. Bao gồm KS 4 sao, 2 bữa trưa, 1 bữa tối, xe đưa đón, HDV song ngữ.',
    2450000, 20, '2 ngày 1 đêm', 'Xe du lịch 16 chỗ', 'Đà Nẵng', 'Đà Nẵng - Hội An',
    'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=800&q=80',
    'Ngày 1: Sân bay → Ngũ Hành Sơn → Mỹ Khê → Asia Park → Cầu Rồng → KS. Ngày 2: Bà Nà → Hội An → Hoa đăng → Về.',
    TRUE, NOW() - INTERVAL '12 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

-- ======================
-- 5. CẬP NHẬT SỐ LƯỢNG TOUR
-- ======================
UPDATE "Providers" SET "TotalTours" = (
    SELECT COUNT(*) FROM "Tours" t WHERE t."ProviderId" = "Providers"."ProviderId" AND t."IsActive" = TRUE
);

SELECT '✅ Done! ' || COUNT(*) || ' tours in database.' AS result FROM "Tours" WHERE "IsActive" = TRUE;

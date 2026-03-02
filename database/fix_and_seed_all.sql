-- =============================================
-- EZTRAVEL - FIX ALL + FULL SAMPLE DATA
-- Chạy 1 lần duy nhất trong Supabase SQL Editor
-- =============================================

-- ===== STEP 1: Fix thiếu cột trong Providers =====
ALTER TABLE "Providers" ADD COLUMN IF NOT EXISTS "JoinDate" DATE DEFAULT CURRENT_DATE;
ALTER TABLE "Providers" ADD COLUMN IF NOT EXISTS "Status" VARCHAR(20) DEFAULT 'Active';
ALTER TABLE "Providers" ADD COLUMN IF NOT EXISTS "Description" TEXT;
ALTER TABLE "Providers" ADD COLUMN IF NOT EXISTS "CreatedAt" TIMESTAMP DEFAULT NOW();
ALTER TABLE "Providers" ADD COLUMN IF NOT EXISTS "UpdatedAt" TIMESTAMP DEFAULT NOW();

-- Update existing providers
UPDATE "Providers" SET 
    "JoinDate" = COALESCE("JoinDate", CURRENT_DATE),
    "Status" = COALESCE("Status", 'Active'),
    "CreatedAt" = COALESCE("CreatedAt", NOW()),
    "UpdatedAt" = COALESCE("UpdatedAt", NOW());

-- ===== STEP 2: Roles & Admin (skip nếu đã có) =====
INSERT INTO "Roles" ("RoleName") VALUES ('ADMIN')    ON CONFLICT ("RoleName") DO NOTHING;
INSERT INTO "Roles" ("RoleName") VALUES ('PROVIDER') ON CONFLICT ("RoleName") DO NOTHING;
INSERT INTO "Roles" ("RoleName") VALUES ('CUSTOMER') ON CONFLICT ("RoleName") DO NOTHING;

INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'admin@dananghub.com', 'admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'System Admin', TRUE, NOW(), NOW()
FROM "Roles" r WHERE r."RoleName" = 'ADMIN'
AND NOT EXISTS (SELECT 1 FROM "Users" WHERE "Username" = 'admin');

-- ===== STEP 3: Categories =====
INSERT INTO "Categories" ("CategoryName", "Description") VALUES
('Tour Tham Quan', 'Tour tham quan các điểm du lịch nổi tiếng'),
('Tour Mạo Hiểm', 'Tour trải nghiệm mạo hiểm và thể thao'),
('Tour Văn Hóa', 'Tour tìm hiểu văn hóa và lịch sử'),
('Tour Ẩm Thực', 'Tour khám phá ẩm thực địa phương'),
('Tour Sinh Thái', 'Tour du lịch sinh thái và thiên nhiên'),
('Tour Biển Đảo', 'Tour du lịch biển và đảo')
ON CONFLICT DO NOTHING;

-- ===== STEP 4: Subscription Plans =====
INSERT INTO "SubscriptionPlans" ("PlanName", "PlanCode", "Price", "DurationDays", "Description", "Features", "IsActive") VALUES
('Basic', 'BASIC', 0, 30, 'Gói miễn phí cơ bản', 'Đăng 5 tour, Hiển thị cơ bản', TRUE),
('Premium', 'PREMIUM', 299000, 30, 'Gói nâng cao', 'Đăng 20 tour, Ưu tiên hiển thị, Báo cáo', TRUE),
('Gold', 'GOLD', 599000, 30, 'Gói cao cấp', 'Đăng không giới hạn, Ưu tiên #1, Báo cáo chi tiết, Hỗ trợ 24/7', TRUE)
ON CONFLICT ("PlanCode") DO NOTHING;

-- ===== STEP 5: Provider Accounts =====
INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "PhoneNumber", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'provider1@eztravel.vn', 'provider1', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'Đà Nẵng Star Travel', '0905111222', TRUE, NOW(), NOW()
FROM "Roles" r WHERE r."RoleName" = 'PROVIDER'
AND NOT EXISTS (SELECT 1 FROM "Users" WHERE "Username" = 'provider1');

INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "PhoneNumber", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'provider2@eztravel.vn', 'provider2', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'Vietnam Travel Group', '0905222333', TRUE, NOW(), NOW()
FROM "Roles" r WHERE r."RoleName" = 'PROVIDER'
AND NOT EXISTS (SELECT 1 FROM "Users" WHERE "Username" = 'provider2');

-- Providers table
INSERT INTO "Providers" ("ProviderId", "BusinessName", "BusinessLicense", "ProviderType", "Rating", "IsVerified", "TotalTours", "IsActive", "JoinDate", "Status")
SELECT u."UserId", 'Đà Nẵng Star Travel', 'BL-DN-2024-001', 'Tour Operator', 4.8, TRUE, 6, TRUE, CURRENT_DATE, 'Active'
FROM "Users" u WHERE u."Username" = 'provider1'
AND NOT EXISTS (SELECT 1 FROM "Providers" WHERE "ProviderId" = u."UserId");

INSERT INTO "Providers" ("ProviderId", "BusinessName", "BusinessLicense", "ProviderType", "Rating", "IsVerified", "TotalTours", "IsActive", "JoinDate", "Status")
SELECT u."UserId", 'Vietnam Travel Group', 'BL-DN-2024-002', 'Tour Operator', 4.6, TRUE, 6, TRUE, CURRENT_DATE, 'Active'
FROM "Users" u WHERE u."Username" = 'provider2'
AND NOT EXISTS (SELECT 1 FROM "Providers" WHERE "ProviderId" = u."UserId");

-- ===== STEP 6: Customer Accounts =====
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

-- ===== STEP 7: TOURS (12 tours) =====
DO $$
DECLARE
    v_p1 INT;
    v_p2 INT;
BEGIN
    SELECT "ProviderId" INTO v_p1 FROM "Providers" p JOIN "Users" u ON p."ProviderId" = u."UserId" WHERE u."Username" = 'provider1';
    SELECT "ProviderId" INTO v_p2 FROM "Providers" p JOIN "Users" u ON p."ProviderId" = u."UserId" WHERE u."Username" = 'provider2';

    IF v_p1 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Bà Nà Hills Trọn Gói') THEN
        INSERT INTO "Tours" ("ProviderId","CategoryId","TourName","ShortDesc","Description","Price","MaxPeople","Duration","Transport","StartLocation","Destination","ImageUrl","Itinerary","IsActive","CreatedAt") VALUES
        (v_p1, 1, 'Tour Bà Nà Hills Trọn Gói', 'Khám phá Bà Nà Hills - Cầu Vàng nổi tiếng thế giới', 'Tour Bà Nà Hills trọn gói bao gồm vé cáp treo, tham quan Cầu Vàng, làng Pháp, chùa Linh Ứng, Fantasy Park. Buffet trưa tại nhà hàng trên đỉnh.', 1500000, 30, '1 ngày', 'Xe du lịch + Cáp treo', 'Đà Nẵng', 'Bà Nà Hills', 'https://images.unsplash.com/photo-1570366583862-f91883984fde?w=800', '08:00 Đón khách → 09:30 Cáp treo → 10:00 Cầu Vàng → 12:00 Buffet → 14:00 Fantasy Park → 16:30 Về', TRUE, NOW() - INTERVAL '60 days'),
        
        (v_p1, 1, 'Tour Ngũ Hành Sơn - Hội An', 'Tham quan Ngũ Hành Sơn và phố cổ Hội An lung linh đèn lồng', 'Tour kết hợp Ngũ Hành Sơn (Marble Mountains) và phố cổ Hội An - di sản văn hóa thế giới UNESCO. Thả đèn hoa đăng trên sông Hoài.', 800000, 25, '1 ngày', 'Xe du lịch', 'Đà Nẵng', 'Hội An', 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800', '08:00 Đón → 09:00 Ngũ Hành Sơn → 13:00 Hội An → 17:00 Thả đèn → 19:00 Về', TRUE, NOW() - INTERVAL '55 days'),
        
        (v_p1, 6, 'Tour Cù Lao Chàm Lặn Biển', 'Khám phá đảo Cù Lao Chàm - Khu dự trữ sinh quyển UNESCO', 'Tour lặn biển Cù Lao Chàm: ca nô tốc hành, buffet hải sản, lặn biển ngắm san hô, tắm biển và tham quan làng chài.', 1200000, 20, '1 ngày', 'Ca nô tốc hành', 'Cửa Đại', 'Cù Lao Chàm', 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800', '07:00 Đón → 08:00 Ca nô → 09:30 Lặn biển → 11:30 Buffet → 15:00 Làng chài → 16:30 Về', TRUE, NOW() - INTERVAL '50 days'),
        
        (v_p1, 3, 'Tour Đà Nẵng City Night', 'Khám phá Đà Nẵng về đêm - Cầu Rồng phun lửa', 'Tour đêm: Cầu Rồng phun lửa, Cầu Tình Yêu, bờ sông Hàn, APEC Park, ẩm thực đường phố.', 500000, 20, '4 giờ', 'Xe điện + Đi bộ', 'Cầu Rồng', 'Đà Nẵng', 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800', '18:00 Cầu Rồng → 19:00 Sông Hàn → 20:00 APEC → 21:00 Phun lửa → 22:00 End', TRUE, NOW() - INTERVAL '45 days'),
        
        (v_p1, 4, 'Tour Ẩm Thực Đà Nẵng', 'Khám phá 10 món ăn đặc sản Đà Nẵng nổi tiếng', 'Tour ẩm thực: Mì Quảng, Bún mắm, Bánh tráng cuốn, Bê thui, Nem lụi, Hải sản tươi sống.', 650000, 15, '5 giờ', 'Xe máy / Xích lô', 'Chợ Hàn', 'Đà Nẵng', 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800', '09:00 Chợ Hàn → 10:00 Mì Quảng → 11:00 Bánh tráng → 12:00 Bê thui → 14:00 Nem lụi → 15:00 Kem', TRUE, NOW() - INTERVAL '40 days'),
        
        (v_p1, 5, 'Tour Sơn Trà Bán Đảo', 'Khám phá bán đảo Sơn Trà - lá phổi xanh Đà Nẵng', 'Tour sinh thái: ngắm voọc chà vá chân nâu, chùa Linh Ứng 67m, bãi biển hoang sơ, bình minh.', 700000, 15, '6 giờ', 'Xe Jeep', 'Đà Nẵng', 'Sơn Trà', 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800', '05:00 Đón → 05:30 Bình minh → 07:00 Chùa Linh Ứng → 08:30 Voọc → 10:00 Bãi Bụt → 11:00 Về', TRUE, NOW() - INTERVAL '35 days');
    END IF;

    IF v_p2 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM "Tours" WHERE "TourName" = 'Tour Mạo Hiểm Hải Vân Đèo') THEN
        INSERT INTO "Tours" ("ProviderId","CategoryId","TourName","ShortDesc","Description","Price","MaxPeople","Duration","Transport","StartLocation","Destination","ImageUrl","Itinerary","IsActive","CreatedAt") VALUES
        (v_p2, 2, 'Tour Mạo Hiểm Hải Vân Đèo', 'Đèo Hải Vân bằng Jeep - CNN bình chọn đẹp nhất VN', 'Tour mạo hiểm đèo Hải Vân bằng xe Jeep. Cung đường đèo dốc ngoạn mục, ngắm toàn cảnh Đà Nẵng - Lăng Cô.', 900000, 8, '5 giờ', 'Xe Jeep', 'Đà Nẵng', 'Đèo Hải Vân', 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800', '07:00 Đón → 08:00 Lên đèo → 09:30 Đỉnh đèo → 10:30 Lăng Cô → 13:00 Về', TRUE, NOW() - INTERVAL '30 days'),
        
        (v_p2, 1, 'Tour Huế Cố Đô 1 Ngày', 'Đại Nội Huế - Di sản văn hóa thế giới UNESCO', 'Tour Huế trọn gói: Đại Nội, Lăng Tự Đức, Lăng Khải Định, Chùa Thiên Mụ, sông Hương. Bún bò Huế chính gốc.', 1100000, 25, '1 ngày', 'Xe du lịch', 'Đà Nẵng', 'Huế', 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800', '06:00 Đón → 08:30 Đại Nội → 11:30 Bún bò → 13:00 Lăng → 15:30 Thiên Mụ → 18:00 Về', TRUE, NOW() - INTERVAL '25 days'),
        
        (v_p2, 2, 'Tour Kayak Sông Thu Bồn', 'Chèo kayak sông Thu Bồn - trải nghiệm sông nước miền Trung', 'Tour kayak sông Thu Bồn: chèo qua làng rau Trà Quế, bãi bồi, ngắm cảnh đồng quê yên bình.', 450000, 12, '3 giờ', 'Kayak', 'Hội An', 'Thu Bồn', 'https://images.unsplash.com/photo-1472745942893-4b9f730c7668?w=800', '07:00 Tập trung → 07:30 An toàn → 08:00 Chèo → 09:00 Trà Quế → 10:30 Về', TRUE, NOW() - INTERVAL '20 days'),
        
        (v_p2, 6, 'Tour Biển Mỹ Khê Sunrise', 'Bình minh tuyệt đẹp tại bãi biển Mỹ Khê - Top 6 Forbes', 'Tour bình minh Mỹ Khê: Yoga, bơi lội, lướt sóng, ăn sáng hải sản ngay bờ biển.', 350000, 20, '3 giờ', 'Đi bộ', 'Biển Mỹ Khê', 'Đà Nẵng', 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800', '05:00 Tập trung → 05:15 Yoga → 06:00 Bơi → 06:30 Lướt sóng → 07:30 Ăn sáng → 08:00 End', TRUE, NOW() - INTERVAL '15 days'),
        
        (v_p2, 3, 'Tour Làng Đá Non Nước', 'Làng nghề chạm khắc đá truyền thống 400 năm', 'Tour tham quan và trải nghiệm tự tay chạm khắc đá dưới hướng dẫn của nghệ nhân.', 400000, 15, '3 giờ', 'Xe điện', 'Ngũ Hành Sơn', 'Non Nước', 'https://images.unsplash.com/photo-1590674899484-d5640e854abe?w=800', '08:00 Đón → 08:30 Lịch sử → 09:00 Xưởng đá → 10:00 Trải nghiệm → 11:00 Mua sắm', TRUE, NOW() - INTERVAL '10 days'),
        
        (v_p2, 5, 'Tour Suối Hoa Lư Eco', 'Suối khoáng nóng và thiên nhiên hoang sơ', 'Tour sinh thái: tắm suối khoáng nóng, đi bộ rừng nguyên sinh, ngắm thác nước, picnic.', 550000, 15, '1 ngày', 'Xe du lịch', 'Đà Nẵng', 'Hòa Vang', 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800', '07:30 Đón → 08:30 Đến → 09:00 Rừng → 10:30 Thác → 11:30 Picnic → 13:00 Suối → 15:00 Về', TRUE, NOW() - INTERVAL '5 days');
    END IF;
END $$;

-- ===== STEP 8: ORDERS & BOOKINGS =====
DO $$
DECLARE
    v_c1 INT; v_c2 INT; v_c3 INT;
    v_t1 INT; v_t2 INT; v_t3 INT; v_t4 INT; v_t5 INT;
    v_oid INT;
BEGIN
    SELECT "UserId" INTO v_c1 FROM "Users" WHERE "Username" = 'khach1';
    SELECT "UserId" INTO v_c2 FROM "Users" WHERE "Username" = 'khach2';
    SELECT "UserId" INTO v_c3 FROM "Users" WHERE "Username" = 'khach3';
    
    SELECT "TourId" INTO v_t1 FROM "Tours" WHERE "TourName" = 'Tour Bà Nà Hills Trọn Gói' LIMIT 1;
    SELECT "TourId" INTO v_t2 FROM "Tours" WHERE "TourName" = 'Tour Cù Lao Chàm Lặn Biển' LIMIT 1;
    SELECT "TourId" INTO v_t3 FROM "Tours" WHERE "TourName" = 'Tour Ẩm Thực Đà Nẵng' LIMIT 1;
    SELECT "TourId" INTO v_t4 FROM "Tours" WHERE "TourName" = 'Tour Huế Cố Đô 1 Ngày' LIMIT 1;
    SELECT "TourId" INTO v_t5 FROM "Tours" WHERE "TourName" = 'Tour Mạo Hiểm Hải Vân Đèo' LIMIT 1;

    -- Skip nếu đã có orders
    IF v_c1 IS NOT NULL AND v_t1 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM "Orders" WHERE "CustomerId" = v_c1) THEN
        -- Khách 1: 3 orders (Completed, Confirmed, Pending)
        INSERT INTO "Orders" ("CustomerId","TotalAmount","OrderStatus","PaymentStatus","OrderDate","UpdatedAt")
        VALUES (v_c1, 4500000, 'Completed', 'Paid', NOW()-INTERVAL '25 days', NOW()-INTERVAL '20 days') RETURNING "OrderId" INTO v_oid;
        INSERT INTO "Bookings" ("OrderId","TourId","BookingDate","Quantity","SubTotal","BookingStatus") VALUES (v_oid, v_t1, NOW()-INTERVAL '25 days', 3, 4500000, 'Completed');

        INSERT INTO "Orders" ("CustomerId","TotalAmount","OrderStatus","PaymentStatus","OrderDate","UpdatedAt")
        VALUES (v_c1, 2400000, 'Confirmed', 'Paid', NOW()-INTERVAL '5 days', NOW()-INTERVAL '3 days') RETURNING "OrderId" INTO v_oid;
        IF v_t2 IS NOT NULL THEN
            INSERT INTO "Bookings" ("OrderId","TourId","BookingDate","Quantity","SubTotal","BookingStatus") VALUES (v_oid, v_t2, NOW()-INTERVAL '5 days', 2, 2400000, 'Confirmed');
        END IF;

        INSERT INTO "Orders" ("CustomerId","TotalAmount","OrderStatus","PaymentStatus","OrderDate","UpdatedAt")
        VALUES (v_c1, 1300000, 'Pending', 'Unpaid', NOW()-INTERVAL '1 day', NOW()) RETURNING "OrderId" INTO v_oid;
        IF v_t3 IS NOT NULL THEN
            INSERT INTO "Bookings" ("OrderId","TourId","BookingDate","Quantity","SubTotal","BookingStatus") VALUES (v_oid, v_t3, NOW()-INTERVAL '1 day', 2, 1300000, 'Pending');
        END IF;
    END IF;

    IF v_c2 IS NOT NULL AND v_t4 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM "Orders" WHERE "CustomerId" = v_c2) THEN
        -- Khách 2: 2 orders (Completed, Cancelled)
        INSERT INTO "Orders" ("CustomerId","TotalAmount","OrderStatus","PaymentStatus","OrderDate","UpdatedAt")
        VALUES (v_c2, 2200000, 'Completed', 'Paid', NOW()-INTERVAL '15 days', NOW()-INTERVAL '10 days') RETURNING "OrderId" INTO v_oid;
        INSERT INTO "Bookings" ("OrderId","TourId","BookingDate","Quantity","SubTotal","BookingStatus") VALUES (v_oid, v_t4, NOW()-INTERVAL '15 days', 2, 2200000, 'Completed');

        INSERT INTO "Orders" ("CustomerId","TotalAmount","OrderStatus","PaymentStatus","CancelReason","OrderDate","UpdatedAt")
        VALUES (v_c2, 1000000, 'Cancelled', 'Refunded', 'Thay đổi kế hoạch', NOW()-INTERVAL '8 days', NOW()-INTERVAL '7 days') RETURNING "OrderId" INTO v_oid;
        INSERT INTO "Bookings" ("OrderId","TourId","BookingDate","Quantity","SubTotal","BookingStatus") VALUES (v_oid, v_t4, NOW()-INTERVAL '8 days', 1, 1000000, 'Cancelled');
    END IF;

    IF v_c3 IS NOT NULL AND v_t5 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM "Orders" WHERE "CustomerId" = v_c3) THEN
        -- Khách 3: 1 order (Confirmed)
        INSERT INTO "Orders" ("CustomerId","TotalAmount","OrderStatus","PaymentStatus","OrderDate","UpdatedAt")
        VALUES (v_c3, 3600000, 'Confirmed', 'Paid', NOW()-INTERVAL '3 days', NOW()-INTERVAL '2 days') RETURNING "OrderId" INTO v_oid;
        INSERT INTO "Bookings" ("OrderId","TourId","BookingDate","Quantity","SubTotal","BookingStatus") VALUES (v_oid, v_t5, NOW()-INTERVAL '3 days', 4, 3600000, 'Confirmed');
    END IF;
END $$;

-- ===== STEP 9: Monthly Revenue =====
INSERT INTO "MonthlyRevenue" ("ReportMonth","ReportYear","TotalBookings","GrossVolume","PlatformFee")
SELECT m, 2026, (m * 3 + 5), (m * 2500000 + 5000000), (m * 250000 + 500000)
FROM generate_series(1, 3) AS m
WHERE NOT EXISTS (SELECT 1 FROM "MonthlyRevenue" WHERE "ReportYear" = 2026 AND "ReportMonth" = m);

-- ===== STEP 10: VERIFY =====
SELECT '✅ ' || "Table" || ': ' || "Count" || ' rows' AS "Result" FROM (
    SELECT 'Roles' AS "Table", COUNT(*)::TEXT AS "Count" FROM "Roles"
    UNION ALL SELECT 'Users', COUNT(*)::TEXT FROM "Users"
    UNION ALL SELECT 'Providers', COUNT(*)::TEXT FROM "Providers"
    UNION ALL SELECT 'Categories', COUNT(*)::TEXT FROM "Categories"
    UNION ALL SELECT 'Tours', COUNT(*)::TEXT FROM "Tours"
    UNION ALL SELECT 'Orders', COUNT(*)::TEXT FROM "Orders"
    UNION ALL SELECT 'Bookings', COUNT(*)::TEXT FROM "Bookings"
    UNION ALL SELECT 'SubscriptionPlans', COUNT(*)::TEXT FROM "SubscriptionPlans"
) sub ORDER BY "Table";

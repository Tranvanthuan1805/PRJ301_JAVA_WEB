-- =============================================
-- EZTRAVEL - THÊM 30 TOURS MỚI
-- Copy toàn bộ vào Supabase SQL Editor → Run
-- =============================================
-- Categories: 1=Tham Quan, 2=Mạo Hiểm, 3=Văn Hóa, 4=Ẩm Thực, 5=Sinh Thái, 6=Biển Đảo
-- Providers: provider1@eztravel.vn, provider2@eztravel.vn, provider3@eztravel.vn

-- ═══ TOUR THAM QUAN (Cat 1) ═══

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 1,
    'Đỉnh Bàn Cờ - Panorama Đà Nẵng',
    'Chinh phục đỉnh Bàn Cờ trên bán đảo Sơn Trà, ngắm toàn cảnh thành phố Đà Nẵng 360 độ tuyệt đẹp.',
    'Tour đỉnh Bàn Cờ lúc bình minh hoặc hoàng hôn. Ngắm toàn cảnh vịnh Đà Nẵng, Cù Lao Chàm xa xa, cầu Thuận Phước và cả thành phố lung linh. Bao gồm trà sáng trên đỉnh.',
    290000, 15, 'Nửa ngày', 'Xe jeep 4x4', 'Đà Nẵng', 'Đỉnh Bàn Cờ, Sơn Trà',
    'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=800&q=80',
    'Sáng sớm: Đón khách → Xe jeep lên đỉnh Bàn Cờ → Ngắm bình minh → Trà sáng → Chụp ảnh → Về.',
    TRUE, NOW() - INTERVAL '15 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 1,
    'Đèo Hải Vân - Con Đường Di Sản',
    'Chinh phục đèo Hải Vân huyền thoại bằng xe jeep, ngắm cảnh biển xanh ngắt và ghé Lăng Cô.',
    'Tour đèo Hải Vân trọn gói: vượt 21km đường đèo ngoạn mục, dừng chân tại đỉnh đèo, ghé Hải Vân Quan, ngắm vịnh Lăng Cô xanh biếc từ trên cao. Bao gồm bữa trưa hải sản Lăng Cô.',
    750000, 12, '1 ngày', 'Xe jeep 4x4', 'Đà Nẵng', 'Đèo Hải Vân - Lăng Cô',
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=800&q=80',
    'Sáng: Xuất phát → Đèo Hải Vân → Hải Vân Quan → Lăng Cô. Trưa: Hải sản Lăng Cô. Chiều: Tắm biển → Về.',
    TRUE, NOW() - INTERVAL '11 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 1,
    'Cầu Vàng Sunset - Golden Hour Tour',
    'Tour chiều tối Cầu Vàng Bà Nà Hills, ngắm hoàng hôn trên Cầu Vàng và show Carnival đêm.',
    'Tour buổi chiều-tối đặc biệt: lên Bà Nà lúc xế chiều, ngắm hoàng hôn vàng rực trên Cầu Vàng không đông đúc, thưởng thức show Carnival Đêm và buffet tối tại Làng Pháp.',
    1450000, 25, 'Buổi chiều - tối', 'Xe du lịch 16 chỗ', 'Đà Nẵng', 'Bà Nà Hills',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
    'Chiều: Cáp treo → Cầu Vàng sunset → Chụp ảnh. Tối: Buffet Làng Pháp → Show Carnival → Về.',
    TRUE, NOW() - INTERVAL '3 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 1,
    'City Tour Đà Nẵng - Khám Phá Thành Phố',
    'Tour tham quan nhanh thành phố Đà Nẵng trong nửa ngày, ghé thăm các điểm check-in nổi tiếng nhất.',
    'Tour nửa ngày: Bảo tàng Chăm, Cầu Rồng, Cầu Tình Yêu, Nhà thờ Con Gà, chợ Hàn, bờ sông Hàn. Combo chụp ảnh tại tất cả điểm check-in hot nhất thành phố.',
    250000, 20, 'Nửa ngày', 'Xe buýt du lịch', 'Đà Nẵng', 'Đà Nẵng',
    'https://images.unsplash.com/photo-1583417319070-4a69db38a482?auto=format&fit=crop&w=800&q=80',
    'Sáng: Bảo tàng Chăm → Cầu Rồng → Nhà thờ Con Gà → Chợ Hàn → Cầu Tình Yêu → Bờ sông Hàn.',
    TRUE, NOW() - INTERVAL '2 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider3@eztravel.vn';

-- ═══ TOUR MẠO HIỂM (Cat 2) ═══

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 2,
    'Paragliding Sơn Trà - Bay Lượn Trên Biển',
    'Trải nghiệm dù lượn paraglding trên bán đảo Sơn Trà, ngắm biển Mỹ Khê từ trên cao.',
    'Paragliding chuyên nghiệp tại Sơn Trà: bay cùng phi công kinh nghiệm 15 phút, ngắm toàn cảnh bờ biển Đà Nẵng từ độ cao 400m. Bao gồm quay phim GoPro, ảnh chuyên nghiệp.',
    1800000, 8, '2 giờ', 'Xe chuyên dụng', 'Đà Nẵng', 'Bán đảo Sơn Trà',
    'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?auto=format&fit=crop&w=800&q=80',
    'Briefing an toàn → Lên điểm bay → Bay 15 phút → Hạ cánh bãi biển → Nhận video/ảnh.',
    TRUE, NOW() - INTERVAL '5 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider3@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 2,
    'Lặn Bình Khí Scuba - Cù Lao Chàm',
    'Lặn bình khí scuba diving tại Cù Lao Chàm, khám phá thế giới dưới đại dương với huấn luyện chuyên nghiệp.',
    'Tour lặn scuba cho người mới: huấn luyện 1 tiếng tại bờ, 2 lần lặn sâu 8-12m tại rạn san hô. Camera dưới nước miễn phí. Huấn luyện viên PADI quốc tế.',
    1500000, 6, '1 ngày', 'Cano cao tốc', 'Cửa Đại, Hội An', 'Cù Lao Chàm',
    'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80',
    'Sáng: Cano ra đảo → Huấn luyện. Trưa: Lặn lần 1 → Nghỉ ăn trưa → Lặn lần 2 → Về.',
    TRUE, NOW() - INTERVAL '7 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 2,
    'Off-road Jeep Tour - Rừng Sơn Trà',
    'Phiêu lưu off-road bằng xe jeep xuyên rừng nguyên sinh Sơn Trà, vượt suối và tìm voọc.',
    'Tour off-road 4x4 xuyên rừng Sơn Trà: lái xe qua đường rừng, vượt suối, leo dốc. Dừng tại các điểm ngắm cảnh, tìm đàn voọc chà vá. Kết thúc tại bãi biển hoang sơ.',
    680000, 8, 'Nửa ngày', 'Jeep 4x4 quân sự', 'Đà Nẵng', 'Bán đảo Sơn Trà',
    'https://images.unsplash.com/photo-1533130061792-64b345e4a833?auto=format&fit=crop&w=800&q=80',
    'Sáng: Xuất phát → Off-road rừng → Tìm voọc → Đỉnh Bàn Cờ → Bãi biển Tiên Sa → BBQ → Về.',
    TRUE, NOW() - INTERVAL '4 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 2,
    'Wakeboard & Jetski Sông Hàn',
    'Trải nghiệm lướt ván wakeboard và jetski tốc độ cao trên sông Hàn ngay trung tâm thành phố.',
    'Tour thể thao nước: 30 phút jetski, 30 phút wakeboard với huấn luyện viên. Ngắm cầu Rồng, cầu Trần Thị Lý từ mặt sông. Áo phao, thiết bị an toàn đầy đủ.',
    750000, 10, '2 giờ', 'Tự túc', 'Bến du thuyền sông Hàn', 'Sông Hàn, Đà Nẵng',
    'https://images.unsplash.com/photo-1530053969600-caed2596d242?auto=format&fit=crop&w=800&q=80',
    'Hướng dẫn an toàn → Jetski 30p → Nghỉ → Wakeboard 30p → Tắm rửa → Kết thúc.',
    TRUE, NOW() - INTERVAL '1 day', NOW()
FROM "Users" u WHERE u."Email" = 'provider3@eztravel.vn';

-- ═══ TOUR VĂN HÓA (Cat 3) ═══

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 3,
    'Làng Gốm Thanh Hà & Rau Trà Quế',
    'Trải nghiệm làm gốm tại làng nghề Thanh Hà 500 năm và trồng rau tại làng Trà Quế.',
    'Tour trải nghiệm văn hóa: tự tay nặn gốm tại làng nghề Thanh Hà 500 tuổi, trồng rau sạch tại làng rau Trà Quế. Mang về sản phẩm gốm tự làm.',
    450000, 15, 'Nửa ngày', 'Xe đạp', 'Hội An', 'Thanh Hà - Trà Quế',
    'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?auto=format&fit=crop&w=800&q=80',
    'Sáng: Đạp xe đến Thanh Hà → Làm gốm → Trà Quế → Trồng rau → Nấu ăn → Ăn trưa → Về.',
    TRUE, NOW() - INTERVAL '6 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 3,
    'Thánh Địa Mỹ Sơn - Di Sản UNESCO',
    'Khám phá thánh địa Mỹ Sơn - di sản văn hóa thế giới, nơi lưu giữ nền văn minh Champa ngàn năm.',
    'Tour Mỹ Sơn UNESCO: tham quan quần thể đền tháp Chăm 1700 năm tuổi, xem biểu diễn Apsara, tìm hiểu lịch sử vương quốc Champa. HDV thuyết minh chuyên sâu.',
    550000, 25, '1 ngày', 'Xe du lịch 29 chỗ', 'Đà Nẵng', 'Thánh Địa Mỹ Sơn',
    'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=800&q=80',
    'Sáng: Xuất phát → Mỹ Sơn → Tham quan nhóm tháp B,C,D → Show Apsara. Trưa: Ăn trưa. Chiều: Hội An → Về.',
    TRUE, NOW() - INTERVAL '8 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 3,
    'Bảo Tàng Chăm & Nghệ Thuật Đà Nẵng',
    'Tour văn hóa nghệ thuật: Bảo tàng Điêu khắc Chăm, Bảo tàng Đà Nẵng và gallery nghệ thuật đương đại.',
    'Tour nửa ngày dành cho người yêu văn hóa: Bảo tàng Chăm (BST Ấn Độ giáo, Phật giáo), Bảo tàng Đà Nẵng (lịch sử thành phố), Art Gallery đương đại. Kết thúc tại café nghệ thuật.',
    320000, 20, 'Nửa ngày', 'Đi bộ / Grab', 'Đà Nẵng', 'Đà Nẵng',
    'https://images.unsplash.com/photo-1518998053901-5348d3961a04?auto=format&fit=crop&w=800&q=80',
    'Sáng: Bảo tàng Chăm → Bảo tàng Đà Nẵng → Art Gallery → Café nghệ thuật.',
    TRUE, NOW() - INTERVAL '10 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider3@eztravel.vn';

-- ═══ TOUR ẨM THỰC (Cat 4) ═══

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 4,
    'Ẩm Thực Hội An - Cao Lầu & Bánh Bao',
    'Food tour Hội An thưởng thức Cao Lầu, Bánh Bao Vạc, Cơm Gà Hội An và các món đặc sản phố cổ.',
    'Tour ẩm thực Hội An: 6 quán nổi tiếng nhất - Cao Lầu Bà Bé, Bánh Bao Vạc White Rose, Cơm Gà Bà Buội, Bánh Mì Phượng, Chè Bắp Cẩm Hà, Café Reaching Out (quán câm). HDV ẩm thực.',
    520000, 10, '1 ngày', 'Xe đạp / Đi bộ', 'Hội An', 'Hội An',
    'https://images.unsplash.com/photo-1555921015-5532091f6026?auto=format&fit=crop&w=800&q=80',
    'Sáng: Cao Lầu → White Rose → Chợ Hội An. Trưa: Cơm Gà Bà Buội. Chiều: Bánh Mì Phượng → Chè → Café.',
    TRUE, NOW() - INTERVAL '3 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 4,
    'Nấu Ăn Với Bếp Việt - Cooking Class',
    'Lớp học nấu ăn Việt Nam: đi chợ, chọn nguyên liệu tươi và nấu 4 món Việt truyền thống.',
    'Cooking class trải nghiệm: đi chợ Hàn chọn nguyên liệu, về bếp nấu 4 món (Phở, Gỏi cuốn, Bánh xèo, Chè). Học cách pha nước mắm chấm. Mang theo công thức về nhà.',
    680000, 8, 'Nửa ngày', 'Đi bộ', 'Đà Nẵng', 'Đà Nẵng',
    'https://images.unsplash.com/photo-1556910103-1c02745aae4d?auto=format&fit=crop&w=800&q=80',
    'Sáng: Đi chợ Hàn → Chọn nguyên liệu → Về bếp → Nấu 4 món → Thưởng thức → Nhận công thức.',
    TRUE, NOW() - INTERVAL '2 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 4,
    'Hải Sản Đêm Đà Nẵng - VIP Seafood',
    'Tour VIP thưởng thức hải sản tươi sống tại bãi biển Mỹ Khê, chọn trực tiếp từ bể nuôi.',
    'Tour hải sản VIP: đến bãi biển Mỹ Khê, chọn hải sản tươi sống trực tiếp (tôm hùm, cua, ghẹ, ốc, cá), nướng BBQ ngay bãi biển. Kèm bia tươi và nhạc acoustic.',
    890000, 12, 'Buổi tối', 'Xe đưa đón', 'Đà Nẵng', 'Bãi biển Mỹ Khê',
    'https://images.unsplash.com/photo-1559737558-2f5a35f4523b?auto=format&fit=crop&w=800&q=80',
    'Tối: Đón khách → Chọn hải sản → BBQ bãi biển → Bia tươi → Nhạc acoustic → Về.',
    TRUE, NOW() - INTERVAL '1 day', NOW()
FROM "Users" u WHERE u."Email" = 'provider3@eztravel.vn';

-- ═══ TOUR SINH THÁI (Cat 5) ═══

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 5,
    'Suối Hoa - Trekking & Tắm Suối',
    'Trekking suối Hoa trong rừng nguyên sinh, tắm suối mát lạnh và cắm trại giữa thiên nhiên.',
    'Tour trekking suối Hoa: đi bộ 5km xuyên rừng, qua 3 tầng thác, tắm hồ suối tự nhiên. Bao gồm picnic, cắm trại nếu tour 2 ngày, hướng dẫn viên rừng bản địa.',
    520000, 12, '1 ngày', 'Xe bán tải', 'Đà Nẵng', 'Suối Hoa, Hòa Vang',
    'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?auto=format&fit=crop&w=800&q=80',
    'Sáng: Xuất phát → Đi bộ rừng → Thác tầng 1,2 → Tắm suối. Trưa: Picnic rừng. Chiều: Thác tầng 3 → Về.',
    TRUE, NOW() - INTERVAL '9 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 5,
    'Rừng Dừa Bảy Mẫu - Thuyền Thúng',
    'Chèo thuyền thúng xuyên rừng dừa nước Cẩm Thanh, bắt cua sông và thưởng thức ẩm thực làng quê.',
    'Tour sinh thái rừng dừa: chèo thuyền thúng qua rừng dừa nước xanh mướt, xem biểu diễn lắc thuyền, bắt cua sông, câu cá. Ăn trưa ẩm thực làng quê tại nhà dân.',
    380000, 15, 'Nửa ngày', 'Xe du lịch + Thuyền thúng', 'Hội An', 'Rừng Dừa Cẩm Thanh',
    'https://images.unsplash.com/photo-1528164344705-47542687000d?auto=format&fit=crop&w=800&q=80',
    'Sáng: Đến Cẩm Thanh → Thuyền thúng → Rừng dừa → Bắt cua → Biểu diễn. Trưa: Ăn trưa làng quê → Về.',
    TRUE, NOW() - INTERVAL '4 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 5,
    'Cắm Trại Hồ Đồng Xanh - Overnight',
    'Cắm trại qua đêm tại hồ Đồng Xanh, BBQ dưới trời sao và kayak trên hồ nước trong veo.',
    'Tour cắm trại 2N1Đ: dựng lều bên hồ Đồng Xanh, BBQ buổi tối, đốt lửa trại, ngắm sao. Sáng hôm sau kayak trên hồ, tắm suối. Bao gồm lều, nệm, BBQ set.',
    1200000, 10, '2 ngày 1 đêm', 'Xe bán tải', 'Đà Nẵng', 'Hồ Đồng Xanh, Hòa Vang',
    'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?auto=format&fit=crop&w=800&q=80',
    'Chiều: Dựng trại → Tắm hồ → BBQ → Lửa trại. Sáng: Kayak → Trekking → Tắm suối → Về.',
    TRUE, NOW() - INTERVAL '6 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider3@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 5,
    'Vườn Quốc Gia Bạch Mã - Trekking',
    'Trekking vườn quốc gia Bạch Mã, chinh phục đỉnh 1450m và khám phá thác Đỗ Quyên hùng vĩ.',
    'Tour Bạch Mã National Park: trekking đỉnh Hải Vọng Đài 1450m, thác Đỗ Quyên 300m, rừng nguyên sinh với đa dạng sinh học. Bao gồm phí vườn, HDV sinh thái.',
    780000, 15, '1 ngày', 'Xe du lịch', 'Đà Nẵng', 'VQG Bạch Mã, Huế',
    'https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=800&q=80',
    'Sáng: Xuất phát → Cổng VQG → Trekking lên đỉnh. Trưa: Picnic. Chiều: Thác Đỗ Quyên → Về.',
    TRUE, NOW() - INTERVAL '13 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

-- ═══ TOUR BIỂN ĐẢO (Cat 6) ═══

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 6,
    'Câu Cá & BBQ Cù Lao Chàm',
    'Tour câu cá biển tại Cù Lao Chàm, tự tay nướng hải sản vừa câu và tắm biển hoang sơ.',
    'Tour câu cá chuyên nghiệp: cano ra vùng biển Cù Lao Chàm, câu cá với cần câu và mồi cung cấp sẵn. BBQ hải sản vừa câu tại bãi biển hoang sơ. Kèm snorkeling miễn phí.',
    1100000, 8, '1 ngày', 'Cano', 'Cửa Đại', 'Cù Lao Chàm',
    'https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?auto=format&fit=crop&w=800&q=80',
    'Sáng: Cano ra điểm câu → Câu cá 3h. Trưa: BBQ bãi biển. Chiều: Snorkeling → Tắm biển → Về.',
    TRUE, NOW() - INTERVAL '5 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 6,
    'Lướt Sóng Mỹ Khê - Surf Camp',
    'Khóa học lướt sóng cho người mới tại bãi biển Mỹ Khê, một trong 6 bãi biển đẹp nhất hành tinh.',
    'Surf camp nửa ngày: huấn luyện viên quốc tế, ván surf chuyên dụng, 2 giờ thực hành trên sóng. Phù hợp mọi trình độ, đặc biệt người mới bắt đầu.',
    650000, 8, 'Nửa ngày', 'Tự túc', 'Biển Mỹ Khê', 'Biển Mỹ Khê, Đà Nẵng',
    'https://images.unsplash.com/photo-1502680390548-bdbac40b3981?auto=format&fit=crop&w=800&q=80',
    'Sáng: Tập trung → Khởi động → Lý thuyết trên bờ → Thực hành trên sóng 2h → Nghỉ → Kết thúc.',
    TRUE, NOW() - INTERVAL '2 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider3@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 6,
    'Du Thuyền Sông Hàn - Dinner Cruise',
    'Du thuyền VIP trên sông Hàn buổi tối, ngắm 7 cây cầu lung linh và thưởng thức dinner buffet.',
    'Dinner cruise 2 tiếng: du thuyền sang trọng, ngắm Đà Nẵng về đêm từ sông Hàn, buffet hải sản, nhạc sống acoustic, cocktail bar. Phù hợp couple, tiệc nhóm.',
    990000, 30, 'Buổi tối', 'Du thuyền', 'Bến du thuyền Hàn', 'Sông Hàn, Đà Nẵng',
    'https://images.unsplash.com/photo-1569263979104-865ab7cd8d13?auto=format&fit=crop&w=800&q=80',
    'Tối: Lên thuyền → Cocktail welcome → Buffet dinner → Ngắm cầu Rồng → Nhạc acoustic → Cập bến.',
    TRUE, NOW() - INTERVAL '1 day', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 6,
    'Đảo Hòn Sơn Chà - Beach Paradise',
    'Tour đảo hoang Hòn Sơn Chà, tắm biển cát trắng, lặn ngắm san hô và picnic trên đảo.',
    'Tour đảo hoang sơ: cano ra Hòn Sơn Chà, tắm biển cát trắng tuyệt đẹp, lặn snorkeling ngắm san hô, picnic hải sản trên bãi cát. Chỉ 6 khách/tour để giữ trải nghiệm riêng tư.',
    1350000, 6, '1 ngày', 'Cano riêng', 'Cửa Đại', 'Hòn Sơn Chà',
    'https://images.unsplash.com/photo-1519046904884-53103b34b206?auto=format&fit=crop&w=800&q=80',
    'Sáng: Cano riêng ra đảo → Tắm biển → Snorkeling. Trưa: Picnic hải sản. Chiều: Thư giãn → Về.',
    TRUE, NOW() - INTERVAL '7 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn';

-- ═══ COMBO TOURS ═══

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 1,
    'Combo 3N2Đ Đà Nẵng - Hội An - Huế',
    'Package trọn gói 3 ngày 2 đêm khám phá 3 thành phố di sản miền Trung Việt Nam.',
    'Combo hoàn hảo: Ngày 1 Đà Nẵng (Bà Nà Hills, Cầu Vàng). Ngày 2 Hội An (Phố cổ, Hoa đăng). Ngày 3 Huế (Đại Nội, Lăng Tẩm). KS 4 sao, xe VIP, HDV song ngữ, 3 bữa trưa + 2 bữa tối.',
    4500000, 20, '3 ngày 2 đêm', 'Xe VIP limousine', 'Đà Nẵng', 'Đà Nẵng - Hội An - Huế',
    'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=800&q=80',
    'Ngày 1: Bà Nà - Cầu Vàng → KS. Ngày 2: Hội An phố cổ - Hoa đăng → KS Huế. Ngày 3: Đại Nội - Lăng Tẩm → Về ĐN.',
    TRUE, NOW() - INTERVAL '14 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 1,
    'Tour VIP Private - Xe Riêng Trọn Ngày',
    'Tour private xe riêng trọn ngày, tùy chỉnh lịch trình theo ý bạn. HDV riêng, linh hoạt 100%.',
    'Tour VIP private: xe riêng 7 chỗ, tài xế kinh nghiệm, HDV riêng. Bạn chọn đi đâu: Bà Nà, Hội An, Huế, Sơn Trà... Lịch trình linh hoạt hoàn toàn, dừng đâu cũng được.',
    3200000, 6, '1 ngày', 'Xe sedona 7 chỗ VIP', 'Đà Nẵng', 'Tùy chỉnh',
    'https://images.unsplash.com/photo-1449034446853-66c86144b0ad?auto=format&fit=crop&w=800&q=80',
    'Theo yêu cầu khách: Đón → Điểm 1 → Điểm 2 → Ăn trưa → Điểm 3 → Điểm 4 → Về khách sạn.',
    TRUE, NOW() - INTERVAL '1 day', NOW()
FROM "Users" u WHERE u."Email" = 'provider3@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 3,
    'Tour Đêm Hội An - Lantern Festival',
    'Trải nghiệm đêm rằm phố cổ Hội An với lễ hội đèn lồng, thả hoa đăng, nhạc truyền thống và bài chòi.',
    'Tour đêm Hội An đêm rằm: phố cổ không xe máy, hàng nghìn đèn lồng, thả hoa đăng sông Hoài, xem biểu diễn bài chòi, nhạc cung đình Huế, múa lân. Bao gồm áo dài trải nghiệm.',
    480000, 20, 'Buổi tối', 'Xe du lịch', 'Đà Nẵng', 'Hội An',
    'https://images.unsplash.com/photo-1559592442-7e182c3c03fb?auto=format&fit=crop&w=800&q=80',
    'Tối: Đến Hội An → Mặc áo dài → Dạo phố cổ → Hoa đăng → Bài chòi → Ẩm thực → Về.',
    TRUE, NOW() - INTERVAL '12 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider2@eztravel.vn';

INSERT INTO "Tours" ("ProviderId", "CategoryId", "TourName", "ShortDesc", "Description", "Price", "MaxPeople", "Duration", "Transport", "StartLocation", "Destination", "ImageUrl", "Itinerary", "IsActive", "CreatedAt", "UpdatedAt")
SELECT u."UserId", 2,
    'Vespa Tour Đà Nẵng - Phượt Thành Phố',
    'Phượt Đà Nẵng bằng xe Vespa cổ điển, ghé thăm các điểm bí ẩn mà du khách thường bỏ lỡ.',
    'Tour Vespa vintage: cưỡi xe Vespa cổ điển khám phá Đà Nẵng bí ẩn - xóm chài, chợ nhỏ, quán ăn local, art street. Hướng dẫn viên bản địa, chụp ảnh chuyên nghiệp.',
    750000, 8, 'Nửa ngày', 'Xe Vespa cổ điển', 'Đà Nẵng', 'Đà Nẵng',
    'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=800&q=80',
    'Sáng: Nhận xe → Xóm chài → Chợ nhỏ → Cafe local → Art street → Biển → Trả xe.',
    TRUE, NOW() - INTERVAL '3 days', NOW()
FROM "Users" u WHERE u."Email" = 'provider1@eztravel.vn';

-- ═══ CẬP NHẬT SỐ LƯỢNG TOUR ═══
UPDATE "Providers" SET "TotalTours" = (
    SELECT COUNT(*) FROM "Tours" t WHERE t."ProviderId" = "Providers"."ProviderId" AND t."IsActive" = TRUE
);

SELECT '✅ Thêm tour thành công! Tổng: ' || COUNT(*) || ' tours active.' AS result FROM "Tours" WHERE "IsActive" = TRUE;

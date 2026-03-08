-- =============================================
-- EZTravel: Coupons & Reviews Feature
-- =============================================

-- 1. Bảng mã giảm giá
CREATE TABLE IF NOT EXISTS "Coupons" (
    "CouponId"       SERIAL PRIMARY KEY,
    "Code"           VARCHAR(50) NOT NULL UNIQUE,
    "DiscountType"   VARCHAR(20) NOT NULL DEFAULT 'percent',  -- 'percent' hoặc 'fixed'
    "DiscountValue"  DOUBLE PRECISION NOT NULL DEFAULT 0,
    "MinOrderAmount" DOUBLE PRECISION DEFAULT 0,
    "MaxDiscount"    DOUBLE PRECISION DEFAULT NULL,
    "UsageLimit"     INT DEFAULT NULL,
    "UsedCount"      INT DEFAULT 0,
    "StartDate"      TIMESTAMP DEFAULT NOW(),
    "EndDate"        TIMESTAMP DEFAULT NULL,
    "IsActive"       BOOLEAN DEFAULT TRUE,
    "Description"    VARCHAR(255),
    "CreatedAt"      TIMESTAMP DEFAULT NOW()
);

-- 2. Bảng đánh giá tour
CREATE TABLE IF NOT EXISTS "Reviews" (
    "ReviewId"   SERIAL PRIMARY KEY,
    "TourId"     INT NOT NULL REFERENCES "Tours"("TourId") ON DELETE CASCADE,
    "UserId"     INT NOT NULL REFERENCES "Users"("UserId") ON DELETE CASCADE,
    "Rating"     INT NOT NULL CHECK ("Rating" >= 1 AND "Rating" <= 5),
    "Comment"    TEXT,
    "CreatedAt"  TIMESTAMP DEFAULT NOW(),
    "UpdatedAt"  TIMESTAMP DEFAULT NOW(),
    UNIQUE("TourId", "UserId")  -- Mỗi user chỉ đánh giá 1 lần/tour
);

-- Index để tối ưu query
CREATE INDEX IF NOT EXISTS idx_reviews_tour ON "Reviews"("TourId");
CREATE INDEX IF NOT EXISTS idx_reviews_user ON "Reviews"("UserId");
CREATE INDEX IF NOT EXISTS idx_coupons_code ON "Coupons"("Code");

-- =============================================
-- Dữ liệu mẫu: Mã giảm giá
-- =============================================
INSERT INTO "Coupons" ("Code", "DiscountType", "DiscountValue", "MinOrderAmount", "MaxDiscount", "UsageLimit", "Description", "EndDate")
VALUES
    ('WELCOME10', 'percent', 10, 500000, 200000, 100, 'Giảm 10% cho khách hàng mới (tối đa 200K)', '2026-12-31 23:59:59'),
    ('SUMMER50K', 'fixed', 50000, 300000, NULL, 200, 'Giảm 50,000đ cho đơn từ 300K', '2026-09-30 23:59:59'),
    ('VIP20', 'percent', 20, 1000000, 500000, 50, 'Giảm 20% cho đơn từ 1 triệu (tối đa 500K)', '2026-12-31 23:59:59'),
    ('FREESHIP', 'fixed', 100000, 0, NULL, 500, 'Giảm 100,000đ - Ưu đãi đặc biệt', '2026-06-30 23:59:59'),
    ('DANANG2026', 'percent', 15, 200000, 300000, 1000, 'Giảm 15% mừng năm mới 2026', '2026-12-31 23:59:59')
ON CONFLICT ("Code") DO NOTHING;

-- =============================================
-- Dữ liệu mẫu: Đánh giá tour (sẽ tự tạo từ user thật)
-- =============================================

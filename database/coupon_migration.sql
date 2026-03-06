-- =============================================
-- Coupon Feature Migration
-- Run this on Supabase PostgreSQL
-- =============================================

-- 1. Coupons table
CREATE TABLE "Coupons" (
    "CouponId"       SERIAL PRIMARY KEY,
    "Code"           VARCHAR(50) UNIQUE NOT NULL,
    "DiscountType"   VARCHAR(20) NOT NULL DEFAULT 'PERCENTAGE',
    "DiscountValue"  DECIMAL(12,2) NOT NULL,
    "MinOrderAmount" DECIMAL(12,2) DEFAULT 0,
    "MaxDiscount"    DECIMAL(12,2),
    "UsageLimit"     INT DEFAULT 0,
    "UsedCount"      INT DEFAULT 0,
    "StartDate"      TIMESTAMP,
    "EndDate"        TIMESTAMP,
    "IsActive"       BOOLEAN DEFAULT TRUE,
    "CreatedAt"      TIMESTAMP DEFAULT NOW()
);

-- 2. Add coupon fields to Orders table
ALTER TABLE "Orders" ADD COLUMN "CouponCode" VARCHAR(50);
ALTER TABLE "Orders" ADD COLUMN "DiscountAmount" DECIMAL(12,2) DEFAULT 0;

-- 3. Sample test coupons
INSERT INTO "Coupons" ("Code", "DiscountType", "DiscountValue", "MinOrderAmount", "MaxDiscount", "UsageLimit", "StartDate", "EndDate", "IsActive")
VALUES
('WELCOME10', 'PERCENTAGE', 10, 200000, 100000, 100, '2026-01-01', '2026-12-31', true),
('SAVE50K', 'FIXED', 50000, 300000, NULL, 50, '2026-01-01', '2026-12-31', true),
('SUMMER2026', 'PERCENTAGE', 20, 500000, 200000, 0, '2026-06-01', '2026-08-31', true);

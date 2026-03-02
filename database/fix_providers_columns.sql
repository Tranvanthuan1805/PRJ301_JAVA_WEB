-- =============================================
-- FIX: Thêm các cột thiếu trong bảng Providers
-- Chạy trong Supabase SQL Editor TRƯỚC KHI chạy full_sample_data.sql
-- =============================================

-- Thêm cột thiếu vào Providers
ALTER TABLE "Providers" ADD COLUMN IF NOT EXISTS "JoinDate" DATE DEFAULT CURRENT_DATE;
ALTER TABLE "Providers" ADD COLUMN IF NOT EXISTS "Status" VARCHAR(20) DEFAULT 'Active';
ALTER TABLE "Providers" ADD COLUMN IF NOT EXISTS "Description" TEXT;
ALTER TABLE "Providers" ADD COLUMN IF NOT EXISTS "CreatedAt" TIMESTAMP DEFAULT NOW();
ALTER TABLE "Providers" ADD COLUMN IF NOT EXISTS "UpdatedAt" TIMESTAMP DEFAULT NOW();

-- Cập nhật data cũ
UPDATE "Providers" SET 
    "JoinDate" = CURRENT_DATE,
    "Status" = 'Active',
    "CreatedAt" = NOW(),
    "UpdatedAt" = NOW()
WHERE "JoinDate" IS NULL;

-- Verify
SELECT * FROM "Providers";

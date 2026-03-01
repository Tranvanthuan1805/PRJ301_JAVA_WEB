-- =============================================
-- SUPABASE POSTGRESQL - SEED DATA
-- Run this AFTER the app starts (Hibernate creates tables automatically)
-- =============================================

-- Insert Roles
INSERT INTO "Roles" ("RoleName") VALUES ('ADMIN') ON CONFLICT DO NOTHING;
INSERT INTO "Roles" ("RoleName") VALUES ('PROVIDER') ON CONFLICT DO NOTHING;
INSERT INTO "Roles" ("RoleName") VALUES ('CUSTOMER') ON CONFLICT DO NOTHING;

-- Insert Admin account (Password: 123456 - SHA256)
INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'admin@dananghub.com', 'admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'System Admin', true, NOW(), NOW()
FROM "Roles" r WHERE r."RoleName" = 'ADMIN'
AND NOT EXISTS (SELECT 1 FROM "Users" WHERE "Username" = 'admin');

-- Insert Categories
INSERT INTO "Categories" ("CategoryName", "Description") VALUES
('Tour Tham Quan', 'Tour tham quan cac diem du lich noi tieng'),
('Tour Mao Hiem', 'Tour trai nghiem mao hiem va the thao'),
('Tour Van Hoa', 'Tour tim hieu van hoa va lich su'),
('Tour Am Thuc', 'Tour kham pha am thuc dia phuong'),
('Tour Sinh Thai', 'Tour du lich sinh thai va thien nhien'),
('Tour Bien Dao', 'Tour du lich bien va dao')
ON CONFLICT DO NOTHING;

-- Insert Subscription Plans
INSERT INTO "SubscriptionPlans" ("PlanName", "PlanCode", "Price", "DurationDays", "Description", "Features", "IsActive") VALUES
('Basic', 'BASIC', 0, 30, 'Goi mien phi co ban', 'Dang 5 tour, Hien thi co ban', true),
('Premium', 'PREMIUM', 299000, 30, 'Goi nang cao', 'Dang 20 tour, Uu tien hien thi, Bao cao', true),
('Gold', 'GOLD', 599000, 30, 'Goi cao cap', 'Dang khong gioi han, Uu tien #1, Bao cao chi tiet, Ho tro 24/7', true)
ON CONFLICT DO NOTHING;

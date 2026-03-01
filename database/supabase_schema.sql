-- =============================================
-- EZTRAVEL - SUPABASE POSTGRESQL SCHEMA
-- Version 4.0
-- Copy toàn bộ script này vào Supabase SQL Editor → Run
-- =============================================

-- MODULE 1: AUTH
CREATE TABLE IF NOT EXISTS "Roles" (
    "RoleId"   SERIAL PRIMARY KEY,
    "RoleName" VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS "Users" (
    "UserId"       SERIAL PRIMARY KEY,
    "Email"        VARCHAR(100) NOT NULL UNIQUE,
    "Username"     VARCHAR(50) NOT NULL UNIQUE,
    "PasswordHash" VARCHAR(255) NOT NULL,
    "RoleId"       INT NOT NULL,
    "FullName"     VARCHAR(100),
    "PhoneNumber"  VARCHAR(20),
    "Address"      VARCHAR(255),
    "DateOfBirth"  DATE,
    "AvatarUrl"    VARCHAR(500),
    "IsActive"     BOOLEAN DEFAULT TRUE,
    "CreatedAt"    TIMESTAMP DEFAULT NOW(),
    "UpdatedAt"    TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_users_roles FOREIGN KEY ("RoleId") REFERENCES "Roles"("RoleId")
);

-- MODULE 2: PROVIDER
CREATE TABLE IF NOT EXISTS "Providers" (
    "ProviderId"      INT PRIMARY KEY,
    "BusinessName"    VARCHAR(200) NOT NULL,
    "BusinessLicense" VARCHAR(100),
    "ProviderType"    VARCHAR(50),
    "Rating"          DECIMAL(3,2) DEFAULT 0,
    "IsVerified"      BOOLEAN DEFAULT FALSE,
    "TotalTours"      INT DEFAULT 0,
    "IsActive"        BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_providers_users FOREIGN KEY ("ProviderId") REFERENCES "Users"("UserId")
);

-- MODULE 3: CATALOG
CREATE TABLE IF NOT EXISTS "Categories" (
    "CategoryId"   SERIAL PRIMARY KEY,
    "CategoryName" VARCHAR(100) NOT NULL,
    "IconUrl"      VARCHAR(500),
    "Description"  VARCHAR(500)
);

CREATE TABLE IF NOT EXISTS "Tours" (
    "TourId"        SERIAL PRIMARY KEY,
    "ProviderId"    INT NOT NULL,
    "CategoryId"    INT NOT NULL,
    "TourName"      VARCHAR(255) NOT NULL,
    "ShortDesc"     VARCHAR(500),
    "Description"   TEXT,
    "Price"         DECIMAL(18,2) NOT NULL,
    "MaxPeople"     INT DEFAULT 20,
    "Duration"      VARCHAR(50),
    "Transport"     VARCHAR(100),
    "StartLocation" VARCHAR(200),
    "Destination"   VARCHAR(200),
    "ImageUrl"      VARCHAR(500),
    "Itinerary"     TEXT,
    "IsActive"      BOOLEAN DEFAULT TRUE,
    "CreatedAt"     TIMESTAMP DEFAULT NOW(),
    "UpdatedAt"     TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_tours_providers  FOREIGN KEY ("ProviderId") REFERENCES "Providers"("ProviderId"),
    CONSTRAINT fk_tours_categories FOREIGN KEY ("CategoryId") REFERENCES "Categories"("CategoryId")
);

CREATE TABLE IF NOT EXISTS "TourImages" (
    "ImageId"   SERIAL PRIMARY KEY,
    "TourId"    INT NOT NULL,
    "ImageUrl"  VARCHAR(500) NOT NULL,
    "Caption"   VARCHAR(200),
    "SortOrder" INT DEFAULT 0,
    CONSTRAINT fk_tourimages_tours FOREIGN KEY ("TourId") REFERENCES "Tours"("TourId") ON DELETE CASCADE
);

-- MODULE 4: CUSTOMER
CREATE TABLE IF NOT EXISTS "Customers" (
    "CustomerId"  INT PRIMARY KEY,
    "Address"     VARCHAR(255),
    "DateOfBirth" DATE,
    "Status"      VARCHAR(20) DEFAULT 'active',
    CONSTRAINT fk_customers_users FOREIGN KEY ("CustomerId") REFERENCES "Users"("UserId")
);

-- MODULE 5: ORDER & BOOKING
CREATE TABLE IF NOT EXISTS "Orders" (
    "OrderId"       SERIAL PRIMARY KEY,
    "CustomerId"    INT NOT NULL,
    "TotalAmount"   DECIMAL(18,2) NOT NULL,
    "OrderStatus"   VARCHAR(50) DEFAULT 'Pending',
    "PaymentStatus" VARCHAR(20) DEFAULT 'Unpaid',
    "CancelReason"  VARCHAR(500),
    "OrderDate"     TIMESTAMP DEFAULT NOW(),
    "UpdatedAt"     TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_orders_users FOREIGN KEY ("CustomerId") REFERENCES "Users"("UserId")
);

CREATE TABLE IF NOT EXISTS "Bookings" (
    "BookingId"     SERIAL PRIMARY KEY,
    "OrderId"       INT NOT NULL,
    "TourId"        INT NOT NULL,
    "BookingDate"   TIMESTAMP NOT NULL,
    "Quantity"      INT DEFAULT 1,
    "SubTotal"      DECIMAL(18,2) NOT NULL,
    "BookingStatus" VARCHAR(50) DEFAULT 'Pending',
    CONSTRAINT fk_bookings_orders FOREIGN KEY ("OrderId") REFERENCES "Orders"("OrderId"),
    CONSTRAINT fk_bookings_tours  FOREIGN KEY ("TourId")  REFERENCES "Tours"("TourId")
);

-- MODULE 6: PAYMENT & REVENUE
CREATE TABLE IF NOT EXISTS "Payments" (
    "PaymentId"     SERIAL PRIMARY KEY,
    "OrderId"       INT NOT NULL,
    "PaymentMethod" VARCHAR(50),
    "TransactionId" VARCHAR(100),
    "Amount"        DECIMAL(18,2),
    "PaymentStatus" VARCHAR(50),
    "PaidAt"        TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_payments_orders FOREIGN KEY ("OrderId") REFERENCES "Orders"("OrderId")
);

CREATE TABLE IF NOT EXISTS "MonthlyRevenue" (
    "RevenueId"     SERIAL PRIMARY KEY,
    "ReportMonth"   INT,
    "ReportYear"    INT,
    "TotalBookings" INT,
    "GrossVolume"   DECIMAL(18,2),
    "PlatformFee"   DECIMAL(18,2),
    "CreatedAt"     TIMESTAMP DEFAULT NOW()
);

-- MODULE 7: SUBSCRIPTION
CREATE TABLE IF NOT EXISTS "SubscriptionPlans" (
    "PlanId"       SERIAL PRIMARY KEY,
    "PlanName"     VARCHAR(100) NOT NULL,
    "PlanCode"     VARCHAR(50) NOT NULL UNIQUE,
    "Price"        DECIMAL(18,2) NOT NULL,
    "DurationDays" INT DEFAULT 30,
    "Description"  VARCHAR(500),
    "Features"     TEXT,
    "IsActive"     BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS "ProviderSubscriptions" (
    "SubId"         SERIAL PRIMARY KEY,
    "ProviderId"    INT NOT NULL,
    "PlanId"        INT NOT NULL,
    "StartDate"     TIMESTAMP,
    "EndDate"       TIMESTAMP,
    "Status"        VARCHAR(20) DEFAULT 'Active',
    "PaymentStatus" VARCHAR(20) DEFAULT 'Unpaid',
    "Amount"        DECIMAL(18,2),
    "IsActive"      BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_subs_providers FOREIGN KEY ("ProviderId") REFERENCES "Providers"("ProviderId"),
    CONSTRAINT fk_subs_plans     FOREIGN KEY ("PlanId")     REFERENCES "SubscriptionPlans"("PlanId")
);

-- MODULE 8: PAYMENT TRANSACTIONS
CREATE TABLE IF NOT EXISTS "PaymentTransactions" (
    "TransactionId"   SERIAL PRIMARY KEY,
    "UserId"          INT NOT NULL,
    "PlanId"          INT,
    "OrderId"         INT,
    "Amount"          DECIMAL(18,2) NOT NULL,
    "TransactionCode" VARCHAR(100) UNIQUE NOT NULL,
    "Status"          VARCHAR(20) DEFAULT 'Pending',
    "PaymentGateway"  VARCHAR(50),
    "SePayReference"  VARCHAR(100),
    "CreatedDate"     TIMESTAMP DEFAULT NOW(),
    "PaidDate"        TIMESTAMP,
    CONSTRAINT fk_paytrans_users  FOREIGN KEY ("UserId")  REFERENCES "Users"("UserId"),
    CONSTRAINT fk_paytrans_plans  FOREIGN KEY ("PlanId")  REFERENCES "SubscriptionPlans"("PlanId"),
    CONSTRAINT fk_paytrans_orders FOREIGN KEY ("OrderId") REFERENCES "Orders"("OrderId")
);

CREATE TABLE IF NOT EXISTS "SepayTransactions" (
    "Id"              INT PRIMARY KEY,
    "Gateway"         VARCHAR(50),
    "TransactionDate" VARCHAR(50),
    "AccountNumber"   VARCHAR(50),
    "Code"            VARCHAR(100),
    "Content"         VARCHAR(500),
    "TransferType"    VARCHAR(20),
    "TransferAmount"  DECIMAL(18,2),
    "Accumulated"     DECIMAL(18,2),
    "SubAccount"      VARCHAR(50),
    "ReferenceCode"   VARCHAR(100),
    "Description"     VARCHAR(500),
    "CreatedAt"       TIMESTAMP DEFAULT NOW()
);

-- MODULE 9: CUSTOMER ACTIVITY & AI
CREATE TABLE IF NOT EXISTS "CustomerActivities" (
    "Id"          SERIAL PRIMARY KEY,
    "CustomerId"  INT NOT NULL,
    "ActionType"  VARCHAR(50) NOT NULL,
    "Description" VARCHAR(500),
    "Metadata"    TEXT,
    "CreatedAt"   TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_custact_users FOREIGN KEY ("CustomerId") REFERENCES "Users"("UserId")
);

CREATE TABLE IF NOT EXISTS "InteractionHistory" (
    "Id"         SERIAL PRIMARY KEY,
    "CustomerId" INT NOT NULL,
    "Action"     VARCHAR(100) NOT NULL,
    "CreatedAt"  TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_inthist_users FOREIGN KEY ("CustomerId") REFERENCES "Users"("UserId")
);

CREATE TABLE IF NOT EXISTS "AILogs" (
    "LogId"          SERIAL PRIMARY KEY,
    "UserId"         INT,
    "ActionType"     VARCHAR(50),
    "InputData"      TEXT,
    "OutputData"     TEXT,
    "ExecutionTimeMs" INT,
    "CreatedAt"      TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_ailogs_users FOREIGN KEY ("UserId") REFERENCES "Users"("UserId")
);

-- =============================================
-- INDEXES
-- =============================================
CREATE INDEX IF NOT EXISTS idx_users_email      ON "Users"("Email");
CREATE INDEX IF NOT EXISTS idx_users_username   ON "Users"("Username");
CREATE INDEX IF NOT EXISTS idx_users_roleid     ON "Users"("RoleId");
CREATE INDEX IF NOT EXISTS idx_tour_provider    ON "Tours"("ProviderId");
CREATE INDEX IF NOT EXISTS idx_tour_category    ON "Tours"("CategoryId");
CREATE INDEX IF NOT EXISTS idx_tour_active      ON "Tours"("IsActive");
CREATE INDEX IF NOT EXISTS idx_booking_order    ON "Bookings"("OrderId");
CREATE INDEX IF NOT EXISTS idx_booking_tour     ON "Bookings"("TourId");
CREATE INDEX IF NOT EXISTS idx_order_customer   ON "Orders"("CustomerId");
CREATE INDEX IF NOT EXISTS idx_order_status     ON "Orders"("OrderStatus");
CREATE INDEX IF NOT EXISTS idx_payment_order    ON "Payments"("OrderId");
CREATE INDEX IF NOT EXISTS idx_custact_customer ON "CustomerActivities"("CustomerId");
CREATE INDEX IF NOT EXISTS idx_inthist_customer ON "InteractionHistory"("CustomerId");

-- =============================================
-- SEED DATA
-- =============================================

-- Roles
INSERT INTO "Roles" ("RoleName") VALUES ('ADMIN')    ON CONFLICT ("RoleName") DO NOTHING;
INSERT INTO "Roles" ("RoleName") VALUES ('PROVIDER') ON CONFLICT ("RoleName") DO NOTHING;
INSERT INTO "Roles" ("RoleName") VALUES ('CUSTOMER') ON CONFLICT ("RoleName") DO NOTHING;

-- Admin account (Password: 123456 - SHA256)
INSERT INTO "Users" ("Email", "Username", "PasswordHash", "RoleId", "FullName", "IsActive", "CreatedAt", "UpdatedAt")
SELECT 'admin@dananghub.com', 'admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
       r."RoleId", 'System Admin', TRUE, NOW(), NOW()
FROM "Roles" r WHERE r."RoleName" = 'ADMIN'
AND NOT EXISTS (SELECT 1 FROM "Users" WHERE "Username" = 'admin');

-- Categories
INSERT INTO "Categories" ("CategoryName", "Description") VALUES
('Tour Tham Quan', 'Tour tham quan cac diem du lich noi tieng'),
('Tour Mao Hiem', 'Tour trai nghiem mao hiem va the thao'),
('Tour Van Hoa', 'Tour tim hieu van hoa va lich su'),
('Tour Am Thuc', 'Tour kham pha am thuc dia phuong'),
('Tour Sinh Thai', 'Tour du lich sinh thai va thien nhien'),
('Tour Bien Dao', 'Tour du lich bien va dao')
ON CONFLICT DO NOTHING;

-- Subscription Plans
INSERT INTO "SubscriptionPlans" ("PlanName", "PlanCode", "Price", "DurationDays", "Description", "Features", "IsActive") VALUES
('Basic', 'BASIC', 0, 30, 'Goi mien phi co ban', 'Dang 5 tour, Hien thi co ban', TRUE),
('Premium', 'PREMIUM', 299000, 30, 'Goi nang cao', 'Dang 20 tour, Uu tien hien thi, Bao cao', TRUE),
('Gold', 'GOLD', 599000, 30, 'Goi cao cap', 'Dang khong gioi han, Uu tien #1, Bao cao chi tiet, Ho tro 24/7', TRUE)
ON CONFLICT ("PlanCode") DO NOTHING;

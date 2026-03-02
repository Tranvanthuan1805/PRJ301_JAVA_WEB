-- =============================================
-- EZTRAVEL - AI ANALYTICS DATA TABLES
-- Tạo bảng + Import data từ CSV cho AI Prediction
-- Chạy trong Supabase SQL Editor
-- =============================================

-- ===== TABLE 1: Monthly Tourism Stats =====
CREATE TABLE IF NOT EXISTS "MonthlyTourismStats" (
    "Id" SERIAL PRIMARY KEY,
    "MonthYear" VARCHAR(10) NOT NULL,
    "BookingRevenue" DECIMAL(18,2),
    "FlightRevenue" DECIMAL(18,2),
    "GuestCount" INT,
    "SeasonType" VARCHAR(50)
);

-- ===== TABLE 2: Tour Performance =====
CREATE TABLE IF NOT EXISTS "TourPerformance" (
    "Id" SERIAL PRIMARY KEY,
    "MonthYear" VARCHAR(10) NOT NULL,
    "TourName" VARCHAR(255) NOT NULL,
    "Revenue" DECIMAL(18,2),
    "AvgPrice" DECIMAL(18,2),
    "BookingCount" INT,
    "Season" VARCHAR(50)
);

-- ===== TABLE 3: Supplier Revenue =====
CREATE TABLE IF NOT EXISTS "SupplierRevenue" (
    "Id" SERIAL PRIMARY KEY,
    "MonthYear" VARCHAR(10) NOT NULL,
    "SupplierType" VARCHAR(50),
    "SupplierName" VARCHAR(255),
    "Revenue" DECIMAL(18,2),
    "AvgPrice" DECIMAL(18,2),
    "GuestCount" INT,
    "AvgTicketPrice" DECIMAL(18,2)
);

-- ===== TABLE 4: Weather Data =====
CREATE TABLE IF NOT EXISTS "WeatherData" (
    "Id" SERIAL PRIMARY KEY,
    "Date" DATE NOT NULL,
    "Temp" DECIMAL(5,1),
    "TempMin" DECIMAL(5,1),
    "TempMax" DECIMAL(5,1),
    "Humidity" INT,
    "Precipitation" DECIMAL(8,1),
    "WindSpeed" DECIMAL(5,1),
    "Pressure" DECIMAL(7,1)
);

-- Indexes for AI queries
CREATE INDEX IF NOT EXISTS idx_tourism_monthyear ON "MonthlyTourismStats"("MonthYear");
CREATE INDEX IF NOT EXISTS idx_tourperf_monthyear ON "TourPerformance"("MonthYear");
CREATE INDEX IF NOT EXISTS idx_tourperf_tourname ON "TourPerformance"("TourName");
CREATE INDEX IF NOT EXISTS idx_supplier_monthyear ON "SupplierRevenue"("MonthYear");
CREATE INDEX IF NOT EXISTS idx_weather_date ON "WeatherData"("Date");

-- Create Consultations table for EZTravel
-- Run this in Supabase SQL Editor

CREATE TABLE IF NOT EXISTS "Consultations" (
    "ConsultationId" SERIAL PRIMARY KEY,
    "FullName" VARCHAR(100) NOT NULL,
    "Email" VARCHAR(150) NOT NULL,
    "Phone" VARCHAR(20),
    "TourType" VARCHAR(50),
    "Message" TEXT,
    "Status" VARCHAR(20) DEFAULT 'new',
    "CreatedAt" TIMESTAMP DEFAULT NOW(),
    "AdminNote" TEXT
);

-- Verify
SELECT * FROM "Consultations" LIMIT 5;

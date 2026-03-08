-- Add StartDate and EndDate columns to Tours table
-- These fields control when a tour is visible/available on the system

ALTER TABLE "Tours" ADD COLUMN IF NOT EXISTS "StartDate" DATE;
ALTER TABLE "Tours" ADD COLUMN IF NOT EXISTS "EndDate" DATE;

-- Set default values for existing tours (current date to +1 year)
UPDATE "Tours" SET "StartDate" = CURRENT_DATE, "EndDate" = CURRENT_DATE + INTERVAL '365 days' WHERE "StartDate" IS NULL;

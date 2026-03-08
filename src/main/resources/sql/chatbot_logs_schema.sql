-- Create chatbot_logs table for real chatbot analytics
-- Run this in Supabase SQL Editor
CREATE TABLE IF NOT EXISTS "chatbot_logs" (
    "log_id" SERIAL PRIMARY KEY,
    "user_id" INTEGER REFERENCES "Users"("UserId") ON DELETE SET NULL,
    "session_id" VARCHAR(100),
    "question" VARCHAR(2000) NOT NULL,
    "answer" VARCHAR(5000),
    "category" VARCHAR(50),
    "sentiment" VARCHAR(20),
    "response_time_ms" BIGINT DEFAULT 0,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for analytics performance
CREATE INDEX IF NOT EXISTS idx_chatbot_logs_category ON "chatbot_logs"("category");
CREATE INDEX IF NOT EXISTS idx_chatbot_logs_created ON "chatbot_logs"("created_at");
CREATE INDEX IF NOT EXISTS idx_chatbot_logs_user ON "chatbot_logs"("user_id");

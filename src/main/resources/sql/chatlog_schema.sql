-- Create ChatLogs table for real chatbot analytics
CREATE TABLE IF NOT EXISTS "ChatLogs" (
    "LogId" SERIAL PRIMARY KEY,
    "UserId" INTEGER REFERENCES "Users"("UserId") ON DELETE SET NULL,
    "Question" VARCHAR(1000) NOT NULL,
    "Category" VARCHAR(50) DEFAULT 'other',
    "SessionId" VARCHAR(100),
    "CreatedAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster analytics queries
CREATE INDEX IF NOT EXISTS idx_chatlogs_category ON "ChatLogs"("Category");
CREATE INDEX IF NOT EXISTS idx_chatlogs_created ON "ChatLogs"("CreatedAt");

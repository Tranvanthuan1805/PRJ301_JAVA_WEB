-- =============================================
-- ADD TABLE: ProviderRegistration
-- PURPOSE: Lưu trữ đơn đăng ký làm NCC
-- DATE: 2026-03-01
-- =============================================

USE DaNangTravelHub;
GO

-- Bảng đăng ký làm NCC (chờ duyệt)
CREATE TABLE ProviderRegistrations (
    RegistrationId   INT IDENTITY(1,1) PRIMARY KEY,
    BusinessName     NVARCHAR(200) NOT NULL,
    BusinessLicense  NVARCHAR(100) NOT NULL,
    Email            NVARCHAR(100) NOT NULL,
    PhoneNumber      NVARCHAR(20) NOT NULL,
    Address          NVARCHAR(255),
    ProviderType     NVARCHAR(50) NOT NULL,  -- Hotel, Tour, Transport
    Description      NVARCHAR(MAX),
    Status           NVARCHAR(20) DEFAULT 'Pending',  -- Pending, Approved, Rejected
    SubmittedDate    DATETIME DEFAULT GETDATE(),
    ReviewedDate     DATETIME,
    ReviewedBy       INT,  -- Admin UserId
    RejectionReason  NVARCHAR(500),
    CONSTRAINT CHK_ProvReg_Status CHECK (Status IN ('Pending', 'Approved', 'Rejected')),
    CONSTRAINT CHK_ProvReg_Type CHECK (ProviderType IN ('Hotel', 'Tour', 'Transport', 'Flight'))
);

-- Index để tìm kiếm nhanh
CREATE INDEX IDX_ProvReg_Status ON ProviderRegistrations(Status);
CREATE INDEX IDX_ProvReg_Email ON ProviderRegistrations(Email);
CREATE INDEX IDX_ProvReg_SubmittedDate ON ProviderRegistrations(SubmittedDate DESC);

PRINT '✓ Tạo bảng ProviderRegistrations thành công';
GO

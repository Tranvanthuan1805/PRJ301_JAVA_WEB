-- =============================================
-- FIX: Tao cac bang con thieu trong database
-- Chay script nay trong SQL Server Management Studio
-- =============================================

USE DaNangTravelHub;
GO

-- Bang 1: TourSchedules (Lich khoi hanh cua tour)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TourSchedules')
BEGIN
    CREATE TABLE TourSchedules (
        ScheduleId     INT IDENTITY(1,1) PRIMARY KEY,
        TourId         INT NOT NULL,
        DepartureDate  DATE NOT NULL,
        ReturnDate     DATE,
        AvailableSlots INT NOT NULL DEFAULT 20,
        Status         NVARCHAR(20) DEFAULT 'Open',  -- Open, Closed, Full, Cancelled
        CONSTRAINT FK_TourSchedules_Tours FOREIGN KEY (TourId) REFERENCES Tours(TourId)
    );
    CREATE INDEX IDX_TourSchedule_Tour ON TourSchedules(TourId);
    PRINT 'Created table: TourSchedules';
END
GO

-- Bang 2: TourPriceSeasons (Gia theo mua)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TourPriceSeasons')
BEGIN
    CREATE TABLE TourPriceSeasons (
        SeasonId        INT IDENTITY(1,1) PRIMARY KEY,
        TourId          INT NOT NULL,
        SeasonName      NVARCHAR(100) NOT NULL,
        StartDate       DATE NOT NULL,
        EndDate         DATE NOT NULL,
        PriceMultiplier DECIMAL(5,2) NOT NULL DEFAULT 1.0,
        IsActive        BIT DEFAULT 1,
        CONSTRAINT FK_TourPriceSeasons_Tours FOREIGN KEY (TourId) REFERENCES Tours(TourId)
    );
    CREATE INDEX IDX_TourPriceSeason_Tour ON TourPriceSeasons(TourId);
    PRINT 'Created table: TourPriceSeasons';
END
GO

-- Bang 3: ProviderPriceHistory (Lich su gia NCC)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ProviderPriceHistory')
BEGIN
    CREATE TABLE ProviderPriceHistory (
        PriceId      INT IDENTITY(1,1) PRIMARY KEY,
        ProviderId   INT NOT NULL,
        ServiceType  NVARCHAR(50) NOT NULL,
        ServiceName  NVARCHAR(200) NOT NULL,
        OldPrice     DECIMAL(18,2),
        NewPrice     DECIMAL(18,2) NOT NULL,
        ChangeDate   DATETIME DEFAULT GETDATE(),
        Note         NVARCHAR(500),
        CONSTRAINT FK_PriceHistory_Providers FOREIGN KEY (ProviderId) REFERENCES Providers(ProviderId)
    );
    CREATE INDEX IDX_PriceHistory_Provider ON ProviderPriceHistory(ProviderId);
    PRINT 'Created table: ProviderPriceHistory';
END
GO

PRINT '==============================================';
PRINT 'DA TAO XONG CAC BANG CON THIEU!';
PRINT 'Hay restart Tomcat de kiem tra lai.';
PRINT '==============================================';

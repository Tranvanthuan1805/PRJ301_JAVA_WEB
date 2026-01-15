USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'AdminUser')
BEGIN
    ALTER DATABASE AdminUser SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE AdminUser;
END
GO

CREATE DATABASE AdminUser;
GO

USE AdminUser;
GO

CREATE TABLE Roles (
    RoleId INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(64) NOT NULL,
    RoleId INT NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleId)
        REFERENCES Roles(RoleId)
);
INSERT INTO Roles (RoleName) VALUES ('ADMIN');
INSERT INTO Roles (RoleName) VALUES ('USER');
SELECT * FROM Roles;
INSERT INTO Users (Username, PasswordHash, RoleId)
VALUES ('admin',
        '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
        1);

INSERT INTO Users (Username, PasswordHash, RoleId)
VALUES ('user1',
        '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
        2);

SELECT u.Username, u.PasswordHash, u.IsActive, r.RoleName
FROM Users u
JOIN Roles r ON u.RoleId = r.RoleId;

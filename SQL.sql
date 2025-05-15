CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    RegistrationDate DATETIME NOT NULL DEFAULT GETDATE(),
    LastLoginDate DATETIME NULL,
    IsBlocked BIT NOT NULL DEFAULT 0,
    IsAdmin BIT NOT NULL DEFAULT 0,
    IsSupport BIT NOT NULL DEFAULT 0
);

-- ������� ����� �����������
CREATE TABLE CarTypes (
    TypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(255) NULL
);

-- ������� ����� �����������
CREATE TABLE CarBrands (
    BrandID INT IDENTITY(1,1) PRIMARY KEY,
    BrandName NVARCHAR(50) NOT NULL UNIQUE,
    CountryOfOrigin NVARCHAR(50) NOT NULL
);

-- ������� ������� �����������
CREATE TABLE CarModels (
    ModelID INT IDENTITY(1,1) PRIMARY KEY,
    BrandID INT NOT NULL,
    TypeID INT NOT NULL,
    ModelName NVARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    CONSTRAINT FK_CarModels_CarBrands FOREIGN KEY (BrandID) REFERENCES CarBrands(BrandID),
    CONSTRAINT FK_CarModels_CarTypes FOREIGN KEY (TypeID) REFERENCES CarTypes(TypeID)
);

-- ������� �����������
CREATE TABLE Cars (
    CarID INT IDENTITY(1,1) PRIMARY KEY,
    ModelID INT NOT NULL,
    RegistrationNumber NVARCHAR(20) NOT NULL UNIQUE,
    Color NVARCHAR(30) NOT NULL,
    PricePerMinute DECIMAL(10,2) NOT NULL,
    FuelLevel INT NOT NULL DEFAULT 100,
    Latitude DECIMAL(12,9) NULL,
    Longitude DECIMAL(12,9) NULL,
    IsAvailable BIT NOT NULL DEFAULT 1,
    ImageURL NVARCHAR(255) NULL,
    LastMaintenance DATETIME NULL,
    CONSTRAINT FK_Cars_CarModels FOREIGN KEY (ModelID) REFERENCES CarModels(ModelID)
);

-- ������� �����
CREATE TABLE Rentals (
    RentalID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    CarID INT NOT NULL,
    StartTime DATETIME NOT NULL DEFAULT GETDATE(),
    EndTime DATETIME NOT NULL,
    ActualEndTime DATETIME NULL,
    TotalCost DECIMAL(10,2) NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Active',
    PaymentStatus NVARCHAR(20) NOT NULL DEFAULT 'Pending',
    CONSTRAINT FK_Rentals_Users FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Rentals_Cars FOREIGN KEY (CarID) REFERENCES Cars(CarID)
);

-- ������� ��������
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    RentalID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentTime DATETIME NOT NULL DEFAULT GETDATE(),
    PaymentMethod NVARCHAR(20) NOT NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Processed',
    CONSTRAINT FK_Payments_Rentals FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID)
);

-- ������� ����� ���������
CREATE TABLE SupportChats (
    ChatID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(20) NOT NULL DEFAULT 'Open',
    CONSTRAINT FK_SupportChats_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- ������� ���������
CREATE TABLE Messages (
    MessageID INT IDENTITY(1,1) PRIMARY KEY,
    ChatID INT NOT NULL,
    SenderID INT NOT NULL,
    Text NVARCHAR(MAX) NOT NULL,
    SentTime DATETIME NOT NULL DEFAULT GETDATE(),
    IsRead BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Messages_SupportChats FOREIGN KEY (ChatID) REFERENCES SupportChats(ChatID),
    CONSTRAINT FK_Messages_Users FOREIGN KEY (SenderID) REFERENCES Users(UserID)
);

-- ������� ����������
CREATE TABLE Announcements (
    AnnouncementID INT IDENTITY(1,1) PRIMARY KEY,
    CreatedBy INT NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    IsActive BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Announcements_Users FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

-- ������� ����������� ������� ��� ����������� ��������
CREATE INDEX IX_Users_Phone ON Users(Phone);
CREATE INDEX IX_Cars_IsAvailable ON Cars(IsAvailable);
CREATE INDEX IX_Cars_Location ON Cars(Latitude, Longitude);
CREATE INDEX IX_Rentals_Status ON Rentals(Status);
CREATE INDEX IX_Rentals_UserID ON Rentals(UserID);


-- ��������� �������������
INSERT INTO Users (FullName, Phone, Email, PasswordHash, RegistrationDate, LastLoginDate, IsBlocked, IsAdmin, IsSupport)
VALUES 
    ('������������� �������', '+79991234567', 'admin@carsharing.ru', 'f7d6e3a864a99cf95252db7c272c7c6c', GETDATE(), GETDATE(), 0, 1, 1),
    ('��������� �������', '+79991234568', 'support@carsharing.ru', 'f7d6e3a864a99cf95252db7c272c7c6c', GETDATE(), GETDATE(), 0, 0, 1),
    ('������ ���� ��������', '+79991234569', 'ivanov@mail.ru', 'f7d6e3a864a99cf95252db7c272c7c6c', GETDATE(), GETDATE(), 0, 0, 0),
    ('������ ���� ��������', '+79991234570', 'petrov@mail.ru', 'f7d6e3a864a99cf95252db7c272c7c6c', GETDATE(), GETDATE(), 0, 0, 0),
    ('������� ����� ���������', '+79991234571', 'sidorov@mail.ru', 'f7d6e3a864a99cf95252db7c272c7c6c', GETDATE(), GETDATE(), 0, 0, 0);

-- ��������� ���� �������
INSERT INTO CarTypes (TypeName, Description)
VALUES 
    ('�����', '������������ ��� ������ � ����������, ���������� �� ������'),
    ('�������', '��� ������ � ������ � ������ ������, �������� �� ������� �� ������'),
    ('�����������', '�������������� ���������� ���������� ������������'),
    ('���������', '���������� � �������� ������'),
    ('�������', '������������ ����� � 7-8 �������');

-- ��������� ����� �����������
INSERT INTO CarBrands (BrandName, CountryOfOrigin)
VALUES 
    ('Toyota', '������'),
    ('BMW', '��������'),
    ('Mercedes-Benz', '��������'),
    ('Lada', '������'),
    ('Hyundai', '����� �����');

-- ��������� ������ �����������
INSERT INTO CarModels (BrandID, TypeID, ModelName, Year)
VALUES 
    (1, 1, 'Camry', 2022),
    (1, 3, 'Land Cruiser', 2021),
    (2, 1, '5 Series', 2023),
    (2, 4, '4 Series Convertible', 2022),
    (3, 1, 'E-Class', 2022),
    (3, 3, 'GLE', 2023),
    (4, 1, 'Vesta', 2021),
    (4, 2, 'XRAY', 2020),
    (5, 1, 'Solaris', 2021),
    (5, 3, 'Santa Fe', 2022);

-- ��������� ����������
INSERT INTO Cars (ModelID, RegistrationNumber, Color, PricePerMinute, FuelLevel, Latitude, Longitude, IsAvailable, ImageURL, LastMaintenance)
VALUES 
    (1, '�123��72', '�����', 8.50, 95, 57.152985, 65.541227, 1, '/Images/Cars/camry.jpg', GETDATE()),
    (2, '�456��72', '������', 12.00, 85, 57.143245, 65.555481, 1, '/Images/Cars/landcruiser.jpg', GETDATE()),
    (3, '�789��72', '�����', 10.50, 90, 57.136548, 65.562835, 1, '/Images/Cars/bmw5.jpg', GETDATE()),
    (4, '�123��72', '�������', 15.00, 75, 57.146879, 65.548426, 1, '/Images/Cars/bmw4convertible.jpg', GETDATE()),
    (5, '�456��72', '�����������', 11.00, 80, 57.154128, 65.534557, 1, '/Images/Cars/eclass.jpg', GETDATE()),
    (6, '�789��72', '������', 13.50, 70, 57.162354, 65.543216, 1, '/Images/Cars/gle.jpg', GETDATE()),
    (7, '�123��72', '�����', 5.00, 85, 57.158975, 65.567891, 1, '/Images/Cars/vesta.jpg', GETDATE()),
    (8, '�456��72', '���������', 4.50, 90, 57.149632, 65.574563, 1, '/Images/Cars/xray.jpg', GETDATE()),
    (9, '�789��72', '�������', 6.00, 85, 57.141258, 65.535689, 1, '/Images/Cars/solaris.jpg', GETDATE()),
    (10, '�123��72', '����������', 9.00, 75, 57.157456, 65.529874, 1, '/Images/Cars/santafe.jpg', GETDATE());

INSERT INTO Rentals (UserID, CarID, StartTime, EndTime, ActualEndTime, TotalCost, Status, PaymentStatus)
VALUES 
    (3, 1, DATEADD(HOUR, -5, GETDATE()), DATEADD(HOUR, -3, GETDATE()), DATEADD(HOUR, -3, GETDATE()), 1020.00, 'Completed', 'Paid'),
    (4, 3, DATEADD(HOUR, -8, GETDATE()), DATEADD(HOUR, -6, GETDATE()), DATEADD(HOUR, -7, GETDATE()), 1260.00, 'Completed', 'Paid'),
    (5, 7, DATEADD(HOUR, -2, GETDATE()), DATEADD(HOUR, 1, GETDATE()), NULL, NULL, 'Active', 'Pending');

-- ��������� �������
INSERT INTO Payments (RentalID, Amount, PaymentTime, PaymentMethod, Status)
VALUES 
    (1, 1020.00, DATEADD(HOUR, -3, GETDATE()), '���������� �����', 'Completed'),
    (2, 1260.00, DATEADD(HOUR, -7, GETDATE()), '���', 'Completed');

-- ��������� ���� ���������
INSERT INTO SupportChats (UserID, CreatedAt, Status)
VALUES 
    (3, DATEADD(DAY, -2, GETDATE()), 'Closed'),
    (4, DATEADD(HOUR, -5, GETDATE()), 'Open');

-- ��������� ��������� � �����
INSERT INTO Messages (ChatID, SenderID, Text, SentTime, IsRead)
VALUES 
    (1, 3, '������������, � ���� ������ �� ������', DATEADD(DAY, -2, GETDATE()), 1),
    (1, 2, '������ ����! ��� ���� ������?', DATEADD(DAY, -2, DATEADD(MINUTE, 5, GETDATE())), 1),
    (1, 3, '�������, ������ �����', DATEADD(DAY, -2, DATEADD(MINUTE, 10, GETDATE())), 1),
    (2, 4, '������ ����! �� ���� ��������� ������', DATEADD(HOUR, -5, GETDATE()), 1),
    (2, 2, '������������! ���������� ����� ������, ����������', DATEADD(HOUR, -5, DATEADD(MINUTE, 3, GETDATE())), 1),
    (2, 4, '�789��72', DATEADD(HOUR, -5, DATEADD(MINUTE, 5, GETDATE())), 1);

-- ��������� ����������
INSERT INTO Announcements (CreatedBy, Title, Content, CreatedAt, IsActive)
VALUES 
    (1, '����������� �����������', '������ �� 6 ����� �� ���� 5 �����! ����� ��������� �� ����� ������.', DATEADD(DAY, -5, GETDATE()), 1),
    (1, '����������� ������', '��������� �������! 20 ��� � 02:00 �� 04:00 ����� ����������� ����������� ������.', DATEADD(DAY, -2, GETDATE()), 1);
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

-- Таблица типов автомобилей
CREATE TABLE CarTypes (
    TypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(255) NULL
);

-- Таблица марок автомобилей
CREATE TABLE CarBrands (
    BrandID INT IDENTITY(1,1) PRIMARY KEY,
    BrandName NVARCHAR(50) NOT NULL UNIQUE,
    CountryOfOrigin NVARCHAR(50) NOT NULL
);

-- Таблица моделей автомобилей
CREATE TABLE CarModels (
    ModelID INT IDENTITY(1,1) PRIMARY KEY,
    BrandID INT NOT NULL,
    TypeID INT NOT NULL,
    ModelName NVARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    CONSTRAINT FK_CarModels_CarBrands FOREIGN KEY (BrandID) REFERENCES CarBrands(BrandID),
    CONSTRAINT FK_CarModels_CarTypes FOREIGN KEY (TypeID) REFERENCES CarTypes(TypeID)
);

-- Таблица автомобилей
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

-- Таблица аренд
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

-- Таблица платежей
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    RentalID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentTime DATETIME NOT NULL DEFAULT GETDATE(),
    PaymentMethod NVARCHAR(20) NOT NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Processed',
    CONSTRAINT FK_Payments_Rentals FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID)
);

-- Таблица чатов поддержки
CREATE TABLE SupportChats (
    ChatID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(20) NOT NULL DEFAULT 'Open',
    CONSTRAINT FK_SupportChats_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Таблица сообщений
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

-- Таблица объявлений
CREATE TABLE Announcements (
    AnnouncementID INT IDENTITY(1,1) PRIMARY KEY,
    CreatedBy INT NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    IsActive BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Announcements_Users FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

-- Создаем необходимые индексы для оптимизации запросов
CREATE INDEX IX_Users_Phone ON Users(Phone);
CREATE INDEX IX_Cars_IsAvailable ON Cars(IsAvailable);
CREATE INDEX IX_Cars_Location ON Cars(Latitude, Longitude);
CREATE INDEX IX_Rentals_Status ON Rentals(Status);
CREATE INDEX IX_Rentals_UserID ON Rentals(UserID);


-- Добавляем пользователей
INSERT INTO Users (FullName, Phone, Email, PasswordHash, RegistrationDate, LastLoginDate, IsBlocked, IsAdmin, IsSupport)
VALUES 
    ('Администратор Системы', '+79991234567', 'admin@carsharing.ru', 'f7d6e3a864a99cf95252db7c272c7c6c', GETDATE(), GETDATE(), 0, 1, 1),
    ('Поддержка Сервиса', '+79991234568', 'support@carsharing.ru', 'f7d6e3a864a99cf95252db7c272c7c6c', GETDATE(), GETDATE(), 0, 0, 1),
    ('Иванов Иван Иванович', '+79991234569', 'ivanov@mail.ru', 'f7d6e3a864a99cf95252db7c272c7c6c', GETDATE(), GETDATE(), 0, 0, 0),
    ('Петров Петр Петрович', '+79991234570', 'petrov@mail.ru', 'f7d6e3a864a99cf95252db7c272c7c6c', GETDATE(), GETDATE(), 0, 0, 0),
    ('Сидоров Сидор Сидорович', '+79991234571', 'sidorov@mail.ru', 'f7d6e3a864a99cf95252db7c272c7c6c', GETDATE(), GETDATE(), 0, 0, 0);

-- Добавляем типы кузовов
INSERT INTO CarTypes (TypeName, Description)
VALUES 
    ('Седан', 'Классический тип кузова с багажником, отделенным от салона'),
    ('Хэтчбек', 'Тип кузова с дверью в задней стенке, багажник не отделен от салона'),
    ('Внедорожник', 'Полноприводный автомобиль повышенной проходимости'),
    ('Кабриолет', 'Автомобиль с откидным верхом'),
    ('Минивэн', 'Однообъемный кузов с 7-8 местами');

-- Добавляем марки автомобилей
INSERT INTO CarBrands (BrandName, CountryOfOrigin)
VALUES 
    ('Toyota', 'Япония'),
    ('BMW', 'Германия'),
    ('Mercedes-Benz', 'Германия'),
    ('Lada', 'Россия'),
    ('Hyundai', 'Южная Корея');

-- Добавляем модели автомобилей
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

-- Добавляем автомобили
INSERT INTO Cars (ModelID, RegistrationNumber, Color, PricePerMinute, FuelLevel, Latitude, Longitude, IsAvailable, ImageURL, LastMaintenance)
VALUES 
    (1, 'А123БВ72', 'Белый', 8.50, 95, 57.152985, 65.541227, 1, '/Images/Cars/camry.jpg', GETDATE()),
    (2, 'В456ГД72', 'Черный', 12.00, 85, 57.143245, 65.555481, 1, '/Images/Cars/landcruiser.jpg', GETDATE()),
    (3, 'Е789ЖЗ72', 'Синий', 10.50, 90, 57.136548, 65.562835, 1, '/Images/Cars/bmw5.jpg', GETDATE()),
    (4, 'И123КЛ72', 'Красный', 15.00, 75, 57.146879, 65.548426, 1, '/Images/Cars/bmw4convertible.jpg', GETDATE()),
    (5, 'М456НО72', 'Серебристый', 11.00, 80, 57.154128, 65.534557, 1, '/Images/Cars/eclass.jpg', GETDATE()),
    (6, 'П789РС72', 'Черный', 13.50, 70, 57.162354, 65.543216, 1, '/Images/Cars/gle.jpg', GETDATE()),
    (7, 'Т123УФ72', 'Белый', 5.00, 85, 57.158975, 65.567891, 1, '/Images/Cars/vesta.jpg', GETDATE()),
    (8, 'Х456ЦЧ72', 'Оранжевый', 4.50, 90, 57.149632, 65.574563, 1, '/Images/Cars/xray.jpg', GETDATE()),
    (9, 'Ш789ЩЪ72', 'Голубой', 6.00, 85, 57.141258, 65.535689, 1, '/Images/Cars/solaris.jpg', GETDATE()),
    (10, 'Ы123ЬЭ72', 'Коричневый', 9.00, 75, 57.157456, 65.529874, 1, '/Images/Cars/santafe.jpg', GETDATE());

INSERT INTO Rentals (UserID, CarID, StartTime, EndTime, ActualEndTime, TotalCost, Status, PaymentStatus)
VALUES 
    (3, 1, DATEADD(HOUR, -5, GETDATE()), DATEADD(HOUR, -3, GETDATE()), DATEADD(HOUR, -3, GETDATE()), 1020.00, 'Completed', 'Paid'),
    (4, 3, DATEADD(HOUR, -8, GETDATE()), DATEADD(HOUR, -6, GETDATE()), DATEADD(HOUR, -7, GETDATE()), 1260.00, 'Completed', 'Paid'),
    (5, 7, DATEADD(HOUR, -2, GETDATE()), DATEADD(HOUR, 1, GETDATE()), NULL, NULL, 'Active', 'Pending');

-- Добавляем платежи
INSERT INTO Payments (RentalID, Amount, PaymentTime, PaymentMethod, Status)
VALUES 
    (1, 1020.00, DATEADD(HOUR, -3, GETDATE()), 'Банковская карта', 'Completed'),
    (2, 1260.00, DATEADD(HOUR, -7, GETDATE()), 'СБП', 'Completed');

-- Добавляем чаты поддержки
INSERT INTO SupportChats (UserID, CreatedAt, Status)
VALUES 
    (3, DATEADD(DAY, -2, GETDATE()), 'Closed'),
    (4, DATEADD(HOUR, -5, GETDATE()), 'Open');

-- Добавляем сообщения в чатах
INSERT INTO Messages (ChatID, SenderID, Text, SentTime, IsRead)
VALUES 
    (1, 3, 'Здравствуйте, у меня вопрос по аренде', DATEADD(DAY, -2, GETDATE()), 1),
    (1, 2, 'Добрый день! Чем могу помочь?', DATEADD(DAY, -2, DATEADD(MINUTE, 5, GETDATE())), 1),
    (1, 3, 'Спасибо, вопрос решен', DATEADD(DAY, -2, DATEADD(MINUTE, 10, GETDATE())), 1),
    (2, 4, 'Добрый день! Не могу завершить аренду', DATEADD(HOUR, -5, GETDATE()), 1),
    (2, 2, 'Здравствуйте! Подскажите номер машины, пожалуйста', DATEADD(HOUR, -5, DATEADD(MINUTE, 3, GETDATE())), 1),
    (2, 4, 'Е789ЖЗ72', DATEADD(HOUR, -5, DATEADD(MINUTE, 5, GETDATE())), 1);

-- Добавляем объявления
INSERT INTO Announcements (CreatedBy, Title, Content, CreatedAt, IsActive)
VALUES 
    (1, 'Специальное предложение', 'Аренда на 6 часов по цене 5 часов! Акция действует до конца месяца.', DATEADD(DAY, -5, GETDATE()), 1),
    (1, 'Технические работы', 'Уважаемые клиенты! 20 мая с 02:00 до 04:00 будут проводиться технические работы.', DATEADD(DAY, -2, GETDATE()), 1);
CREATE TABLE Users ( --get from ada's account management service
    UserId SERIAL PRIMARY KEY,
    FirstName varChar(30),
    LastName varChar(30),
    DOR DATE,
    Rank varChar(3),
    AFSC varChar(5),
    ExtendedData TEXT,
    Unit varChar(30),
    SessionUserId INT
);

CREATE TABLE Categories (
    CategoryId SERIAL PRIMARY KEY,
    CategoryName varChar(30)
);

CREATE TABLE Bullets (
    BulletId SERIAL PRIMARY KEY,
    UserId INT REFERENCES Users(UserId),
    StartDate DATE,
    EndDate DATE,
    CreationDate Date,
    Strength INT,
    CategoryId INT REFERENCES Categories(CategoryId),
    BulletFormat TEXT,
    BulletAction TEXT,
    BulletImpact TEXT,
    BulletResult TEXT,
    BulletNarrative TEXT,
    Summary TEXT
);
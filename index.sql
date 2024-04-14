-- Table creation
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    Email VARCHAR(100),
    Password VARCHAR(50),
    SubscriptionID INT,
    FOREIGN KEY (SubscriptionID) REFERENCES Subscriptions(SubscriptionID)
);

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(100),
    ReleaseDate DATE,
    GenreID INT,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(50)
);

CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY,
    UserID INT,
    MovieID INT,
    Rating INT,
    ReviewText TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY,
    SubscriptionType VARCHAR(20),
    MonthlyPrice DECIMAL(6,2)
);

-- Sample data insertion
INSERT INTO Users (UserID, Username, Email, Password, SubscriptionID) VALUES
(1, 'user1', 'user1@example.com', 'password123', 1),
(2, 'user2', 'user2@example.com', 'password456', 2);

INSERT INTO Movies (MovieID, Title, ReleaseDate, GenreID) VALUES
(1, 'Movie 1', '2023-01-01', 1),
(2, 'Movie 2', '2022-05-15', 2);

INSERT INTO Genres (GenreID, GenreName) VALUES
(1, 'Action'),
(2, 'Drama');

INSERT INTO Reviews (ReviewID, UserID, MovieID, Rating, ReviewText) VALUES
(1, 1, 1, 4, 'Great movie!'),
(2, 2, 2, 3, 'Good storyline.');

INSERT INTO Subscriptions (SubscriptionID, SubscriptionType, MonthlyPrice) VALUES
(1, 'Basic', 9.99),
(2, 'Premium', 15.99);

INSERT INTO Users (UserID, Username, Email, Password, SubscriptionID) 
VALUES (3, 'user3', 'user3@example.com', 'password789', 1);

UPDATE Movies SET Title = 'Updated Movie Title' WHERE MovieID = 1;

DELETE FROM Reviews WHERE ReviewID = 2;

SELECT Movies.Title, Genres.GenreName 
FROM Movies 
INNER JOIN Genres ON Movies.GenreID = Genres.GenreID;

SELECT Movies.Title, AVG(Reviews.Rating) AS AvgRating 
FROM Movies 
LEFT JOIN Reviews ON Movies.MovieID = Reviews.MovieID 
GROUP BY Movies.Title;

SELECT Users.Username 
FROM Users 
INNER JOIN Reviews ON Users.UserID = Reviews.UserID 
WHERE Reviews.MovieID = 1;

SELECT * FROM Users WHERE SubscriptionID IN (SELECT SubscriptionID FROM Subscriptions WHERE SubscriptionType = 'Premium');
SELECT Movies.Title, AVG(Reviews.Rating) AS AvgRating 
FROM Movies 
LEFT JOIN Reviews ON Movies.MovieID = Reviews.MovieID 
GROUP BY Movies.Title 
ORDER BY AvgRating DESC 
LIMIT 5;
SELECT DISTINCT Users.UserID, Users.Username 
FROM Users 
INNER JOIN Reviews ON Users.UserID = Reviews.UserID 
INNER JOIN Movies ON Reviews.MovieID = Movies.MovieID 
WHERE Movies.ReleaseDate > '2023-01-01';

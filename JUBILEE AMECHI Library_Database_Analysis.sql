-- NAME: JUBILEE AMECHI
-- Library Database


-- 1. Create the Library Database
CREATE DATABASE IF NOT EXISTS LibraryDB;

-- 2. Use the LibraryDB Database
USE LibraryDB;

-- 3. Create Books Table with Constraints
CREATE TABLE IF NOT EXISTS Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    PublishedYear YEAR NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    ISBN VARCHAR(13) UNIQUE NOT NULL,
    AvailabilityStatus BOOLEAN DEFAULT TRUE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Insert Sample Data into Books Table
INSERT INTO Books (Title, Author, PublishedYear, Genre, ISBN, AvailabilityStatus)
VALUES 
    ('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Fiction', '9780743273565', TRUE),
    ('1984', 'George Orwell', 1949, 'Dystopian', '9780451524935', TRUE),
    ('To Kill a Mockingbird', 'Harper Lee', 1960, 'Classic', '9780060935467', FALSE),
    ('Pride and Prejudice', 'Jane Austen', 1813, 'Romance', '9780141040349', TRUE),
    ('Moby Dick', 'Herman Melville', 1851, 'Adventure', '9781503280786', TRUE);

-- 5. Add an Index on Title and Author for Faster Searching
CREATE INDEX idx_title_author ON Books (Title, Author);

-- 6. Update Availability Status of "1984" to Unavailable
SET SQL_SAFE_UPDATES = 0;  -- Disable Safe Update Mode
UPDATE Books
SET AvailabilityStatus = FALSE
WHERE Title = '1984';

-- 7. Delete "To Kill a Mockingbird" from Books Table
DELETE FROM Books
WHERE Title = 'To Kill a Mockingbird';

-- 8. Retrieve All Available Books
SELECT * FROM Books WHERE AvailabilityStatus = TRUE;

-- 9. Retrieve Books by a Specific Author
SELECT * FROM Books WHERE Author = 'George Orwell';

-- 10. Retrieve Books Published Before 1950
SELECT * FROM Books WHERE PublishedYear < 1950;

-- 11. Retrieve the Total Number of Books in the Library
SELECT COUNT(*) AS TotalBooks FROM Books;

-- 12. Retrieve the Most Recently Added Book
SELECT * FROM Books ORDER BY CreatedAt DESC LIMIT 1;

-- 13. Drop the Books Table (Use with Caution)
 DROP TABLE IF EXISTS Books;

-- 14. Drop the Library Database (Use with Caution)
 DROP DATABASE IF EXISTS LibraryDB;

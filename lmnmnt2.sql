--Delete statements for tables
Delete from Transaction;
Delete from Member;
Delete from Book;
Delete from Publisher;
Delete from Author;


INSERT INTO Author (AuthorID, FirstName, LastName, BirthDate, Country) VALUES
(1, 'J.K.', 'Rowling', '1965-07-31', 'United Kingdom'),
(2, 'George', 'Orwell', '1903-06-25', 'United Kingdom'),
(3, 'Mark', 'Twain', '1835-11-30', 'United States'),
(4, 'Jane', 'Austen', '1775-12-16', 'United Kingdom'),
(5, 'Leo', 'Tolstoy', '1828-09-09', 'Russia'),
(6, 'Charles', 'Dickens', '1812-02-07', 'United Kingdom'),
(7, 'F. Scott', 'Fitzgerald', '1896-09-24', 'United States'),
(8, 'Herman', 'Melville', '1819-08-01', 'United States'),
(9, 'Ernest', 'Hemingway', '1899-07-21', 'United States'),
(10, 'Harper', 'Lee', '1926-04-28', 'United States');


INSERT INTO Publisher (PublisherID, Name, Address, Phone, Email) VALUES
(1, 'Penguin Random House', '1745 Broadway, New York, NY 10019, USA', '212-782-9000', 'contact@penguinrandomhouse.com'),
(2, 'HarperCollins', '195 Broadway, New York, NY 10007, USA', '212-207-7000', 'contact@harpercollins.com'),
(3, 'Macmillan Publishers', '120 Broadway, New York, NY 10271, USA', '646-307-5151', 'contact@macmillan.com'),
(4, 'Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020, USA', '212-698-7000', 'contact@simonandschuster.com'),
(5, 'Hachette Livre', '43 Quai de Grenelle, 75015 Paris, France', '01-43-92-30-00', 'contact@hachette.com'),
(6, 'Scholastic', '557 Broadway, New York, NY 10012, USA', '212-343-6100', 'contact@scholastic.com'),
(7, 'Oxford University Press', 'Great Clarendon Street, Oxford, OX2 6DP, UK', '44-1865-556767', 'contact@oup.com'),
(8, 'Cambridge University Press', 'University Printing House, Cambridge, CB2 8BS, UK', '44-1223-358331', 'contact@cambridge.org'),
(9, 'Bloomsbury Publishing', '50 Bedford Square, London, WC1B 3DP, UK', '44-20-7631-5600', 'contact@bloomsbury.com'),
(10, 'Pearson', '80 Strand, London, WC2R 0RL, UK', '44-20-7010-2000', 'contact@pearson.com');


INSERT INTO Book (BookID, Title, AuthorID, PublisherID, Genre, YearPublished, CopiesAvailable) VALUES
(1, 'Harry Potter and the Philosopher', 1, 6, 'Fantasy', 1997, 10),
(2, '1984', 2, 1, 'Dystopian', 1949, 5),
(3, 'The Adventures of Tom Sawyer', 3, 4, 'Adventure', 1876, 7),
(4, 'Pride and Prejudice', 4, 7, 'Romance', 1813, 8),
(5, 'War and Peace', 5, 8, 'Historical', 1869, 4),
(6, 'A Tale of Two Cities', 6, 5, 'Historical', 1859, 6),
(7, 'The Great Gatsby', 7, 2, 'Novel', 1925, 9),
(8, 'Moby Dick', 8, 3, 'Adventure', 1851, 3),
(9, 'The Old Man and the Sea', 9, 1, 'Literary', 1952, 4),
(10, 'To Kill a Mockingbird', 10, 2, 'Novel', 1960, 5);



INSERT INTO Member (MemberID, FirstName, LastName, Phone, Email, Address, MembershipDate) VALUES
(1, 'John', 'Doe', '555-1234', 'johndoe@example.com', '123 Elm Street, Springfield, IL', '2020-01-15'),
(2, 'Jane', 'Smith', '555-5678', 'janesmith@example.com', '456 Oak Avenue, Springfield, IL', '2021-03-22'),
(3, 'Alice', 'Johnson', '555-8765', 'alicejohnson@example.com', '789 Pine Road, Springfield, IL', '2019-07-30'),
(4, 'Bob', 'Brown', '555-4321', 'bobbrown@example.com', '101 Maple Lane, Springfield, IL', '2022-05-10'),
(5, 'Charlie', 'Davis', '555-2468', 'charliedavis@example.com', '202 Birch Drive, Springfield, IL', '2020-09-18'),
(6, 'Diana', 'Miller', '555-1357', 'dianamiller@example.com', '303 Cedar Court, Springfield, IL', '2021-11-24'),
(7, 'Eve', 'Wilson', '555-9753', 'evewilson@example.com', '404 Aspen Way, Springfield, IL', '2018-04-05'),
(8, 'Frank', 'Taylor', '555-8642', 'franktaylor@example.com', '505 Redwood Street, Springfield, IL', '2019-12-12'),
(9, 'Grace', 'Anderson', '555-7531', 'graceanderson@example.com', '606 Willow Terrace, Springfield, IL', '2022-06-14'),
(10, 'Hank', 'Thomas', '555-6420', 'hankthomas@example.com', '707 Cypress Hill, Springfield, IL', '2021-10-20');

INSERT INTO Transaction (BookID, MemberID, BorrowDate, ReturnDate, DueDate, Status) VALUES
(1, 1, '2023-01-01', '2023-01-10', '2023-01-15', 'Returned'),
(2, 2, '2023-02-01', '2023-02-10', '2023-02-15', 'Returned'),
(3, 3, '2023-03-01', '2023-03-10', '2023-03-15', 'Returned'),
(4, 4, '2023-04-01', '2023-04-10', '2023-04-15', 'Returned'),
(5, 5, '2023-05-01', '2023-05-10', '2023-05-15', 'Returned'),
(6, 6, '2023-06-01', '2023-06-10', '2023-06-15', 'Returned'),
(7, 7, '2023-07-01', '2023-07-10', '2023-07-15', 'Returned'),
(8, 8, '2023-08-01', '2023-08-10', '2023-08-15', 'Returned'),
(9, 9, '2023-09-01', '2023-09-10', '2023-09-15', 'Returned'),
(10, 10, '2023-10-01', NULL, '2023-10-15', 'Borrowed');

--Stored Procedure to Add a New Member
CREATE OR REPLACE FUNCTION AddMember(
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_Phone VARCHAR(20),
    IN p_Email VARCHAR(50),
    IN p_Address VARCHAR(255),
    IN p_MembershipDate DATE
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Member (FirstName, LastName, Phone, Email, Address, MembershipDate)
    VALUES (p_FirstName, p_LastName, p_Phone, p_Email, p_Address, p_MembershipDate);
    
    RAISE NOTICE 'Member % % added successfully', p_FirstName, p_LastName;
END;
$$;


--Stored Procedure to Add a New Book
CREATE OR REPLACE FUNCTION AddBook(
    
    p_Title VARCHAR(255),
    p_AuthorID INT,
    p_PublisherID INT,
    p_Genre VARCHAR(50),
    p_YearPublished INT,
    p_CopiesAvailable INT
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Book (Title, AuthorID, PublisherID, Genre, YearPublished, CopiesAvailable)
    VALUES (p_Title, p_AuthorID, p_PublisherID, p_Genre, p_YearPublished, p_CopiesAvailable);
    
    RAISE NOTICE 'Book % added successfully', p_Title;
END;
$$;


--Refreshing materialized view
REFRESH Materialized View Member_Transaction_Summary_MV;
REFRESH Materialized View Book_Borrowing_Summary_MV;

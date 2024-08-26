/*Project Name: Library Management System
Description:
Developed a comprehensive Library Management System designed to manage book inventory, member transactions, and user roles. The system supports the automation of common library operations and 
provides analytical insights through materialized views and reporting.

Key Features:
->Database Design & Management:
-Designed and implemented relational database tables for Authors, Publishers, Books, Members, and Transactions with appropriate foreign key relationships.
-Created and managed views (Customer_Details, Book_Details) and materialized views (Member_Transaction_Summary_MV, Book_Borrowing_Summary_MV) to summarize transaction 
data and provide insights into library activities.
->Automation & Triggers:
-Developed triggers for automatically updating CopiesAvailable in the Book table when a transaction is inserted, updated, or deleted.
-Implemented a trigger to automatically set the due date for borrowed books based on the borrow date.
->Stored Procedures:
-Created stored procedures for adding new members and books (AddMember, AddBook), which enforce business rules and ensure data integrity.
-Implemented error handling and user feedback mechanisms using PL/pgSQL.
->Data Population & Sample Data:
-Inserted sample data into the system, including 10 authors, 10 publishers, 10 books, 10 members, and 10 transactions, to simulate real-world library operations.
-Demonstrated proficiency in SQL by performing bulk data insertions and maintaining data consistency across related tables.
->Analytics & Reporting:
-Generated analytical reports through materialized views, providing summaries of member transactions and book borrowing statistics.
-Implemented a system to track book popularity and availability, offering valuable insights for library management decisions.
->Technologies Used:
Database: PostgreSQL
Database Management: Views, Materialized Views, Triggers, Stored Procedures
Tools: pgAdmin
*/

-- Drop materialized views that depend on the tables
-- These views must be removed before the tables they depend on can be dropped
DROP MATERIALIZED VIEW IF EXISTS Book_Borrowing_Summary_MV;
Drop Materialized View if exists Member_Transaction_Summary_MV;

-- Drop views that depend on the tables
-- These views are dropped before the underlying tables are removed
DROP VIEW IF EXISTS Customer_Details;
DROP VIEW IF EXISTS Book_Details;

--Trigger to automatically update CopiesAvailable in Book Table When a Transaction is Inserted or Updated
-- Trigger Function to Update CopiesAvailable
CREATE OR REPLACE FUNCTION update_copies_available() 
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        IF NEW.Status = 'Borrowed' THEN
            UPDATE Book
            SET CopiesAvailable = CopiesAvailable - 1
            WHERE BookID = NEW.BookID;
        END IF;
    ELSIF TG_OP = 'UPDATE' THEN
        IF NEW.Status = 'Returned' AND OLD.Status <> 'Returned' THEN
            UPDATE Book
            SET CopiesAvailable = CopiesAvailable + 1
            WHERE BookID = NEW.BookID;
        ELSIF NEW.Status = 'Borrowed' AND OLD.Status <> 'Borrowed' THEN
            UPDATE Book
            SET CopiesAvailable = CopiesAvailable - 1
            WHERE BookID = NEW.BookID;
        END IF;
    ELSIF TG_OP = 'DELETE' THEN
        IF OLD.Status = 'Borrowed' THEN
            UPDATE Book
            SET CopiesAvailable = CopiesAvailable + 1
            WHERE BookID = OLD.BookID;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Trigger to Automatically Set DueDate in Transaction Table When a Book is Borrowed
-- Trigger Function to Set DueDate
CREATE OR REPLACE FUNCTION set_due_date() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Status = 'Borrowed' AND NEW.DueDate IS NULL THEN
        NEW.DueDate = NEW.BorrowDate + INTERVAL '14 days'; -- Setting due date to 14 days after borrow date
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Drop tables that are being recreated
-- The drop statements ensure that the existing tables are removed without leaving dependencies
Drop table if exists Transaction;
Drop table if exists Member;
Drop table if exists Book;
Drop table if exists Publisher;
Drop table if exists Author;

--creating table Author
create table Author(
AuthorID Serial Primary key,
FirstName varchar(50),
LastName varchar(50),
BirthDate Date,
Country varchar(50)
);

--creating table Publisher
create table Publisher(
PublisherID Serial primary key,
Name varchar(100),
Address varchar (255),
Phone varchar (20),
Email varchar (100)
);

--creating table Book
Create table Book(
BookID SERIAL primary key,
Title varchar(255),
AuthorID int,
PublisherID int,
Genre varchar(50),
YearPublished int,
CopiesAvailable int,
Foreign key (AuthorID) references Author(AuthorID),
Foreign key (PublisherID) references Publisher(PublisherID)
);

--creating table Member
create table Member(
MemberID Serial Primary key,
FirstName varchar(50),
LastName varchar(50),
Phone Varchar(20),
Email varchar(50),
Address varchar(255),
MembershipDate date
);

--creating table Transaction
create table Transaction(
TransactionID Serial Primary Key,
BookID int,
MemberID int,
BorrowDate date,
ReturnDate date,
DueDate date,
Status varchar(10),
Foreign key (BookID) references Book(BookID),
foreign key (MemberID) references Member(MemberID)
);


-- Customer_Details view provides a comprehensive view of transactions by members including book and author details
CREATE VIEW Customer_Details AS 
SELECT  
    m.FirstName AS Member_FirstName,
    m.LastName AS Member_LastName,
    a.FirstName AS Author_FirstName,
    a.LastName AS Author_LastName,
    p.Name AS Publisher_Name,
    b.Title AS Book_Title,
    t.TransactionID,
    t.BorrowDate,
    t.ReturnDate
FROM 
    Member m
JOIN 
    Transaction t ON t.MemberID = m.MemberID 
JOIN 
    Book b ON b.BookID = t.BookID
JOIN 
    Author a ON a.AuthorID = b.AuthorID
JOIN 
    Publisher p ON p.PublisherID = b.PublisherID;

-- Book_Details view provides a summary of book information including author and publisher details
    CREATE VIEW Book_Details AS
SELECT 
    b.BookID, 
    b.Title, 
    a.FirstName AS Author_FirstName, 
    a.LastName AS Author_LastName, 
    p.Name AS Publisher_Name, 
    b.Genre, 
    b.YearPublished, 
    b.CopiesAvailable
FROM 
    Book b
JOIN 
    Author a ON b.AuthorID = a.AuthorID
JOIN 
    Publisher p ON b.PublisherID = p.PublisherID;


-- Member_Transaction_Summary_MV provides a summary of the total number of transactions and books borrowed per member
CREATE MATERIALIZED VIEW Member_Transaction_Summary_MV AS
SELECT
    m.MemberID,
    m.FirstName,
    m.LastName,
    COUNT(t.TransactionID) AS Total_Transactions,
    COUNT(t.BookID) AS Total_Books_Borrowed
FROM
    Member m
JOIN
    Transaction t ON m.MemberID = t.MemberID
GROUP BY
    m.MemberID,
    m.FirstName,
    m.LastName;

-- Materialized view to summarize book borrowing statistics
CREATE MATERIALIZED VIEW Book_Borrowing_Summary_MV AS
SELECT
    b.BookID,
    b.Title AS Book_Title,
    a.FirstName || ' ' || a.LastName AS Author_Name,
    p.Name AS Publisher_Name,
    COUNT(t.TransactionID) AS Total_Borrows,
    b.CopiesAvailable AS Copies_Available,
    b.CopiesAvailable - COALESCE(SUM(
        CASE
            WHEN t.Status = 'Returned' THEN 0
            ELSE 1
        END
    ), 0) AS Net_Copies_Available
FROM
    Book b
JOIN
    Author a ON b.AuthorID = a.AuthorID
JOIN
    Publisher p ON b.PublisherID = p.PublisherID
LEFT JOIN
    Transaction t ON b.BookID = t.BookID
GROUP BY
    b.BookID,
    b.Title,
    a.FirstName,
    a.LastName,
    p.Name,
    b.CopiesAvailable
ORDER BY
    Total_Borrows DESC;


    
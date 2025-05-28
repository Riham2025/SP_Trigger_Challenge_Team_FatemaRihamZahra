--1. AFTER INSERT Trigger: Log New Book Additions
-- Create an audit table for books
CREATE TABLE Book_Audit (
    audit_id INT PRIMARY KEY IDENTITY,
    book_id INT NOT NULL,
    title VARCHAR(20) NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    action_date DATETIME DEFAULT GETDATE()
);
-- AFTER INSERT trigger on books table
CREATE TRIGGER trg_AfterInsertBook
ON books
AFTER INSERT
AS
BEGIN
    INSERT INTO Book_Audit (book_id, title, action_type)
    SELECT book_id, title, 'New Book Added'
    FROM INSERTED;
END;
-- Test the trigger
INSERT INTO books (ISBM, title, genre, price, avail_status, shelf_location, library_id)
VALUES (9781011, 'Gardening Basics', 'Non-fiction', 8.500, 1, 'B4', 2);
-- Verify the audit table
SELECT * FROM Book_Audit;

--2. UPDATE trigger on loan table
CREATE TRIGGER trg_UpdateBookStatusAfterLoan
ON loan
AFTER INSERT
AS
BEGIN
   -- Update the book's availability status to 0 (borrowed)
    UPDATE books
    SET avail_status = 0
    FROM books
    INNER JOIN inserted i ON books.book_id = i.book_id
END;
INSERT INTO loan (loan_id, book_id, member_id, loan_date, due_date, return_date, status)
VALUES (11, 6, 4, '2025-05-28', '2025-06-11', '2025-06-10', 'issued');
select * from books
INSERT INTO loan (loan_id, book_id, member_id, loan_date, due_date, return_date, status)
VALUES (12, 1, 4, '2025-05-28', '2025-06-11', '2025-06-10', 'Reference');
select * from books
select * from loan
select * from member


-- 3.  INSTEAD OF DELETE Trigger: Prevent Direct Deletion of Libraries

-- INSTEAD OF DELETE trigger on libraries table
CREATE TRIGGER trg_InsteadOfDeleteLibrary
ON libraries
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR ('Deletion of library records is not allowed. Please contact database administrator.', 16, 1);
END;
GO

-- Test the trigger: This should fail
DELETE FROM libraries
WHERE name = 'NPL';


-- Verify that the library still exists
SELECT * FROM libraries WHERE name = 'NPL';
GO

-- delete table has trigger 
 DROP TABLE books;

--  data doesn’t meet the condition inside trigger
 CREATE TRIGGER trg_PreventNegativePrice
ON books
AFTER INSERT
AS
BEGIN
   IF EXISTS (SELECT * FROM inserted WHERE price < 0)
   BEGIN
       RAISERROR('Price cannot be negative.', 16, 1);
       ROLLBACK TRANSACTION; -- Rollback the transaction if condition is met
   END
   END;
   -- Test the trigger
   INSERT INTO books (ISBM, title, genre, price, avail_status, shelf_location, library_id)
   VALUES (9781012, 'Negative Price Book', 'Fiction', -5.00, 1, 'B5', 1);
   -- This will raise an error and rollback the transaction


-- ========================== alter trigger =========================
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Book_Audit') AND name = 'ISBM')
BEGIN
    ALTER TABLE Book_Audit
    ADD ISBM INT; -- Assuming ISBM is INT as in the books table
    PRINT 'Column ISBM added to Book_Audit table.';
END
ELSE
BEGIN
    PRINT 'Column ISBM already exists in Book_Audit table. Skipping addition.';
END;
GO

ALTER TRIGGER trg_AfterInsertBook
ON books
AFTER INSERT
AS
BEGIN
    -- Modified logic: now also inserting ISBM
    INSERT INTO Book_Audit (book_id, title, ISBM, action_type)
    SELECT book_id, title, ISBM, 'New Book Added'
    FROM INSERTED;
END;
GO

INSERT INTO books (ISBM, title, genre, price, avail_status, shelf_location, library_id)
VALUES (9781013, 'Ocean Mysteries', 'Non-fiction', 12.000, 1, 'F1', 3);
GO

-- Verify the audit table to see the new ISBM
SELECT * FROM Book_Audit WHERE title = 'Ocean Mysteries';
GO

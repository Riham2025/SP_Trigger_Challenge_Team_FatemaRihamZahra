﻿ # 🧠 Apply Stored Procedure in Practice  

📌 <ins>Use a real-life case for Library System:</ins>

   ✅ Create meaningful stored procedures:

     --Stored Action: Update Book Status
    CREATE PROCEDURE UpdateBookStatus -- Stored Procedure: UpdateBookStatus
    @BookID INT,
     @NewStatus VARCHAR(20)
    AS
    BEGIN
    UPDATE Book -- Purpose: Updates the status of a specific book in the Book table based on its ID.
	-- Parameters:
    SET Statu = @NewStatus  --The new status to assign to the book.
    WHERE BID = @BookID; --The ID of the book (BID) whose status will be updated.
    END;
    select * from Book
     -- Example Usage:
     EXEC UpdateBookStatus @BookID = 1, @NewStatus = 'Returned'; --EXEC UpdateBookStatus 1, 'Returned'
     select * from Book

   ![](./image/sp1.png)

 # 🧠 Explore and Practice for  Stored Procedure:

✅ Create, execute, alter, and drop stored procedures 

✅ Input/output parameters 


 -- Alter the existing stored procedure 'UpdateBookStatus'

           ALTER PROCEDURE UpdateBookStatus
    @BookID INT,               -- Input parameter: ID of the book to update
    @NewStatus VARCHAR(20)     -- Input parameter: New status to assign to the book
     AS
            BEGIN
    -- Check if the new status is 'Overdue'; if so, prevent the update
    IF @NewStatus = 'Overdue'
    BEGIN
        -- Raise an error message and exit the procedure
        RAISERROR('Cannot manually set status to Overdue.', 16, 1);
        RETURN;
    END

    -- Update the book's status in the Book table
    UPDATE Book
    SET Statu = @NewStatus
    WHERE BID = @BookID;
     END;


        select * from Book
        -- Example Usage:
        EXEC UpdateBookStatus @BookID = 1, @NewStatus = 'Overdue'; --EXEC UpdateBookStatus 1, 'Overdue'
       select * from Book

       ---------------------------------------------------------



  -- -- Drop the stored procedure 'UpdateBookStatus'

              DROP PROCEDURE IF EXISTS UpdateBookStatus;
    select * from Book
    -- Example Usage:
       EXEC UpdateBookStatus @BookID = 1, @NewStatus = 'Issued'; --EXEC UpdateBookStatus 1, 'Issued'
    select * from Book


![](./image/sp3.png)

![](./image/sp4.png)

✅ Using conditions, variables, loops 


-- stored procedured with conditions 
-- Create a stored procedure to update book status with conditional logic

              CREATE PROCEDURE UpdateBookStatusWithCheck

    @BookID INT,               -- Input parameter: ID of the book to update
    @NewStatus VARCHAR(20)     -- Input parameter: New status to set for the book
           AS
            BEGIN
    -- Declare a variable to hold the current status of the book

    DECLARE @CurrentStatus VARCHAR(20);

    -- Retrieve the current status of the book from the Book table
    SELECT @CurrentStatus = Statu
    FROM Book
    WHERE BID = @BookID;

    -- Check if the current status is 'Returned'
    IF @CurrentStatus = 'Returned'
    BEGIN
        -- If the book is already returned, print a message and do not update
        PRINT 'The book is already returned. No update performed.';
    END
    ELSE
    BEGIN
             -- If the book is not returned, proceed to update the status
        UPDATE Book
        SET Statu = @NewStatus
        WHERE BID = @BookID;

        -- Print a confirmation message
        PRINT 'Book status updated successfully.';
    END
      END;

      
            -- Example: Update the status of the book with ID 1 to 'Returned'
        select * from book 
          EXEC UpdateBookStatusWithCheck @BookID = 3, @NewStatus = 'Issued';
           select * from book 



           
-- stored procedure with loop 
-- Stored Procedure: PrintNumbers
-- This procedure prints numbers from 1 to 5 using a WHILE loop.

               CREATE PROCEDURE PrintNumbers
            AS
          BEGIN
       DECLARE @Counter INT = 1; -- Initialize counter variable

    WHILE @Counter <= 5
    BEGIN
        PRINT @Counter; -- Output the current value of the counter
        SET @Counter = @Counter + 1; -- Increment the counter
    END
      END;

          exec PrintNumbers 

![](./image/sp5if_no.png)

![](./image/sp5if_yes.png)

![](./image/sp6Loop.png)

# 🧠 Exploration Checklist

✅ What happens if procedure has a syntax error? 


-- with syntax error 

            CREATE PROCEDURE PrintNumbers
         AS
              BEGIN
    -- DECLARE @Counter INT = 1; -- Initialize counter variable

    WHILE @Counter <= 5
    BEGIN
        PRINT @Counter; -- Output the current value of the counter
        SET @Counter = @Counter + 1; -- Increment the counter
    END
            END;

![](./image/sp7SynatxError.png)


![](./image/sp9SyntaxError.png)

✅ Can a procedure call another procedure?

--Can a procedure call another procedure? 
-- Define the inner procedure

        CREATE PROCEDURE InnerProcedure
     AS
        BEGIN
    PRINT 'Inner procedure executed.';
        END;
       GO

      -- Define the outer procedure that calls the inner one
        CREATE PROCEDURE OuterProcedure
           AS
           BEGIN
    PRINT 'Outer procedure started.';
    EXEC InnerProcedure;  -- Calling the inner procedure
    PRINT 'Outer procedure ended.';
       END;
       GO

         -- Execute the outer procedure
           EXEC OuterProcedure;


![](./image/sp8SpCallingAnotherSp.png)


✅ Try logic Error in stored procedures:


-- Attempting to create a stored procedure with intentional syntax errors

            CREATE PROCEDURE sp_UpdateBookStatus
    @BookID INT
    @NewStatus VARCHAR(20) 
        AS
           BEGIN
    UPDATE Books
    SET Statu = @NewStatus
    WHERE BID = @BookID

         END

![](./image/sp9IncorrectDataTypeError.png)


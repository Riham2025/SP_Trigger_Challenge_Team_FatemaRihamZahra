 # 🧠 Apply Stored Procedure in Practice  

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

![](./image/sp5if_no.png)

![](./image/sp5if_yes.png)

![](./image/sp6Loop.png)

# 🧠 Exploration Checklist

✅ What happens if procedure has a syntax error? 

![](./image/sp7SynatxError.png)


![](./image/sp9SyntaxError.png)

✅ Can a procedure call another procedure?

![](./image/sp8SpCallingAnotherSp.png)


✅ Try logic Error in stored procedures:


![](./image/sp9IncorrectDataTypeError.png)


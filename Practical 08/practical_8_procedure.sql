Database Setup (Table Creation)
Before creating the procedure, lets assume we have an Accounts table:
CREATE TABLE Accounts (
    Account_No NUMBER PRIMARY KEY,
    Holder_Name VARCHAR2(100),
    Balance NUMBER
);

-- Insert sample data

INSERT INTO Accounts VALUES (101, 'Alice', 5000);
INSERT INTO Accounts VALUES (102, 'Bob', 3000);
COMMIT;

PL/SQL Procedure for Fund Transfer
CREATE OR REPLACE PROCEDURE transfer_funds(
    sender_acc IN NUMBER,
    receiver_acc IN NUMBER,
    amount IN NUMBER
) IS
    sender_balance NUMBER;
BEGIN
    -- Check sender's balance
    SELECT Balance INTO sender_balance FROM Accounts WHERE Account_No = sender_acc;

    -- Ensure sufficient funds
    IF sender_balance < amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient Balance!');
    END IF;

    -- Deduct amount from sender
    UPDATE Accounts SET Balance = Balance - amount WHERE Account_No = sender_acc;

    -- Add amount to receiver
    UPDATE Accounts SET Balance = Balance + amount WHERE Account_No = receiver_acc;

    -- Commit transaction
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Transfer Successful: ' || amount || ' transferred from ' || sender_acc || ' to ' || receiver_acc);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Invalid Account Number!');
    WHEN OTHERS THEN
        ROLLBACK;  -- Undo changes in case of errors
        RAISE_APPLICATION_ERROR(-20003, 'Transaction Failed: ' || SQLERRM);
END;
/

Executing the Procedure
To transfer ₹1000 from account 101 to 102, run:
BEGIN
    transfer_funds(102, 101, 1000);
END;
/

Verifying the Transfer
Check balances after transfer:
SELECT * FROM Accounts;
If Alice had 5000 and Bob had 3000, after transferring 1000:
Account_No | Holder_Name | Balance
-----------|------------|---------
101        | Alice      | 4000
102        | Bob        | 4000

Output verifies
	 Validation: Checks if the sender has enough balance.
	 Error Handling: Catches invalid account numbers & transaction failures.
	 Rollback on Failure: Ensures data consistency.
	 Commit on Success: Finalizes the transaction.


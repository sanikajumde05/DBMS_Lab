Example 1: BEFORE INSERT Trigger
--Automatically set a default balance when a new account is created.
CREATE OR REPLACE TRIGGER before_insert_accounts
BEFORE INSERT ON Accounts
FOR EACH ROW
BEGIN
    -- Set a default balance if not provided
    IF :NEW.Balance IS NULL THEN
        :NEW.Balance := 1000;
    END IF;
END;
/
Execution & Testing
INSERT INTO Accounts (Account_No, Holder_Name) VALUES (103, 'Charlie');  
SELECT * FROM Accounts WHERE Account_No = 103;
	If the Balance was not provided, it will be automatically set to 1000.

Example 2: BEFORE DELETE Trigger
Prevent deletion of accounts with a balance > 0.
CREATE OR REPLACE TRIGGER prevent_account_deletion
BEFORE DELETE ON Accounts
FOR EACH ROW
BEGIN
    IF :OLD.Balance > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Cannot delete an account with a positive balance!');
    END IF;
END;
/
Execution & Testing
DELETE FROM Accounts WHERE Account_No = 101;
	If the balance is greater than 0, it will prevent deletion.
Example 3: BEFORE UPDATE Trigger
CREATE TABLE emp (
    emp_id    NUMBER PRIMARY KEY,
    name      VARCHAR2(50),
    salary    NUMBER
);

CREATE TABLE emp_audit (
    audit_id   NUMBER PRIMARY KEY,
    emp_id     NUMBER,
    old_salary NUMBER,
    new_salary NUMBER,
    change_date TIMESTAMP DEFAULT SYSTIMESTAMP,
    changed_by VARCHAR2(100)
);

Create a Sequence for audit_id (since Oracle 11g doesn’t support identity)

CREATE SEQUENCE emp_audit_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

Create the UPDATE Trigger

CREATE OR REPLACE TRIGGER trg_emp_update
AFTER UPDATE ON emp
FOR EACH ROW
BEGIN
    INSERT INTO emp_audit (audit_id, emp_id, old_salary, new_salary, changed_by)
    VALUES (emp_audit_seq.NEXTVAL, :OLD.emp_id, :OLD.salary, :NEW.salary, USER);
END;
/

Insert Sample Data

INSERT INTO emp (emp_id, name, salary) VALUES (1, 'Alice', 5000);
INSERT INTO emp (emp_id, name, salary) VALUES (2, 'Bob', 6000);
COMMIT;

Update Employee Salary

UPDATE emp SET salary = 7000 WHERE emp_id = 1;
COMMIT;

Check Audit Log
SELECT * FROM emp_audit;

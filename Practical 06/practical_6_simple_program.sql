--First 
SET SERVEROUTPUT ON; //to see output

--Simple PL/SQL Program
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL!');
END;
/
🔹 Explanation:
•	DBMS_OUTPUT.PUT_LINE is used to print output.
•	BEGIN starts the PL/SQL block, and END; marks its end.
•	/ executes the block in SQL*Plus or SQL Developer.

--Conditional Statement (IF-THEN-ELSE)
DECLARE
    num NUMBER := 10;
BEGIN
    IF MOD(num, 2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE(num || ' is Even');
    ELSE
        DBMS_OUTPUT.PUT_LINE(num || ' is Odd');
    END IF;
END;
/

EXAMPLES:
1.	Executes a block of code only if the condition is TRUE.
2.	Executes one block of code if the condition is TRUE, otherwise executes the ELSE block.
3.	Multiple conditions are checked sequentially.

ACCEPT v_marks  NUMBER PROMPT 'Enter your marks: ';

BEGIN
    IF &v_marks >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('Grade: A');
    ELSIF &v_marks >= 75 THEN
        DBMS_OUTPUT.PUT_LINE('Grade: B');
    ELSIF &v_marks >= 50 THEN
        DBMS_OUTPUT.PUT_LINE('Grade: C');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Grade: Fail');
    END IF;
END;
Looping (FOR LOOP)
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE('Number: ' || i);
    END LOOP;
END;
/


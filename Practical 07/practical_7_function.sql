PL/SQL Function to Convert Decimal to Binary
CREATE OR REPLACE FUNCTION decimal_to_binary(n IN NUMBER) RETURN VARCHAR2 IS
    binary_str VARCHAR2(100) := '';
    num NUMBER := n;
BEGIN
    IF num = 0 THEN
        RETURN '0';
    END IF;
    
    WHILE num > 0 LOOP
        binary_str := MOD(num, 2) || binary_str;  -- Get remainder (0 or 1) and prepend to result
        num := TRUNC(num / 2);  -- Divide by 2 and remove decimal part
    END LOOP;
    
    RETURN binary_str;
END;
/

Explanation
1.	Function decimal_to_binary(n IN NUMBER) RETURN VARCHAR2 
o	Accepts a decimal number (n) as input and returns a binary string.
2.	Logic: 
o	A loop continuously divides the number by 2.
o	The remainder (MOD(num,2)) is stored at the beginning of binary_str to maintain correct order.
o	The number is updated (TRUNC(num/2)) until it becomes 0.
3.	Edge Case: 
o	If n = 0, the function directly returns '0'.
    

**How to Execute the Function**
--Run the following SQL query to test the function:
SELECT decimal_to_binary(10) FROM DUAL;
Output:
1010


1.	SELECT decimal_to_binary(15) FROM DUAL;  
2.	SELECT decimal_to_binary(7) FROM DUAL;   
3.	SELECT decimal_to_binary(0) FROM DUAL; 
4.	SELECT decimal_to_binary(a) FROM DUAL; 
5.	SELECT decimal_to_binary(1.5) FROM DUAL; 
6.	SELECT decimal_to_binary(-4) FROM DUAL;

SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION CheckEvenOddCount RETURN VARCHAR2 IS
  evenCount NUMBER := 0;
  oddCount NUMBER := 0;
BEGIN
  SELECT COUNT(*) INTO evenCount
  FROM MyTable
  WHERE MOD(val, 2) = 0;

  SELECT COUNT(*) INTO oddCount
  FROM MyTable
  WHERE MOD(val, 2) <> 0;

  IF evenCount > oddCount THEN
    RETURN 'TRUE';
  ELSIF evenCount < oddCount THEN
    RETURN 'FALSE';
  ELSE
    RETURN 'EQUAL';
  END IF;
END;
/
declare
    res VARCHAR2(255);
begin
    res:= CheckEvenOddCount();
    DBMS_OUTPUT.PUT_LINE(res);
end;


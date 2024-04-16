DECLARE
  n INTEGER := 10;
BEGIN
  FOR i IN 1..n LOOP
    INSERT INTO MyTable (id, val)
    VALUES (i, ROUND(DBMS_RANDOM.VALUE(1, 100)));
  END LOOP;
  
  COMMIT;
  
  DBMS_OUTPUT.PUT_LINE('10 000 записей успешно добавлены.');
END;
/
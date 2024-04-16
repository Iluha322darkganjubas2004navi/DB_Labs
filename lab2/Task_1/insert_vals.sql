insert into groups(id,name,c_val) values (null,'153504',0)


insert into students (id,name,group_id) values(null, 'kiryl mam4',1)

DECLARE
  n INTEGER := 10;
BEGIN
  FOR i IN 1..n LOOP
    INSERT INTO students (id, name, group_id)
    VALUES (null, 'testStudent', 1);
  END LOOP;
  
  COMMIT;
  
  DBMS_OUTPUT.PUT_LINE('10 записей успешно добавлены.');
END;
/
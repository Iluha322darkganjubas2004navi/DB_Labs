insert into groups(id,name,c_val) values (null,'153504',0)

DELETE FROM groups WHERE id = 1;
delete_students_by_name('Имя_студента_для_удаления');
ALTER TRIGGER trigger_update_c_val ENABLE;

  
insert into students (id,name,group_id) values(null, 'Silniy chel',1)

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

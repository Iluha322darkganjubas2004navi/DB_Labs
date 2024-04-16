CREATE OR REPLACE FUNCTION GenerateInsertStatement(
  p_id NUMBER
) RETURN VARCHAR2 IS
  v_val NUMBER;
  v_insert_statement VARCHAR2(200);
BEGIN
  -- Получение значения val для указанного id
  SELECT val INTO v_val
  FROM MyTable
  WHERE id = p_id;

  -- Генерация текста команды INSERT
  v_insert_statement := 'INSERT INTO MyTable (id, val) VALUES (' || p_id || ', ' || v_val || ')';

  -- Вывод команды INSERT в консоль
  DBMS_OUTPUT.PUT_LINE(v_insert_statement);

  RETURN v_insert_statement;
END;
/

DECLARE
  v_insert_statement VARCHAR2(200);
BEGIN
  v_insert_statement := GenerateInsertStatement(1);
END;
/
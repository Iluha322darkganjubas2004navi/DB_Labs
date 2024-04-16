CREATE OR REPLACE PROCEDURE InsertRecord(
    p_id IN NUMBER,
    p_val IN NUMBER
)
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM MyTable WHERE id = p_id;

    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Запись с указанным ID уже существует.');
    ELSE
        INSERT INTO MyTable(id, val) VALUES (p_id, p_val);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Запись успешно вставлена.');
    END IF;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Запись с указанным ID уже существует.');
    WHEN OTHERS THEN
        -- Обработка исключений
        DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE UpdateRecord(
    p_id IN NUMBER,
    p_new_val IN NUMBER
)
IS
    p_checker NUMBER;
BEGIN
    SELECT COUNT(*) INTO p_checker FROM MyTable
    WHERE id = p_id;
    IF p_checker = 1 THEN
        UPDATE MyTable SET val = p_new_val WHERE id = p_id;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Запись успешно обновлена.');
    ELSIF p_checker = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Запись с указанным ID не найдена.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Обработка исключений
        DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE DeleteRecord(
    p_id IN NUMBER
)
IS
    p_checker NUMBER;
BEGIN

    SELECT COUNT(*) INTO p_checker FROM MyTable
    WHERE id = p_id;
    
    IF p_checker !=1 THEN
        DBMS_OUTPUT.PUT_LINE('Запись с указанным ID не найдена.');
    ELSE
        DELETE FROM MyTable WHERE id = p_id;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Запись успешно удалена.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Обработка исключений
        DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
        ROLLBACK;
END;
/
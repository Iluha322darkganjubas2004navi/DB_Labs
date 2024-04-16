create or replace NONEDITIONABLE PROCEDURE restore_students_log(
    target_timestamp TIMESTAMP,
    offset_interval INTERVAL DAY TO SECOND DEFAULT NULL
)
IS
    v_target_date TIMESTAMP;
BEGIN

    EXECUTE IMMEDIATE 'ALTER TRIGGER studens_id_unique DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER auto_increment_id_students DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER students_insert_logs DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER students_update_logs DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER students_delete_logs DISABLE';

    IF offset_interval IS NOT NULL THEN
        v_target_date := SYSTIMESTAMP - offset_interval;
    ELSE
        v_target_date := target_timestamp;
    END IF;

    FOR log_rec IN (
        SELECT * FROM LOGS_STUDENTS
        WHERE ACTION_DATE >= v_target_date
        ORDER BY ACTION_DATE DESC, ID DESC )
    LOOP
        DBMS_OUTPUT.PUT_LINE('[er');
        IF log_rec.ACTION_TYPE = 'Insert' THEN
            
            DELETE FROM STUDENTS
            WHERE ID = log_rec.STUDENT_ID;
        ELSIF log_rec.ACTION_TYPE = 'Update' THEN
            UPDATE STUDENTS
            SET NAME = log_rec.OLD_NAME, GROUP_ID = log_rec.OLD_GROUP_ID
            WHERE ID = log_rec.STUDENT_ID;
        ELSIF log_rec.ACTION_TYPE = 'Delete' THEN
            INSERT INTO STUDENTS (id, name, group_id)
            VALUES (log_rec.STUDENT_ID, log_rec.OLD_NAME, log_rec.OLD_GROUP_ID);
        END IF;
    END LOOP;
    
    EXECUTE IMMEDIATE 'ALTER TRIGGER studens_id_unique ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER auto_increment_id_students ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER students_insert_logs ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER students_update_logs ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER students_delete_logs ENABLE';
EXCEPTION
    WHEN OTHERS THEN
        EXECUTE IMMEDIATE 'ALTER TRIGGER studens_id_unique ENABLE';
        EXECUTE IMMEDIATE 'ALTER TRIGGER auto_increment_id_students ENABLE';
        EXECUTE IMMEDIATE 'ALTER TRIGGER students_insert_logs ENABLE';
        EXECUTE IMMEDIATE 'ALTER TRIGGER students_update_logs ENABLE';
        EXECUTE IMMEDIATE 'ALTER TRIGGER students_delete_logs ENABLE';
END;
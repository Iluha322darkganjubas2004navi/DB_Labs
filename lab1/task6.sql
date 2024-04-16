/*6*/
CREATE OR REPLACE FUNCTION calculate_total_compensation(
    p_monthly_salary IN NUMBER,
    p_annual_bonus_percentage IN NUMBER
) RETURN NUMBER
IS
    v_annual_bonus_factor NUMBER;
    v_total_compensation NUMBER;
BEGIN
    -- Проверка на корректность ввода
    IF p_monthly_salary <= 0 OR p_annual_bonus_percentage < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Некорректные данные.');
    END IF;

    -- Преобразование процента в десятичную дробь
    v_annual_bonus_factor := (p_annual_bonus_percentage / 100) + 1;

    -- Вычисление общего вознаграждения за год
    v_total_compensation := (v_annual_bonus_factor * 12 * p_monthly_salary);

    RETURN v_total_compensation;
EXCEPTION
    WHEN OTHERS THEN
        -- Обработка исключений
        DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
        RETURN NULL;
END;
/

DECLARE
    v_monthly_salary NUMBER := 5000;
    v_annual_bonus_percentage NUMBER := 10;
    v_total_compensation NUMBER;
BEGIN
    v_total_compensation := calculate_total_compensation(v_monthly_salary, v_annual_bonus_percentage);
    DBMS_OUTPUT.PUT_LINE('Общее вознаграждение за год: ' || v_total_compensation);
END;
/
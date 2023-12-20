use dbEnrollment;

-- JOINS

-- Ejemplo 1 de JOIN para obtener los cursos dictados por un profesor en una carrera
SELECT c.names AS course_name, t.names AS teacher_name, ca.names AS career_name
FROM careers_detail cd
JOIN course c ON cd.course_code = c.code
JOIN teachers t ON cd.teachers_id = t.id
JOIN careers ca ON cd.careers_id = ca.id
WHERE t.id = 1 AND ca.id = 2


-- Ejemplo 2: Obtener la información de los vendedores y la sede donde trabajan
SELECT se.names AS seller_name, ca.name AS campus_name
FROM seller se
JOIN campus ca ON se.place = ca.place;

-- Ejemplo 3: Obtener la información de los cursos y sus créditos
SELECT c.names AS course_name, c.credits AS course_credits
FROM course c;

-- CURSORES

-- Declarar variables para almacenar los datos
DECLARE @seller_name VARCHAR(100);
DECLARE @campus_name VARCHAR(100);

-- Declarar un cursor para recorrer los registros
DECLARE seller_cursor CURSOR FOR
    SELECT se.names AS seller_name, ca.name AS campus_name
    FROM seller se
    JOIN campus ca ON se.place = ca.place;

-- Abrir el cursor y obtener el primer registro
OPEN seller_cursor;
FETCH NEXT FROM seller_cursor INTO @seller_name, @campus_name;

-- Recorrer los registros y realizar operaciones
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Operaciones con los datos obtenidos
    PRINT 'Seller: ' + @seller_name + ', Campus: ' + @campus_name;

    -- Obtener el siguiente registro
    FETCH NEXT FROM seller_cursor INTO @seller_name, @campus_name;
END

-- Cerrar el cursor
CLOSE seller_cursor;
DEALLOCATE seller_cursor;


-- Ejemplo de procedimiento almacenado para obtener información de profesores y cursos
CREATE PROCEDURE GetTeacherCourseInfo
AS
BEGIN
    SELECT t.names AS teacher_name, c.names AS course_name
    FROM teachers t
    JOIN teachers_course tc ON t.id = tc.teacher_id
    JOIN course c ON tc.course_code = c.code;
END;

sp_helptext 'GetTeacherCourseInfo'


-- Ejemplo de procedimiento almacenado para obtener información de ventas por vendedor
CREATE PROCEDURE GetSalesBySeller
    @seller_id INT
AS
BEGIN
    SELECT product_name, sale_amount
    FROM sales
    WHERE seller_id = @seller_id;
END;

-- Ejemplo de procedimiento almacenado en T-SQL para obtener información de empleados por departamento
CREATE PROCEDURE GetEmployeesByDepartment
    @department_id INT
AS
BEGIN
    SELECT employee_name, position
    FROM employees
    WHERE department_id = @department_id;
END;

-- Bloque T-SQL para obtener todos los estudiantes activos
BEGIN
    SELECT id, names, last_names, email, register_date, birthday
    FROM student
    WHERE status = 'A';
END;


-- Bloque T-SQL para obtener todos los cursos activos
BEGIN
    SELECT code, names, credits
    FROM course
    WHERE status = 'A';
END;












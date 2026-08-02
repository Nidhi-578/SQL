--1.Create a table from hr.employees that contains only the columns: employee_id, first_name, last_name, 
--salary, department_id.
CREATE TABLE employees_backup AS
SELECT employee_id,
       first_name,
       last_name,
       salary,
       department_id
FROM hr.employees;

--2. Alter that table to add a column effective_date of type DATE.
ALTER TABLE employees_backup
ADD effective_date DATE;

--3. Truncate the backup table you created (so it is empty but the structure remains).
TRUNCATE TABLE employees_backup;
--M1. Create a table hr_dept_backup as a full copy of hr.departments.
--Hint: CREATE TABLE hr_dept_backup AS SELECT * FROM hr.departments;
CREATE TABLE hr_dept_backup AS SELECT * FROM hr.departments;
--M2. Add a column notes VARCHAR2(100) to hr_emp_backup.
--Hint: ALTER TABLE hr_emp_backup ADD notes VARCHAR2(100);
ALTER TABLE hr_emp_backup ADD notes VARCHAR2(100);
--M3. Create a table emp_50 from employees in department 50 only (all columns).
--Hint: CREATE TABLE emp_50 AS SELECT * FROM hr.employees WHERE department_id = 50;
CREATE TABLE emp_50 AS SELECT * FROM hr.employees WHERE department_id = 50;
--M4. Add column updated_at DATE DEFAULT SYSDATE to your backup table.
--Hint: ALTER TABLE ... ADD updated_at DATE DEFAULT SYSDATE;
ALTER TABLE employees_backup ADD updated_at DATE DEFAULT SYSDATE;

--M5. Create a table dept_names with only department_id and department_name from hr.departments.
--Hint: CREATE TABLE dept_names AS SELECT department_id, department_name FROM hr.departments;
CREATE TABLE dept_names AS SELECT department_id, department_name FROM hr.departments;
--M6. Modify column notes in hr_emp_backup to VARCHAR2(500).
--Hint: ALTER TABLE hr_emp_backup MODIFY notes VARCHAR2(500);
ALTER TABLE hr_emp_backup MODIFY notes VARCHAR2(500)
--M7. Create an empty table emp_structure with the same structure as hr.employees (no rows).
--Hint: CREATE TABLE emp_structure AS SELECT * FROM hr.employees WHERE 1=0;
CREATE TABLE emp_structure AS SELECT * FROM hr.employees WHERE 1=0;
--M8. Rename table hr_emp_backup to hr_employees_archive.
--Hint: RENAME hr_emp_backup TO hr_employees_archive;
RENAME hr_emp_backup TO hr.employees_archive;
--M9. Add two columns to a backup table: created_by VARCHAR2(50) and created_date DATE.
--Hint: Two ALTER TABLE ... ADD statements (or one ADD with two columns if your Oracle version allows).
ALTER TABLE employees_backup ADD (created_by VARCHAR2(50),created_date DATE);
--M10. Display job_id, salary, and a column salary_band that is the literal 'Standard' for every row.
--Hint: Add 'Standard' AS salary_band in SELECT.
select job_id,salary, 'Standard' as salary_band from hr.employees;

--M11. List employee_id, first_name, last_name, and a column display_name as "Last, First" (last_name, comma space, first_name).
--Hint: last_name || ', ' || first_name AS display_name.
select employee_id,first_name,last_name, last_name||','||first_name as display_name from hr.employees;

--M12. Show department_id from hr.departments and a literal 1 as column sort_order.
--Hint: SELECT department_id, 1 AS sort_order FROM hr.departments.
SELECT department_id, 1 AS sort_order FROM hr.departments

--M13. From hr.employees, display salary and monthly_net as salary * 0.85 (assuming 15% tax).
--Hint: salary * 0.85 AS monthly_net.
select salary,salary * 0.85 AS monthly_net from hr.employees;

--M14. List employee_id, commission_pct, and commission_display where NULL commission_pct is shown as 0 using NVL.
--Hint: NVL(commission_pct, 0) AS commission_display.
select employee_id,commission_pct,NVL(commission_pct, 0) AS commission_display from hr.employees;

--M15. Display first_name, last_name, salary, and a column compensation that is salary * (1 + NVL(commission_pct, 0)).
--Hint: Total comp = salary + salarycommission_pct; factor as salary(1 + NVL(commission_pct,0)).
select first_name,last_name,salary,salary * (1 + NVL(commission_pct, 0)) AS compensation from hr.employees

--M16. From hr.departments, list department_name and a literal column region with value 'HQ'.
--Hint: SELECT department_name, 'HQ' AS region FROM hr.departments.
select department_name,'HQ' as region from hr.departments;

--M17. Show employee_id, hire_date, and a column years_label with literal 'Years of service'.
--Hint: Add a string literal with alias years_label.
select employee_id,hire_date,'Years of service' as years_label from hr.employees;

--M18. List employee_id, salary, and double_salary as salary * 2.
--Hint: Simple arithmetic expression with alias.
select employee_id,salary,salary*2 as double_salary from hr.employees;
--M19. From hr.employees, display manager_id and a column has_manager that is the literal 'Yes' when manager_id is not null
--and 'No' when manager_id is null (use NVL2: NVL2(manager_id, 'Yes', 'No')).
--Hint: NVL2(manager_id, 'Yes', 'No') AS has_manager.

select manager_id,NVL2(manager_id, 'Yes', 'No') AS has_manager from hr.employees;

--M20. Show department_id, department_name from hr.departments, and a calculated column dept_code as the first 3 characters of 
--department_name (use SUBSTR).
--Hint: SUBSTR(department_name, 1, 3) AS dept_code.
select department_id,department_name,SUBSTR(department_name, 1, 3) AS dept_code from hr.departments;

-------------------------------------------------------------------------------------------------------
--H1. Display employee_id, first_name, last_name, salary, and a column salary_rank_label that is 'High' if salary >= 10000, 'Medium' 
--if salary >= 5000 and < 10000, else 'Low'. Use CASE.
--Hint: CASE WHEN salary >= 10000 THEN 'High' WHEN salary >= 5000 THEN 'Medium' ELSE 'Low' END.
select employee_id,first_name,last_name,salary,
CASE
WHEN salary >= 10000 THEN 'High' 
WHEN salary >= 5000 THEN 'Medium'
ELSE 'Low' 
END AS salary_rank_label
from hr.employees;

--H2. List employee_id, salary, commission_pct, and total_comp as salary + (salary * NVL(commission_pct, 0)), formatted to 2 decimal places
--using ROUND(..., 2).
--Hint: ROUND(salary * (1 + NVL(commission_pct,0)), 2) AS total_comp.
select employee_id,salary,ROUND(salary * (1 + NVL(commission_pct,0)), 2) AS total_comp from hr.employees;

--H3. From hr.employees, show employee_id, email, and email_upper as UPPER(email). Also show email_length as LENGTH(email).
--Hint: Use UPPER(email) and LENGTH(email) with aliases.
select employee_id,email,UPPER(email) as email_upper, LENGTH(email) as email_length from hr.employees;
--H4. Display department_id from hr.departments, department_name, and a column name_length (number of characters in department_name).
--Hint: LENGTH(department_name) AS name_length.
select department_id,department_name,LENGTH(department_name) AS name_length from hr.departments;

--H5. List employee_id, first_name, last_name, and a column reverse_name as last_name concatenated with first_name (no comma).
--Hint: last_name || first_name AS reverse_name (add space if you want).
select employee_id,first_name,last_name,last_name || first_name AS reverse_name from hr.employees;

--H6. Add a column that has a DEFAULT expression using SYSDATE and rename an existing column in the same table (two statements).
--Hint: ALTER ADD ... DEFAULT SYSDATE; ALTER RENAME COLUMN ... TO ...;
Alter Table hr_dept_backup add created_date DATE default sysdate;
DESC hr_dept_backup;
Alter Table hr_dept_backup rename column department_name to dept_name;

--H7. Create a table emp_top_sal with the same structure as hr.employees but only rows where salary is in the top 10 
--(use subquery: WHERE salary IN (SELECT ... ORDER BY salary DESC FETCH FIRST 10 ROWS ONLY)).
--Hint: CREATE TABLE emp_top_sal AS SELECT * FROM hr.employees WHERE salary IN (SELECT salary FROM hr.employees ORDER BY 
--salary DESC FETCH FIRST 10 ROWS ONLY); Note: may duplicate if ties.

create table emp_top_sal as select * from hr.employees where salary in(select salary from hr.employees order by salary desc fetch first 10
rows only);

--H8. Create table dept_emp_list with department_id, department_name, and employee_count (count of employees per department).
--Hint: CREATE TABLE dept_emp_list AS SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS employee_count FROM
--hr.departments d LEFT JOIN hr.employees e ON e.department_id = d.department_id GROUP BY d.department_id, d.department_name;
create table dept_emp_list as select d.department_id,d.department_name,count(e.employee_id) as employee_count from
hr.departments d left join hr.employees e on e.department_id=d.department_id group by d.department_id,d.department_name;

--H9. Drop two columns from your backup table in one statement (if Oracle supports: ALTER TABLE ... DROP (col1, col2)).
--Hint: ALTER TABLE ... DROP (col1, col2); or two separate DROP COLUMN statements.
alter table hr_dept_backup drop(created_by,created_date)
desc hr_dept_backup

--H10. Create a table that contains only employees whose manager_id is not null and department_id is not null (all columns).
--Hint: CREATE TABLE emp_with_mgr_dept AS SELECT * FROM hr.employees WHERE manager_id IS NOT NULL AND department_id IS NOT NULL;
CREATE TABLE emp_with_mgr_dept AS SELECT * FROM hr.employees WHERE manager_id IS NOT NULL AND department_id IS NOT NULL;

desc emp_with_mgr_dept

--H11. Add a column salary_band VARCHAR2(10) and update it with CASE (Low/Medium/High) based on salary; then add DEFAULT 'Medium' for new rows.
--Hint: ADD column; UPDATE ... SET salary_band = CASE ...; then MODIFY column DEFAULT 'Medium' if needed.
CREATE TABLE emp_backup AS
SELECT * FROM hr.employees;

alter table emp_backup add salary_band varchar(10);

update emp_backup
set salary_band =
case
    when salary < 5000 then 'Low'
    when salary between 5000 and 10000 then 'Medium'
    else 'High'
end;

alter table emp_backup
modify salary_band default 'Medium';

select employee_id,
       first_name,
       salary,
       salary_band
from emp_backup
order by salary;

--H12. Create table emp_duplicate_check with employee_id, first_name, last_name, and a column dup_count showing how many employees
--share the same first_name and last_name (use analytic or self-join in CTAS).
--Hint: Use a subquery with COUNT(*) OVER (PARTITION BY first_name, last_name) AS dup_count in the SELECT.

create table emp_duplicate_check as select employee_id,first_name,last_name,count(*) over (partition by first_name,last_name)as dup_count from
hr.employees; 

--H13. Create an empty table with the same structure as hr.employees and name it emp_import_staging.
--Hint: CREATE TABLE emp_import_staging AS SELECT * FROM hr.employees WHERE 1=0;

CREATE TABLE emp_import_staging AS SELECT * FROM hr.employees WHERE 1=0;

--H14. Modify the data type of a column from NUMBER to VARCHAR2 (e.g. store employee_id as string). Oracle may require add new column, update,
--drop old, rename.
--Hint: Add new VARCHAR2 column; UPDATE set new = TO_CHAR(old); DROP old; RENAME new to old.
alter table emp_backup add employee_id_new varchar(20);
update emp_backup set employee_id_new= to_char(employee_id)
alter table emp_backup drop column employee_id;
alter table emp_backup rename column employee_id_new to employee_id

--H15.H15. Create table dept_location_1700 from hr.departments where location_id = 1700.
--Hint: CREATE TABLE dept_location_1700 AS SELECT * FROM hr.departments WHERE location_id = 1700;
CREATE TABLE dept_location_1700 AS SELECT * FROM hr.departments WHERE location_id = 1700

--H16. Add column version NUMBER DEFAULT 1 and last_modified DATE DEFAULT SYSDATE to backup table.
--Hint: Two ALTER TABLE ADD statements.
alter table dept_location_1700 add(
version number default 1,
last_modified date default sysdate
);

--H17. Create table emp_salary_range with columns from hr.employees but only for salary between 5000 and 15000.
--Hint: CREATE TABLE emp_salary_range AS SELECT * FROM hr.employees WHERE salary BETWEEN 5000 AND 15000;
CREATE TABLE emp_salary_range AS SELECT * FROM hr.employees WHERE salary BETWEEN 5000 AND 15000;
desc emp_salary_range;

--H18. Truncate a table and then add a new column. Verify the table has 0 rows.
--Hint: TRUNCATE TABLE ...; ALTER TABLE ... ADD ...; SELECT COUNT(*) FROM ...;
select * from emp_salary_range;
truncate table emp_salary_range;
alter table emp_salary_range add Remarks varchar(20);

--H19. Create table job_list with distinct job_id from hr.employees and a literal column category with value 'HR'.
--Hint: CREATE TABLE job_list AS SELECT DISTINCT job_id, 'HR' AS category FROM hr.employees;
CREATE TABLE job_list AS SELECT DISTINCT job_id, 'HR' AS category FROM hr.employees;

--H20. Drop table emp_structure if it exists (Oracle: use PL/SQL EXECUTE IMMEDIATE 'DROP TABLE emp_structure'; 
--with exception when table does not exist, or check user_tables first).
--Hint: BEGIN EXECUTE IMMEDIATE 'DROP TABLE emp_structure'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
--END; (942 = table does not exist).

begin
  execute immediate 'drop table emp_structures';
exception
  when others then
      if SQLCODE != -942 then
         RAISE;
      end if;
end;































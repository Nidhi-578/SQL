--Question 1
--Simulate a transaction: (a) Update salary for one employee in your backup table, (b) Create a savepoint,
--(c) Update another employee salary, (d) Rollback to the savepoint, (e) Commit. After (e), which change(s) are permanent?

UPDATE hr_emp_backup SET salary = salary * 1.05 WHERE employee_id = 100;

-- (b) Savepoint
SAVEPOINT after_first;
-- (c) Second update
UPDATE hr_emp_backup SET salary = salary * 1.10 WHERE employee_id = 101;

-- (d) Rollback to savepoint (undoes only the second update)
ROLLBACK TO SAVEPOINT after_first;

-- (e) Commit
COMMIT;

--M1. After updating one row in hr_emp_backup, issue COMMIT. Then run a SELECT to verify.
--Hint: UPDATE ... ; COMMIT; SELECT * FROM hr_emp_backup WHERE ... ;

select * from hr_emp_backup;
update hr_emp_backup
set first_name='Steve'
where employee_id=100

rollback;

--M2. Update two different rows in hr_emp_backup, then ROLLBACK. Verify both changes are undone.
--Hint: Two UPDATEs; ROLLBACK; SELECT to confirm original values.

-- Update first employee
UPDATE hr_emp_backup
SET salary = salary * 1.05
WHERE employee_id = 100;

-- Update second employee
UPDATE hr_emp_backup
SET salary = salary * 1.10
WHERE employee_id = 101;

-- Undo both updates
ROLLBACK;

-- Verify employee 100
SELECT *
FROM hr_emp_backup
WHERE employee_id = 100;

-- Verify employee 101
SELECT *
FROM hr_emp_backup
WHERE employee_id = 101;

--M3. Create a savepoint after one UPDATE, then do another UPDATE, then ROLLBACK TO SAVEPOINT. What is the state before COMMIT?
--Hint: First update remains in transaction; second is undone.

--  Update first employee
UPDATE hr_emp_backup
SET salary = salary * 1.05
WHERE employee_id = 100;

savepoint sp

-- Update second employee
UPDATE hr_emp_backup
SET salary = salary * 1.10
WHERE employee_id = 101;

-- Undo both updates
ROLLBACK;

commit;

-- Verify employee 100
SELECT *
FROM hr_emp_backup
WHERE employee_id = 100;

-- Verify employee 101
SELECT *
FROM hr_emp_backup
WHERE employee_id = 101;

--M4. Write the SQL to GRANT SELECT on hr.employees to a role named hr_select_role (run as HR if you have access).
--Hint: CREATE ROLE hr_select_role; GRANT SELECT ON hr.employees TO hr_select_role;
CREATE ROLE hr_select_role;
GRANT SELECT ON hr.employees TO hr_select_role;

--M5. Revoke SELECT on hr.departments from a user (use a placeholder user name).
--Hint: REVOKE SELECT ON hr.departments FROM some_user;
REVOKE SELECT ON hr.departments FROM steve;

--M6. In one transaction, update salary for employee_id 100, create savepoint sp1, update salary for employee_id 101, 
--then ROLLBACK TO sp1, then COMMIT. Who has the new salary?
--Hint: Only employee 100; 101's update was rolled back.
--  Update first employee
UPDATE hr_emp_backup
SET salary = salary * 1.05
WHERE employee_id = 100;

savepoint sp

-- Update second employee
UPDATE hr_emp_backup
SET salary = salary * 1.10
WHERE employee_id = 101;

-- Undo both updates
ROLLBACK;

commit;

-- Verify employee 100
SELECT *
FROM hr_emp_backup
WHERE employee_id = 100;

-- Verify employee 101
SELECT *
FROM hr_emp_backup
WHERE employee_id = 101;

--M7. Grant INSERT and UPDATE on hr_emp_backup to a role (your own backup table in your schema).
--Hint: GRANT INSERT, UPDATE ON hr_emp_backup TO your_role;
CREATE ROLE backup_edit_role;

GRANT INSERT, UPDATE
ON hr_emp_backup
TO backup_edit_role;

--M8. Run UPDATE on hr_emp_backup for 3 rows, then ROLLBACK. Check SQL%ROWCOUNT after UPDATE (in PL/SQL) and after ROLLBACK.
--Hint: After UPDATE, SQL%ROWCOUNT = 3; after ROLLBACK, the updates are undone.
declare 
 v_rows_updated number;
Begin
 update hr_emp_backup
 set salary=salary*1.5
 where employee_id in(100,102,103);
 
 v_rows_updated := sql%rowcount;
 dbms_output.put_line(
 'Rows Updated '|| v_rows_updated
 );
 rollback;

END;
/
 
 
SELECT employee_id, salary
FROM hr_emp_backup
WHERE employee_id IN (100, 101, 102);
 
 dbms_output.put_line('Rollback updated');


--M9. Create a role hr_report and grant it SELECT on hr.employees and hr.departments.
--Hint: CREATE ROLE hr_report; GRANT SELECT ON hr.employees TO hr_report; GRANT SELECT ON hr.departments TO hr_report;

create role hr_report;
grant select on hr.employees to hr_report;
grant select on hr.departments to hr_report;

--M11. Write a script: UPDATE one row, SAVEPOINT a, UPDATE another row, SAVEPOINT b, UPDATE a third row, ROLLBACK TO SAVEPOINT a,
--then COMMIT. Which rows are updated permanently?
--Hint: Only the first update; second and third are rolled back.

-- Grant SELECT privilege
GRANT SELECT
ON hr.employees
TO user1;

-- Revoke SELECT privilege
REVOKE SELECT
ON hr.employees
FROM user1;

--M13. In a single transaction, run two UPDATEs on hr_emp_backup (different departments). Then COMMIT. How many rows are committed?
--Hint: All rows updated by both UPDATEs are committed together.

-- M13
SELECT department_id, COUNT(*) AS row_count
FROM hr_emp_backup
WHERE department_id IN (10, 20)
GROUP BY department_id;
-- First UPDATE
UPDATE hr_emp_backup
SET salary = salary * 1.05
WHERE department_id = 10;

-- Second UPDATE
UPDATE hr_emp_backup
SET salary = salary * 1.10
WHERE department_id = 20;

-- Commit both updates
COMMIT;

--M14. Create a role and grant it only SELECT on hr.departments (no other tables).
--Hint: CREATE ROLE dept_reader; GRANT SELECT ON hr.departments TO dept_reader;
CREATE ROLE dept_reader;
GRANT SELECT ON hr.departments TO dept_reader;

--M17. List the privileges you would need (as DBA) to allow a user to create a table and insert into hr.employees (conceptual).
--Hint: CREATE TABLE (system), INSERT on hr.employees (object), and possibly quota on tablespace
GRANT CREATE TABLE TO user1;
-- System privilege
GRANT CREATE TABLE TO user1;

-- Object privilege
GRANT INSERT ON hr.employees TO user1;

-- Tablespace quota (if required)
ALTER USER user1 QUOTA 100M ON users;


SELECT username
FROM all_users
ORDER BY username;

CREATE USER user1
IDENTIFIED BY nidhi;

GRANT CREATE SESSION TO user1;

GRANT CREATE TABLE TO user1;

GRANT INSERT ON hr.employees TO user1;

ALTER USER user1
QUOTA 100M ON users;

SELECT username
FROM all_users
WHERE username = 'USER1';

SELECT role
FROM dba_roles
WHERE role = 'USER1';

CREATE USER test_user1
IDENTIFIED BY User123;

GRANT CREATE SESSION TO test_user1;
GRANT CREATE TABLE TO test_user1;
GRANT INSERT ON hr.employees TO test_user1;

ALTER USER test_user1
QUOTA 100M ON users;

--M19. Grant a role to a user: GRANT hr_reader TO app_user; What can app_user do?
--Hint: Whatever privileges were granted to hr_reader (e.g. SELECT on hr.employees and hr.departments).
CREATE ROLE hr_reader;

GRANT SELECT ON hr.employees
TO hr_reader;

GRANT SELECT ON hr.departments
TO hr_reader;

GRANT hr_reader TO app_user;

SELECT * FROM hr.employees;

SELECT * FROM hr.departments;

--M20. In one transaction, DELETE 5 rows from hr_emp_backup, then ROLLBACK. Verify the 5 rows are back.
--Hint: DELETE ... WHERE ... ; ROLLBACK; SELECT COUNT(*) should show rows restored.

--H1. Implement a "try and undo" pattern: UPDATE 10 rows, check SQL%ROWCOUNT, if not 10 then ROLLBACK else COMMIT (in PL/SQL).
--Hint: BEGIN UPDATE ... ; IF SQL%ROWCOUNT != 10 THEN ROLLBACK; ELSE COMMIT; END IF; END;
Declare
 v_rows_updated number;
Begin
 update hr_emp_backup
 set salary=salary*1.05
 where employee_id in (100,101,102,103,104,105,106,107,108,109,110);
 v_rows_updated := sql%rowcount;
 dbms_output.put_line(
    'Rows Updated: '|| v_rows_updated
  );
if v_rows_updated != 10 then
  rollback;
  dbms_output.put_line('Rollback - expected 10 rows.');
else
  commit;
  dbms_output.put_line('Commit - exactly 10 rows updated.');
end if;
 
end;
/

--H3. Write a script that grants SELECT, INSERT, UPDATE on hr.employees to role hr_hrw (read and write), then revokes UPDATE only.
--Hint: GRANT SELECT, INSERT, UPDATE ON hr.employees TO hr_hrw; REVOKE UPDATE ON hr.employees FROM hr_hrw;
create role hr_hrw;

grant select,insert, update on hr.employees to hr_hrw;

revoke update on hr.employees from hr_hrw

--H4. In a transaction, update salary for department 50, savepoint, update salary for department 60, rollback to savepoint, 
--update salary for department 70, commit. Which departments are updated?
--Hint: 50 and 70; 60 is rolled back.
UPDATE hr_emp_backup
SET salary = salary * 1.05
WHERE department_id = 50;

SAVEPOINT sp1;

-- Update department 60
UPDATE hr_emp_backup
SET salary = salary * 1.10
WHERE department_id = 60;

-- Undo changes made after sp1
ROLLBACK TO sp1;

-- Update department 70
UPDATE hr_emp_backup
SET salary = salary * 1.15
WHERE department_id = 70;

-- Permanently save the remaining changes
COMMIT;

--H5. Explain: Session A updates a row and does not commit. Session B updates the same row. What happens?
--Hint: Session B blocks (waits) until A commits or rolls back; then B proceeds or gets a conflict depending on isolation.
-- H6. Create the role
CREATE ROLE hr_reader;

-- Grant SELECT on both HR tables to the role
GRANT SELECT ON hr.employees
TO hr_reader;

GRANT SELECT ON hr.departments
TO hr_reader;

-- Grant the role to two users
GRANT hr_reader TO user1;
GRANT hr_reader TO user2;

--H7. Run UPDATE on hr_emp_backup, then create savepoint, then DELETE 1 row, then ROLLBACK TO SAVEPOINT, then COMMIT. Is the row deleted?
--Hint: No; the DELETE was rolled back. Only the UPDATE is committed.
update hr_emp_backup
set salary= slary*1.05
where employee_id=100

savepoint s1

delete from hr_emp_backup
where employee_id=101;
rollback to s1

commit;

--H8. What object privilege is needed to allow a user to run SELECT * FROM hr.employees?
--Hint: SELECT on hr.employees (and possibly on schema/table if qualified).

grant select on hr.employees to user1;

SELECT * FROM hr.employees;

--H9. In one transaction, INSERT one row, SAVEPOINT, INSERT another row, ROLLBACK TO SAVEPOINT, COMMIT. How many rows are in the table?
--Hint: One (the first insert); the second insert was rolled back.

-- H9. First INSERT
INSERT INTO hr_emp_backup
(employee_id, first_name, last_name, email, hire_date, job_id, salary)
VALUES
(999, 'Test', 'One', 'test999@example.com',
 DATE '2026-08-24', 'IT_PROG', 50000);
-- Create savepoint
SAVEPOINT sp1;

-- Second INSERT
INSERT INTO hr_emp_backup
(employee_id, first_name, last_name, email, hire_date, job_id, salary)
VALUES
(998, 'Test', 'Two', 'test998@example.com',
 DATE '2026-08-24', 'IT_PROG', 60000);
-- Undo only the second INSERT
ROLLBACK TO sp1;

-- Commit the first INSERT
COMMIT;

--H10. Grant SELECT on hr.employees to a role, then grant that role to a user. Then revoke the role from the user.
--Can the user still query hr.employees?
--Hint: No; revoking the role removes the privilege.

-- H10. Create role
CREATE ROLE hr_emp_reader;

-- Grant SELECT on HR.EMPLOYEES to the role
GRANT SELECT
ON hr.employees
TO hr_emp_reader;

-- Grant role to user
GRANT hr_emp_reader
TO app_user;

-- Revoke the role from the user
REVOKE hr_emp_reader
FROM app_user;

--H11. Write a transaction that updates 3 rows in hr_emp_backup, then rolls back only the last update using a savepoint.
--Hint: UPDATE row1; UPDATE row2; SAVEPOINT s; UPDATE row3; ROLLBACK TO s; COMMIT;

-- Update row 1
UPDATE hr_emp_backup
SET salary = salary * 1.05
WHERE employee_id = 100;

-- Update row 2
UPDATE hr_emp_backup
SET salary = salary * 1.05
WHERE employee_id = 101;

-- Create savepoint before the last update
SAVEPOINT s;

-- Update row 3
UPDATE hr_emp_backup
SET salary = salary * 1.05
WHERE employee_id = 102;

-- Undo only the third update
ROLLBACK TO s;

-- Commit the first two updates
COMMIT;

--H12. If you REVOKE SELECT ON hr.employees FROM a role, do users who were granted that role lose access immediately?
--Hint: Yes (or at next reconnection depending on DB); the role no longer has the privilege.

GRANT SELECT ON hr.employees TO hr_reader;
GRANT hr_reader TO app_user;

SELECT *
FROM hr.employees;

REVOKE SELECT
ON hr.employees
FROM hr_reader;

--H14. Create a role with SELECT on hr.employees. Grant the role to user A. Grant the role to role B. Grant role B to user C. 
--Can user C query hr.employees?
--Hint: Yes, if role B was granted the first role (role chain); or grant SELECT to role B and grant B to C.

-- 1. Create Role A
CREATE ROLE role_a;

-- 2. Give Role A SELECT on HR.EMPLOYEES
GRANT SELECT
ON hr.employees
TO role_a;

-- 3. Grant Role A to User A
GRANT role_a TO user_a;

-- 4. Create Role B
CREATE ROLE role_b;

-- 5. Grant Role A to Role B
GRANT role_a TO role_b;

-- 6. Grant Role B to User C
GRANT role_b TO user_c;

SELECT *
FROM hr.employees;

--H15. In a single transaction, run five UPDATEs with savepoints between each. Roll back to the second savepoint. 
--How many UPDATEs are still in the transaction?
--Hint: Two (the first two updates); the third, fourth, fifth are undone.

-- UPDATE 1
UPDATE hr_emp_backup
SET salary = salary * 1.01
WHERE employee_id = 100;

SAVEPOINT s1;

-- UPDATE 2
UPDATE hr_emp_backup
SET salary = salary * 1.02
WHERE employee_id = 101;

SAVEPOINT s2;

-- UPDATE 3
UPDATE hr_emp_backup
SET salary = salary * 1.03
WHERE employee_id = 102;

SAVEPOINT s3;

-- UPDATE 4
UPDATE hr_emp_backup
SET salary = salary * 1.04
WHERE employee_id = 103;

SAVEPOINT s4;

-- UPDATE 5
UPDATE hr_emp_backup
SET salary = salary * 1.05
WHERE employee_id = 104;

-- Roll back to the second savepoint
ROLLBACK TO s2;

--H16. Revoke INSERT on hr.employees from a role. Does this affect users who have the role?
--Hint: Yes; they lose INSERT on hr.employees through that role.

CREATE USER app_user
IDENTIFIED BY AppUser123;
-- 1. Create the role
CREATE ROLE hr_writer;

-- 2. Give the role INSERT privilege
GRANT INSERT
ON hr.employees
TO hr_writer;

-- 3. Grant the role to APP_USER
GRANT hr_writer
TO app_user;

-- 4. Revoke INSERT from the role
REVOKE INSERT
ON hr.employees
FROM hr_writer;

--H18. Write a script that uses a savepoint before a risky UPDATE, then checks a condition (e.g. SQL%ROWCOUNT), and rolls back to the savepoint if the condition is not met.
--Hint: SAVEPOINT before; UPDATE; IF condition THEN COMMIT; ELSE ROLLBACK TO SAVEPOINT; END IF;
Declare 
  v_rows_updated number;
Begin
  savepoint before_update;
  update hr_emp_backup
  set salary=salary*1.5
  where employee_id in(101,102,103);
  
  v_rows_updated:=sql%rowcount;
  dbms_output.put_line('Rows Updated :'|| v_rows_updated);
  if v_rows_updated = 3 then
     commit;
     dbms_output.put_line('condition met- changes committed');
  else
     rollback to before_update;
     dbms_output.put_line('condition not met-changes rollback');
  end if;
end;
/

--H20. In one transaction: INSERT row 1, SAVEPOINT a, INSERT row 2, SAVEPOINT b, DELETE row 1, ROLLBACK TO SAVEPOINT b, COMMIT. 
--What rows exist?
--Hint: Both rows (row 1 and row 2); the DELETE was rolled back when we rolled back to b. So after COMMIT we have both inserts.
-- H20: Insert row 1
INSERT INTO hr_emp_backup
(employee_id, first_name, last_name, email, hire_date, job_id, salary)
VALUES
(999, 'Test', 'One', 'test999@example.com',
 DATE '2026-08-24', 'IT_PROG', 50000);

-- Savepoint A
SAVEPOINT a;

-- Insert row 2
INSERT INTO hr_emp_backup
(employee_id, first_name, last_name, email, hire_date, job_id, salary)
VALUES
(998, 'Test', 'Two', 'test998@example.com',
 DATE '2026-08-24', 'IT_PROG', 60000);

-- Savepoint B
SAVEPOINT b;

-- Delete row 1
DELETE FROM hr_emp_backup
WHERE employee_id = 999;

-- Roll back only the DELETE
ROLLBACK TO b;

-- Make both inserts permanent
COMMIT;
  
  


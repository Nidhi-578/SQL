--Question 1
--List each employee’s first name, last name, and department name (join hr.employees and hr.departments).

SELECT e.first_name, e.last_name, d.department_name
FROM hr.employees e
INNER JOIN hr.departments d ON e.department_id = d.department_id;

--Question 2
--List employees who work in the 'Sales' department (use the department name from hr.departments).
select e.employee_id,e.first_name,e.last_name, d.department_name 
from hr.employees e 
Inner join hr.departments d ON e.department_id = d.department_id
where d.department_name='Sales';

--Question 3
--Count how many employees work in each department and show the department name. (Join and use GROUP BY with COUNT.)
select d.department_name, count(e.employee_id) as employee_count from hr.employees e
inner join hr.departments d on e.department_id=d.department_id
group by d.department_id,d.department_name;
--Part 2: Self-Practice (No Answers)
--1. Join hr.employees to hr.departments and also show the employee’s manager_id. Then join again to hr.employees (self-join)
--to show the manager’s first and last name.
select e.employee_id,e.first_name as employee_first_name,e.last_name as employee_last_name, d.department_name, e.manager_id, m.first_name
as manager_first_name, m.last_name as maanger_last_name from hr.employees e left join hr.departments d on e.department_id= d.department_id
left join hr.employees m on e.manager_id = m.employee_id;

--List department_id and department_name for the department named 'IT' (or similar). Use hr.departments only, or join if 
--you want to verify with employee count.

select d.department_id,d.department_name, count(e.employee_id)as employee_count from hr.departments d inner join hr.employees e on 
d.department_id=e.employee_id where d.department_name='IT' group by d.department_id,d.department_name;

--Part 3: Additional Practice — 20 Medium + 20 Hard Questions
--M1. List employee_id, first_name, last_name, and department_name (join employees and departments).
--Hint: INNER JOIN on department_id; select e.employee_id, e.first_name, e.last_name, d.department_name.
select e.employee_id, e.first_name, e.last_name, d.department_name from hr.employees e inner join hr.departments d on 
e.department_id=e.department_id

--M2. Show employees in department 'IT' (filter by d.department_name = 'IT' after join).
--Hint: Join then WHERE d.department_name = 'IT'.
select e.employee_id,e.first_name,e.last_name from hr.employees e inner join hr.departments d on e.department_id = d.department_id where 
d.department_name = 'IT'

--M3. Count employees per department and show department_name.
--Hint: JOIN, GROUP BY d.department_id, d.department_name, COUNT(e.employee_id).
  
  select d.department_name,count(e.employee_id)as employee_count from hr.employees e inner join hr.departments d on e.department_id
  =d.department_id group by
  d.department_id,d.department_name;
  
--M4. List first_name, last_name, department_id, department_name for department_id 50.
--Hint: Join and WHERE e.department_id = 50 (or d.department_id = 50).
select e.first_name,e.last_name,d.department_id, d.department_name from hr.employees e inner join hr.departments d on
e.department_id=d.department_id where e.department_id=50

--M5. Show employee_id, salary, and department_name.
--Hint: Join hr.employees and hr.departments on department_id.
select e.employee_id,e.salary, d.department_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id

--M6. List departments (department_id, department_name) that have at least one employee (use JOIN and DISTINCT or GROUP BY).
--Hint: SELECT DISTINCT d.department_id, d.department_name FROM hr.departments d INNER JOIN hr.employees e ON d.department_id = e.department_id;
select distinct d.department_id,d.department_name from hr.departments d inner join hr.employees e on d.department_id = e.department_id;

--M7. Show first_name, last_name, department_name for employees with salary > 8000.
--Hint: Join then WHERE e.salary > 8000.
select e.first_name,e.last_name,d.department_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id
where e.salary > 8000;

--M8. List employee_id, job_id, department_name.
--Hint: Join e and d on department_id; select e.employee_id, e.job_id, d.department_name.
select e.employee_id, e.job_id, d.department_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id

--M9. Count employees per department_name (one row per department).
--Hint: GROUP BY d.department_name (and d.department_id); COUNT(e.employee_id).
select d.department_name, count(e.employee_id) from hr.employees e inner join hr.departments d on e.department_id=d.department_id group by 
d.department_name;

--M10. Show employees (name, salary) in department 'Sales'.
--Hint: Join, WHERE d.department_name = 'Sales'.
select e.first_name, e.salary from hr.employees e inner join hr.departments d on e.department_id=d.department_id where d.department_name='Sales'

--M11. List department_id, department_name, and total salary (SUM(e.salary)) for that department.
--Hint: Join, GROUP BY d.department_id, d.department_name, SUM(e.salary).

select d.department_id,d.department_name, sum(e.salary) as total_salary from hr.employees e inner join hr.departments d on e.department_id=
d.department_id group by d.department_id, d.department_name;

--M12. Show employee_id, hire_date, department_name.
--Hint: Join on department_id; select e.employee_id, e.hire_date, d.department_name.
select e.employee_id,e.hire_date,d.department_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id

--M13. List employees (first_name, last_name) and their department_name, ordered by department_name then last_name.
--Hint: JOIN, ORDER BY d.department_name, e.last_name.
select e.first_name,e.last_name,d.department_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id
order by d.department_name,e.last_name

--M14. Show department_name and average salary (AVG(e.salary)) for that department.
--Hint: Join, GROUP BY d.department_id, d.department_name, AVG(e.salary).
select d.department_name,(round(avg(e.salary),2)) as Avg_salary from hr.employees e inner join hr.departments d on e.department_id=d.department_id 
group by d.department_id,d.department_name

--M15. List employee_id, first_name, department_id, department_name for job_id 'SA_REP'.
--Hint: Join and WHERE e.job_id = 'SA_REP'.
select e.employee_id,e.first_name,d.department_id,d.department_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id
where e.job_id='SA_REP'

--M16. Show departments (department_name) and min salary in that department.
--Hint: Join, GROUP BY d.department_id, d.department_name, MIN(e.salary).
select d.department_name,min(e.salary) as Min_salary from hr.employees e inner join hr.departments d on e.department_id=d.department_id
group by d.department_id,d.department_name

--M17. List first_name, last_name, department_name where department_id is 80 or 90.
--Hint: Join and WHERE e.department_id IN (80, 90).
select e.first_name,e.last_name,d.department_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id
where e.department_id IN (80, 90)

--M18. Show employee_id, salary, department_name for the 5 highest-paid employees (join then ORDER BY salary DESC FETCH FIRST 5).
--Hint: Join, ORDER BY e.salary DESC, FETCH FIRST 5 ROWS ONLY.
select e.employee_id,e.salary,d.department_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id
order by e.salary desc fetch first 5 rows only

--M19. List department_name and number of employees (COUNT) for departments with more than 5 employees.
--Hint: Join, GROUP BY d.department_id, d.department_name, HAVING COUNT(e.employee_id) > 5.
select d.department_name,count(e.employee_id)as total_employee from hr.employees e inner join hr.departments d on
e.department_id=d.department_id GROUP BY d.department_id, d.department_name HAVING COUNT(e.employee_id) > 5

--M20. Show first_name, last_name, department_name, hire_date.
--Hint: Join; select e.first_name, e.last_name, d.department_name, e.hire_date.
select e.first_name,e.last_name,d.department_name,e.hire_date from hr.employees e inner join hr.departments d on e.department_id=d.department_id

--20 Hard Questions
--H1. List employee_id, first_name, last_name, department_name, and manager's first_name and last_name 
--(self-join employees to manager, and join to departments).
--Hint: e JOIN d ON e.department_id = d.department_id LEFT JOIN employees m ON e.manager_id = m.employee_id; select e.*, d.department_name, 
--m.first_name, m.last_name.
select e.employee_id,e.first_name,e.last_name,d.department_name,m.first_name,m.last_name from hr.employees e inner join hr.departments d
on e.department_id=d.department_id LEFT JOIN hr.employees m ON e.manager_id = m.employee_id

--H2. Show department_name and total salary for departments where total salary > 100000.
--Hint: Join, GROUP BY d.department_id, d.department_name, HAVING SUM(e.salary) > 100000.
select d.department_id,d.department_name, sum(e.salary) as total_salary from hr.employees e inner join hr.departments d
on e.department_id=d.department_id GROUP BY d.department_id, d.department_name HAVING SUM(e.salary) > 100000

--H3. List employees (name, salary, department_name) who earn more than the average salary of their department.
--Hint: Join employees to departments; use a scalar subquery or join to (SELECT department_id, AVG(salary) avg_sal
--FROM hr.employees GROUP BY department_id) and WHERE e.salary > sub.avg_sal.

--H3. List employees (name, salary, department_name) who earn more than the average salary of their department.
--Hint: Join employees to departments; use a scalar subquery or join to (SELECT department_id, AVG(salary) avg_sal
--FROM hr.employees GROUP BY department_id) and WHERE e.salary > sub.avg_sal.
select e.first_name,e.last_name,e.salary,d.department_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id 
where e.salary> (SELECT AVG(e2.salary)
    FROM hr.employees e2
    WHERE e2.department_id = e.department_id
);

--**H4.** Show each department_name and the name of the employee with the highest salary in that department (use ROW_NUMBER or MAX(salary) join).  
-- **Hint:** Join to (SELECT department_id, employee_id, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) rn FROM hr.employees)
-- and filter rn = 1; then join departments for name.
select d.department_name,e.first_name,e.last_name,e.salary from (select e.*,row_number() over(
partition by e.department_id order by e.salary desc
) as rn
from hr.employees e) e
inner join hr.departments d on e.department_id=d.department_id where e.rn=1;

--H5. List department_id, department_name, and count of employees, only for departments in (10, 20, 30, 40).
--Hint: Join, WHERE d.department_id IN (10,20,30,40), GROUP BY d.department_id, d.department_name.
select d.department_id, d.department_name, count(e.employee_id ) as employee_count from hr.departments d INNER JOIN hr.employees e
    ON d.department_id = e.department_id where d.department_id in(10,20,30,40) 
group by d.department_id,d.department_name

--H6. Show employee first_name, last_name, department_name, and manager's department_name (employee's dept and manager's dept).
--Hint: e JOIN d ON e.department_id = d.department_id LEFT JOIN employees m ON e.manager_id = m.employee_id LEFT JOIN departments
--dm ON m.department_id = dm.department_id; select e.first_name, e.last_name, d.department_name, dm.department_name.
select e.first_name,e.last_name,d.department_name as employee_department,dm.department_name as manager_department from hr.employees e
inner join hr.departments d on e.department_id=d.department_id left join hr.employees m on e.manager_id=m.employee_id
left join hr.departments dm on m.department_id=dm.department_id

--H7. List department_name and average salary, ordered by average salary descending.
--Hint: Join, GROUP BY d.department_id, d.department_name, ORDER BY AVG(e.salary) DESC.
select d.department_name, round(avg(e.salary))as average_salary from hr.employees e inner join hr.departments d on e.department_id=d.department_id
group by d.department_id,d.department_name
order by avg(e.salary) desc

--H8. Show employees (name, salary, department_name) whose salary is above the company average.
--Hint: Join; WHERE e.salary > (SELECT AVG(salary) FROM hr.employees).
select e.first_name,e.salary,d.department_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id
where e.salary> (SELECT AVG(salary) FROM hr.employees)

--H9. List departments (department_name) that have at least one employee with commission_pct not null.
--Hint: JOIN and WHERE e.commission_pct IS NOT NULL; use DISTINCT d.department_name or GROUP BY.
select distinct d.department_name from hr.departments d inner join hr.employees e on e.department_id=d.department_id 
where e.commission_pct is Not NULL

--H10. Show employee_id, first_name, last_name, department_name, and department's manager_id (from departments).
--Hint: Join e and d; select e.employee_id, e.first_name, e.last_name, d.department_name, d.manager_id.
select e.employee_id,e.first_name,e.last_name, d.department_name,d.manager_id from hr.employees e inner join hr.departments d
on e.department_id=d.department_id 

--H11. List department_name and max salary in that department, only for departments with max salary > 12000.
--Hint: Join, GROUP BY d.department_id, d.department_name, HAVING MAX(e.salary) > 12000.
select d.department_name, max(e.salary) as max_salary from hr.departments d inner join hr.employees e on d.department_id=e.department_id
group by d.department_id,d.department_name HAVING MAX(e.salary) > 12000

--H12. Show first_name, last_name, department_name for employees hired after 2005.
--Hint: Join and WHERE e.hire_date > DATE '2005-12-31'.
select e.first_name,e.last_name, d.department_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id
where e.hire_date> date '2005-12-31'

--H13. List departments (department_name) and count of employees with job_id 'SA_REP' in that department.
--Hint: Join, WHERE e.job_id = 'SA_REP', GROUP BY d.department_id, d.department_name, COUNT(e.employee_id).
--H14. Show employee name, department_name, and salary rank within that department (RANK() OVER 
--(PARTITION BY department_id ORDER BY salary DESC)).
--Hint: Join; in SELECT add RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS rank_in_dept.
select e.first_name, e.last_name, d.department_name, e.salary, rank() over(partition by e.department_id order by e.salary desc ) as
rank_in_dept from hr.employees e inner join hr.departments d on e.department_id=d.department_id

--H15. List department_name and total number of employees, including departments with
--0 employees (use LEFT JOIN from departments to employees).
--Hint: FROM hr.departments d LEFT JOIN hr.employees e ON d.department_id = e.department_id GROUP BY d.department_id,
--d.department_name; COUNT(e.employee_id).
select d.department_name, count(e.employee_id)as total_employees from hr.departments d left join hr.employees e on e.department_id=d.department_id
group by d.department_id,d.department_name;

--H16. Show employees (name, salary, department_name) in departments 50, 60, 70, ordered by department_name then salary desc.
--Hint: Join, WHERE e.department_id IN (50,60,70), ORDER BY d.department_name, e.salary DESC.
select e.first_name,e.last_name,e.salary,d.department_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id
where e.department_id in (50,60,70) order by d.department_name, e.salary desc;

--H17. List department_name and average tenure (years) of employees in that department (MONTHS_BETWEEN/12).
--Hint: Join; in SELECT AVG(MONTHS_BETWEEN(SYSDATE, e.hire_date)/12); GROUP BY d.department_id, d.department_name.
SELECT d.department_name,AVG(MONTHS_BETWEEN(SYSDATE, e.hire_date) / 12) AS avg_tenure_years FROM hr.departments d INNER JOIN hr.employees e
ON d.department_id = e.department_id GROUP BY d.department_id,d.department_name;

--H18. Show employee_id, first_name, last_name, department_name, and number of employees in that department (same count repeated per
--employee in dept).
--Hint: Join and join to (SELECT department_id, COUNT() cnt FROM hr.employees GROUP BY department_id) sub ON e.department_id = sub.department_id; 
--select e., d.department_name, sub.cnt.
SELECT e.employee_id, e.first_name,e.last_name,d.department_name,sub.cnt AS department_employee_count FROM hr.employees e INNER JOIN hr.departments d
ON e.department_id = d.department_id INNER JOIN (SELECT department_id,COUNT(*) AS cnt FROM hr.employees GROUP BY department_id) sub ON 
e.department_id = sub.department_id;

--H19. List departments (department_name) that have more than 2 employees with salary > 5000.
--Hint: Join, WHERE e.salary > 5000, GROUP BY d.department_id, d.department_name, HAVING COUNT(*) > 2.
SELECT d.department_name FROM hr.departments d INNER JOIN hr.employees e ON d.department_id = e.department_id WHERE e.salary > 5000
GROUP BY d.department_id,d.department_name HAVING COUNT(*) > 2;

--H20. Show first_name, last_name, department_name, and salary as percentage of department total
--(salary * 100.0 / SUM(salary) OVER (PARTITION BY e.department_id)).
--Hint: Join; add salary * 100.0 / SUM(e.salary) OVER (PARTITION BY e.department_id) AS pct_of_dept_sal.
SELECT e.first_name,e.last_name,d.department_name,e.salary,e.salary * 100.0/ SUM(e.salary) OVER (PARTITION BY e.department_id) 
AS pct_of_dept_sal FROM hr.employees e INNER JOIN hr.departments d ON e.department_id = d.department_id;




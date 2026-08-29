--Question 1
--List employees hired in the year 2005.
SELECT employee_id,first_name,last_name,hire_date FROM hr.employees WHERE hire_date >= DATE '2005-01-01'
AND hire_date < DATE '2006-01-01';

SELECT employee_id, first_name, last_name, hire_date FROM hr.employees WHERE EXTRACT(YEAR FROM hire_date) = 2005;

--Question 2
--For each employee, show tenure in years using MONTHS_BETWEEN (and divide by 12). Use alias tenure_years, rounded to 1 decimal.
SELECT employee_id, first_name, last_name, hire_date,ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12, 1) AS tenure_years
FROM hr.employees;

--Question 3
--Add a column salary_band using CASE: Low (salary < 5000), Medium (5000–11999), High (>= 12000). Show employee_id, first_name,
--salary, salary_band.
select employee_id, first_name, salary,
 case
  when salary< 5000 then 'Low'
  when salary < 12000 then 'Medium'
  ELSE 'High'
 end as salary_band
From hr.employees

--Part 2: Self-Practice (No Answers)
--Show the first 3 characters of last_name for each employee (use SUBSTR).
select employee_id,first_name,last_name, substr(last_name,1,3) as first_3_chars from hr.employees;

--List employees with tenure greater than 15 years (use MONTHS_BETWEEN as above).
select employee_id,first_name,last_name from hr.employees where months_between (sysdate, hire_date)> 15*12;

--In the SELECT list, use NVL(commission_pct, 0) in an expression that computes something like total compensation
--(e.g. salary + salary * commission). Give the expression an alias.
select employee_id,first_name,last_name, salary, NVL(commission_pct,0) as commission_pct, salary + (salary+NVL(commission_pct,0))
as total_compensation from hr.employees

--20 Medium Questions
--M1. Show employee_id, first_name, and LENGTH(last_name) as last_name_length.
--Hint: SELECT employee_id, first_name, LENGTH(last_name) AS last_name_length FROM hr.employees;
select employee_id,first_name,last_name,length(last_name) as last_name_length from hr.employees

--M2. List employees hired in 2004 using EXTRACT(YEAR FROM hire_date).
--Hint: WHERE EXTRACT(YEAR FROM hire_date) = 2004;
select employee_id,first_name,last_name from hr.employees where extract(year from hire_date)=2004;

--M3. Add a column job_type: 'Sales' if job_id like 'SA%', else 'Other'. Use CASE.
--Hint: CASE WHEN job_id LIKE 'SA%' THEN 'Sales' ELSE 'Other' END AS job_type;

select employee_id, first_name,last_name,job_id,
 case
   when job_id like 'SA%' then 'sales'
   else 'other'
 end as job_type
 from hr.employees;
 
 --M4. Show first_name, last_name, and tenure in months (MONTHS_BETWEEN(SYSDATE, hire_date)).
--Hint: MONTHS_BETWEEN(SYSDATE, hire_date) AS tenure_months;
select first_name,last_name, months_between(sysdate,hire_date) as tenure_months from hr.employees;

--M5. List employees with salary between 4000 and 8000 and department_id 50 or 60. Use parentheses.
--Hint: WHERE salary BETWEEN 4000 AND 8000 AND (department_id = 50 OR department_id = 60);
select employee_id,first_name,last_name,salary from hr.employees where salary between 4000 and 8000 and (department_id=50 or department_id=60);

--M6. Display employee_id, salary, and salary_level: 'Tier1' if salary < 5000, 'Tier2' if < 10000, else 'Tier3'.
--Hint: CASE WHEN salary < 5000 THEN 'Tier1' WHEN salary < 10000 THEN 'Tier2' ELSE 'Tier3' END;
select employee_id,first_name,last_name,salary,
 case
   when salary<5000 then 'tier1'
   when salary <10000 then 'tier2'
   else 'tier3'
 end as salary_level
from hr.employees;

--M7. Show last_name and INITCAP(last_name).
--Hint: SELECT last_name, INITCAP(last_name) FROM hr.employees;
select employee_id,first_name,last_name,last_name, INITCAP(last_name) AS formatted_last_name FROM hr.employees;

--M8. List employees where department_id is in the set (10, 20, 30) from hr.departments (use subquery IN).
--Hint: WHERE department_id IN (SELECT department_id FROM hr.departments WHERE department_id IN (10,20,30));
select employee_id,first_name,last_name,department_id from hr.employees where department_id in (select department_id from hr.departments where
department_id in (10,20,30));

--M9. Add column hire_month as EXTRACT(MONTH FROM hire_date).
--Hint: EXTRACT(MONTH FROM hire_date) AS hire_month;
select employee_id, first_name, last_name, extract(month from hire_date)as hire_month from hr.employees;

--M10. Show phone_number and COALESCE(phone_number, 'No Phone').
--Hint: COALESCE(phone_number, 'No Phone') AS contact;

select phone_number,coalesce(phone_number,'No Phone') as contact from hr.employees;
--M11. List employees with (department_id = 50 AND salary > 5000) OR (department_id = 60).
--Hint: WHERE (department_id = 50 AND salary > 5000) OR department_id = 60;
select employee_id,first_name,last_name,department_id,salary from hr.employees where (department_id=50 and salary>5000) or department_id=60;

--M12. Display hire_date and ADD_MONTHS(hire_date, 12) as one_year_later.
--Hint: ADD_MONTHS(hire_date, 12) AS one_year_later;
SELECT
    hire_date,
    ADD_MONTHS(hire_date, 12) AS one_year_later
FROM hr.employees;

--M13. Show first_name, last_name, and SUBSTR(first_name, 1, 1) || SUBSTR(last_name, 1, 1) as initials.
--Hint: SUBSTR(first_name,1,1) || SUBSTR(last_name,1,1) AS initials;

SELECT first_name,last_name,SUBSTR(first_name, 1, 1) || SUBSTR(last_name, 1, 1) AS initials FROM hr.employees;

--M14. List employees hired after 2006-01-01.
--Hint: WHERE hire_date > DATE '2006-01-01';
select employee_id, hire_date from hr.employees where hire_date> date '2006-01-01'
--M15. Add column has_commission: 'Yes' if commission_pct is not null, 'No' otherwise. Use NVL2 or CASE.
--Hint: NVL2(commission_pct, 'Yes', 'No') AS has_commission;

SELECT employee_id, first_name,last_name,commission_pct,NVL2(commission_pct, 'Yes', 'No') AS has_commission FROM hr.employees;

--M16. Show salary and ROUND(salary, -2) (rounded to nearest hundred).
--Hint: ROUND(salary, -2) AS salary_rounded;
select salary, round(salary,-2) as salary_rounded from hr.employees;

--M17. List employees where job_id is SA_REP or SA_MAN and salary > 8000.
--Hint: WHERE job_id IN ('SA_REP','SA_MAN') AND salary > 8000;
select first_name,last_name,salary, job_id from hr.employees where job_id in ('sa_rep','sa_man') and salary>8000;

--M18. Display employee_id, hire_date, and TRUNC(hire_date) (same day at midnight).
--Hint: TRUNC(hire_date) AS hire_day;
select employee_id,trunc(hire_date) as hire_day from hr.employees;

--M19. Show last_name and LOWER(last_name).
--Hint: LOWER(last_name) AS last_lower;
select last_name,lower(last_name)as lastlower from hr.employees;

--M20. List employees with tenure (MONTHS_BETWEEN/12) >= 10 years.
--Hint: WHERE MONTHS_BETWEEN(SYSDATE, hire_date)/12 >= 10;

select employee_id,first_name,last_name,hire_date from hr.employees where months_between (sysdate,hire_date)/12 >=10;

--H1. Show employee_id, salary, and a band: 'A' if salary in top 25%, 'B' if next 25%, etc. Use NTILE(4) over salary order or CASE 
--with subquery for percentiles.
--Hint: Use subquery for AVG/percentiles or NTILE(4) OVER (ORDER BY salary DESC) and map 1->'A', 2->'B', etc.

select employee_id,salary,
  case 
    when salary_band=1 then 'A'
    when salary_band= 2 then 'B'
    when salary_band= 3 then 'C'
  else 'D'
  end as salary_band
from (
select employee_id,salary,NTILE(4) over (order by salary desc) as salary_band from hr.employees
);

--H2. List employees whose hire_date is in the same year as their manager's hire_date (need self-join on manager_id;
--compare EXTRACT(YEAR FROM e.hire_date) = EXTRACT(YEAR FROM m.hire_date)).
--Hint: Self-join hr.employees e and m on e.manager_id = m.employee_id; WHERE EXTRACT(YEAR FROM e.hire_date) = EXTRACT(YEAR FROM m.hire_date).
select e.employee_id,e.first_name,e.last_name from hr.employees e inner join hr.employees m on e.manager_id=m.employee_id where 
extract (year from e.hire_date)=extract(year from m.hire_date);

--H3. Add column salary_vs_avg: (salary - (SELECT AVG(salary) FROM hr.employees)). Round to 2 decimals.
--Hint: ROUND(salary - (SELECT AVG(salary) FROM hr.employees), 2) AS salary_vs_avg;

SELECT employee_id, first_name, last_name, salary,ROUND(salary - (SELECT AVG(salary) FROM hr.employees),2 ) AS salary_vs_avg
FROM hr.employees;

--H4. List employees with exactly 5 characters in first_name.
--Hint: WHERE LENGTH(first_name) = 5;
SELECT employee_id, first_name, last_name FROM hr.employees where length(first_name)=5;

--H5. Show first_name, last_name, and full_name with last_name first: last_name || ', ' || first_name.
--Hint: last_name || ', ' || first_name AS full_name;
SELECT employee_id, first_name, last_name,last_name || ', ' || first_name AS full_name from hr.employees;

--H6. For each employee show hire_date and the day of week (use TO_CHAR(hire_date, 'Day') or similar).
--Hint: TO_CHAR(hire_date, 'Day') AS day_of_week;
SELECT employee_id, first_name, last_name,hire_date, to_char(hire_date,'Day') as day_of_week from hr.employees;

--H7. List employees where department_id is in (SELECT department_id FROM hr.departments).
--Hint: WHERE department_id IN (SELECT department_id FROM hr.departments);
SELECT employee_id, first_name, last_name, department_id from hr.employees WHERE department_id IN (SELECT department_id FROM hr.departments);

--H8. Add column years_until_10: years until 10 years tenure (10 - tenure_years), only for people with < 10 years.
--Hint: CASE WHEN MONTHS_BETWEEN(SYSDATE, hire_date)/12 < 10 THEN ROUND(10 - MONTHS_BETWEEN(SYSDATE, hire_date)/12, 1) END;

SELECT employee_id,first_name,last_name,hire_date,
    CASE
        WHEN MONTHS_BETWEEN(SYSDATE, hire_date) / 12 < 10
        THEN ROUND(
            10 - MONTHS_BETWEEN(SYSDATE, hire_date) / 12,1)
    END AS years_until_10
FROM hr.employees;

--H9. Show salary and commission_pct and total_comp as salary + salary*NVL(commission_pct,0), rounded to 2 decimals.
--Hint: ROUND(salary * (1 + NVL(commission_pct,0)), 2) AS total_comp;
select salary,commission_pct,ROUND(salary * (1 + NVL(commission_pct,0)), 2) AS total_comp from hr.employees

--H10. List employees hired on the first day of any month (EXTRACT(DAY FROM hire_date) = 1).
--Hint: WHERE EXTRACT(DAY FROM hire_date) = 1;
select first_name,last_name,hire_date from hr.employees where extract(day from hire_date)=1;

--H11. Display employee_id, salary, and salary rank within department (use RANK() OVER (PARTITION BY department_id ORDER BY salary DESC)).
--Hint: RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS sal_rank;

select employee_id,salary,department_id, rank() over (partition by department_id order by salary desc)as sal_rank from hr.employees;

--H12. List employees whose last_name contains the letter 'a' at least twice.
--Hint: WHERE (LENGTH(last_name) - LENGTH(REPLACE(LOWER(last_name),'a',''))) >= 2;
select first_name,last_name from hr.employees WHERE (LENGTH(last_name) - LENGTH(REPLACE(LOWER(last_name),'a',''))) >= 2;

--H13. Show hire_date and LAST_DAY(hire_date) (last day of that month).
--Hint: LAST_DAY(hire_date) AS month_end;

select first_name,last_name,hire_date, LAST_DAY(hire_date) AS month_end from hr.employees;

--H14. Add column comp_category: 'Salary only' if commission_pct is null, 'Salary+Commission' otherwise.
--Hint: CASE WHEN commission_pct IS NULL THEN 'Salary only' ELSE 'Salary+Commission' END;

SELECT employee_id,first_name,last_name,salary,commission_pct,
    CASE
        WHEN commission_pct IS NULL THEN 'Salary only'
        ELSE 'Salary+Commission'
    END AS comp_category
FROM hr.employees;

--H15. List employees with tenure (years) between 5 and 15.
--Hint: WHERE MONTHS_BETWEEN(SYSDATE, hire_date)/12 BETWEEN 5 AND 15;

select first_name,hire_date from hr.employees where months_between(sysdate,hire_date)/12 between 5 and 15;

--H16. Show first_name reversed (use REVERSE or loop in PL/SQL; in Oracle no REVERSE—use SUBSTR in a custom way or simple: 
--list as-is and add a note). For Oracle use: list first_name and perhaps SUBSTR from end.
--Hint: In Oracle 11g+: use LISTAGG trick or recursive SUBSTR; or skip reverse and use LENGTH/SUBSTR to build reversed string.

--H17. List employees where department_id exists in hr.departments and salary > (SELECT AVG(salary) FROM hr.employees).
--Hint: WHERE department_id IN (SELECT department_id FROM hr.departments) AND salary > (SELECT AVG(salary) FROM hr.employees);
select e.employee_id,e.first_name, e.last_name from hr.employees e inner join hr.departments d on e.department_id=d.department_id
where salary > (SELECT AVG(salary) FROM hr.employees);

--H18. Display salary and salary with 15% bonus: salary * 1.15.
--Hint: salary * 1.15 AS salary_with_bonus;

select salary,salary*1.15 as salary_with_bonus from hr.employees;

--H19. Add column hire_decade: '2000s' if hire_date in 2000-2009, '1990s' if 1990-1999, else 'Other'.
--Hint: CASE WHEN EXTRACT(YEAR FROM hire_date) BETWEEN 2000 AND 2009 THEN '2000s' WHEN EXTRACT(YEAR FROM hire_date)
--BETWEEN 1990 AND 1999 THEN '1990s' ELSE 'Other' END;
SELECT employee_id, first_name,last_name,hire_date,
    CASE
        WHEN EXTRACT(YEAR FROM hire_date) BETWEEN 2000 AND 2009
            THEN '2000s'
        WHEN EXTRACT(YEAR FROM hire_date) BETWEEN 1990 AND 1999
            THEN '1990s'
        ELSE 'Other'
    END AS hire_decade
FROM hr.employees;

--H20. List employees with first_name starting with 'A' or 'B' and salary > 6000.
--Hint: WHERE (first_name LIKE 'A%' OR first_name LIKE 'B%') AND salary > 6000;

select first_name,last_name,salary from hr.employees where (first_name like 'A%' or first_name like 'B%') and salary>6000;














































 































































  





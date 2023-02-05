--Employee_Database_challenge
-- Deliverable 1
--table1
SELECT e.emp_no, 
		e.first_name, 
		e.last_name,
		t.title, 
		t.from_date, 
		t.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no 

SELECT * FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
--table2
SELECT DISTINCT ON (emp_no) emp_no,
			first_name,
			last_name,
			title,
			to_date

INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

--table 3
SELECT count(title) "count", title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles

--Deliverable 2: The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
		e.first_name, 
		e.last_name, 
		e.birth_date, 
		de.from_date, 
		de.to_date, 
		t.title
INTO mentorship_eligibility
FROM employees e
JOIN dept_emp de 
ON e.emp_no = de.emp_no
JOIN titles t 
ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibility

-------------
----How many roles will need to be fill per title and department?
SELECT COUNT(title) AS challenge_count, title
FROM unique_titles
WHERE to_date = '9999-01-01'
GROUP BY title
ORDER BY challenge_count DESC;

---------
SELECT COUNT(title) AS retirement_eligible_manager_count
FROM mentorship_eligibility
WHERE title = 'Manager';

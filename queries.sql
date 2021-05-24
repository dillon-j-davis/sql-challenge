CREATE TABLE titles(
	title_id VARCHAR UNIQUE,
	title VARCHAR,
	PRIMARY KEY(title_id)
);

CREATE TABLE employees(
	emp_no INTEGER UNIQUE,
	emp_title VARCHAR,
	birth_date VARCHAR,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date VARCHAR,
	PRIMARY KEY(emp_no),
	FOREIGN KEY (emp_title) REFERENCES titles(title_id)
);

CREATE TABLE departments(
	dept_no VARCHAR UNIQUE,
	dept_name VARCHAR,
	PRIMARY KEY(dept_no)
);


CREATE TABLE dept_emp(
	emp_no INTEGER,
	dept_no VARCHAR,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);





CREATE TABLE dept_manager(
	dept_no VARCHAR,
	emp_no INTEGER,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE salaries(
	emp_no INTEGER,
	salary INTEGER,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


---List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT e.emp_no, last_name, first_name, sex, s.salary
	FROM employees AS e
		INNER JOIN salaries AS s
			ON e.emp_no = s.emp_no;



--List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
	FROM employees
		WHERE hire_date LIKE '%1986';


--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT d.dept_no, dept_name, dm.emp_no, e.last_name, first_name
	FROM departments AS d
		INNER JOIN dept_manager AS dm
			ON d.dept_no = dm.dept_no
			INNER JOIN employees AS e
				ON e.emp_no = dm.emp_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, last_name, first_name, d.dept_name
	FROM employees AS e
		INNER JOIN dept_emp AS de
			ON e.emp_no = de.emp_no
			INNER JOIN departments AS d
				ON d.dept_no = de.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
	FROM employees
		WHERE first_name = 'Hercules'
		AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, last_name, first_name, d.dept_name
	FROM employees AS e
	INNER JOIN dept_emp AS de
		ON e.emp_no = de.emp_no
		INNER JOIN departments AS d
			ON d.dept_no = de.dept_no
				WHERE d.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, last_name, first_name, d.dept_name
	FROM employees AS e
		INNER JOIN dept_emp AS de
			ON e.emp_no = de.emp_no
			INNER JOIN departments AS d
				ON d.dept_no = de.dept_no
					WHERE d.dept_name = 'Sales'
						OR d.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT (last_name)
	FROM employees
		GROUP BY last_name
			ORDER BY count DESC;

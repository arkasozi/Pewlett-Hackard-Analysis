-- Creating tables for Employee_Database_Challenge
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
     emp_no INTEGER NOT NULL,
     birth_date DATE NOT NULL,
	 first_name VARCHAR(40) NOT NULL,
	 last_name VARCHAR(40) NOT NULL,
	 gender  VARCHAR(20) NOT NULL,
	 hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no, title, from_date)
);

CREATE TABLE demp_emp (
  emp_no INT NOT NULL,
  dept_no VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no, dept_no)
);
-- Assignment one
SELECT e.emp_no,
    e.first_name,
    e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO Retirement_Title
FROM employees as e
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM Retirement_Title
ORDER BY emp_no, first_name DESC;


-- retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(un.emp_no), ti.title
INTO retiring_titles
FROM unique_titles as un
LEFT JOIN titles as ti
ON ti.emp_no = un.emp_no
GROUP BY ti.title
ORDER BY ti.count DESC;


SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
	ti.title
INTO mentorship_eligibilty_2
FROM employees as e
INNER JOIN demp_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31');

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
birth_date,
from_date,
to_date,
title
INTO mentorship_eligibilty
FROM mentorship_eligibilty_2
ORDER BY emp_no, first_name DESC;

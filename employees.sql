-- create_hr_db_sqlite.sql
-- A sample script for a small "HR" database, adapted for SQLite with more data.

PRAGMA foreign_keys = ON;

-- 1. Drop old tables if they exist
DROP TABLE IF EXISTS employee_projects;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS projects;

-- 2. Create the 'departments' table
CREATE TABLE departments (
    dept_id INTEGER PRIMARY KEY AUTOINCREMENT,
    dept_name TEXT NOT NULL
);

-- 3. Create the 'employees' table
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    dept_id INTEGER,
    salary REAL,
    hire_date TEXT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 4. Create the 'projects' table
CREATE TABLE projects (
    project_id INTEGER PRIMARY KEY AUTOINCREMENT,
    project_name TEXT NOT NULL,
    start_date TEXT,
    end_date TEXT
);

-- 5. Create a join table (many-to-many) between employees and projects
CREATE TABLE employee_projects (
    emp_id INTEGER,
    project_id INTEGER,
    assigned_date TEXT,
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- 6. Insert departments (6 total)
INSERT INTO departments (dept_name)
VALUES
    ('Human Resources'),  -- dept_id=1
    ('Finance'),          -- dept_id=2
    ('Engineering'),      -- dept_id=3
    ('Marketing'),        -- dept_id=4
    ('Sales'),            -- dept_id=5
    ('IT');               -- dept_id=6

-- 7. Insert employees (13 total)
INSERT INTO employees (first_name, last_name, dept_id, salary, hire_date)
VALUES
    -- Original 6
    ('John',    'Doe',         1,  50000,  '2020-01-15'),  -- emp_id=1
    ('Jane',    'Smith',       3,  85000,  '2019-03-01'),  -- emp_id=2
    ('Bob',     'Johnson',     2,  60000,  '2021-07-10'),  -- emp_id=3
    ('Alice',   'Williams',    2,  65000,  '2018-11-20'),  -- emp_id=4
    ('Michael', 'Brown',       3,  95000,  '2022-05-05'),  -- emp_id=5
    ('Emily',   'Davis',       4,  70000,  '2017-08-12'),  -- emp_id=6

    -- 7 more
    ('Sam',     'Wilson',      5,  55000,  '2021-01-01'),  -- emp_id=7   (Sales)
    ('Sarah',   'Clarke',      6,  80000,  '2022-09-10'),  -- emp_id=8   (IT)
    ('Peter',   'Parker',      3,  87000,  '2021-01-01'),  -- emp_id=9   (Engineering)
    ('Daisy',   'Jones',       1,  45000,  '2023-01-10'),  -- emp_id=10  (HR)
    ('Tony',    'Stark',       3, 120000,  '2020-03-15'),  -- emp_id=11  (Engineering)
    ('Natasha', 'Romanoff',    4,  90000,  '2019-07-20'),  -- emp_id=12  (Marketing)
    ('Clint',   'Barton',      6,  75000,  '2017-12-25');  -- emp_id=13  (IT)

-- 8. Insert projects (5 total)
INSERT INTO projects (project_name, start_date, end_date)
VALUES
    ('Project Alpha', '2022-01-01', '2022-06-30'),  -- project_id=1
    ('Project Beta',  '2021-02-15', '2021-12-31'),  -- project_id=2
    ('Project Gamma', '2022-08-01', '2023-01-15'),  -- project_id=3
    ('Project Delta', '2023-02-01', '2023-09-30'),  -- project_id=4
    ('Project Omega', '2021-11-01', '2022-12-31');  -- project_id=5

-- 9. Insert relationships in 'employee_projects'
INSERT INTO employee_projects (emp_id, project_id, assigned_date)
VALUES
    -- Original links
    (1, 1, '2022-01-15'),   -- John -> Alpha
    (2, 1, '2022-02-01'),   -- Jane -> Alpha
    (2, 2, '2021-03-15'),   -- Jane -> Beta
    (3, 2, '2021-05-01'),   -- Bob  -> Beta
    (5, 1, '2022-03-10'),   -- Michael -> Alpha

    -- Additional
    (7, 3, '2022-08-01'),   -- Sam -> Gamma
    (8, 3, '2022-09-01'),   -- Sarah -> Gamma
    (9, 1, '2022-05-01'),   -- Peter -> Alpha
    (11, 1, '2022-03-15'),  -- Tony -> Alpha
    (11, 2, '2021-03-15'),  -- Tony -> Beta
    (12, 4, '2023-03-10'),  -- Natasha -> Delta
    (5, 5, '2022-04-01'),   -- Michael -> Omega
    (8, 5, '2022-10-01'),   -- Sarah -> Omega
    (13, 2, '2019-12-30');  -- Clint -> Beta

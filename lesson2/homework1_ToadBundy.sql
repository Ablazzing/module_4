--1-2.Создание таблицы department
CREATE TABLE department(id serial PRIMARY KEY, name VARCHAR(100), isProfit BOOLEAN );
INSERT INTO department (name, isProfit)
VALUES
('Бухгалтерия', false ),
('Кредитный отдел', true),
('Отдел продаж', true),
('Правление', false);

--3-4.Создание таблицы employee
CREATE TABLE employee (id serial PRIMARY KEY, full_name VARCHAR(100), salary numeric, department_id INTEGER REFERENCES department(id));
INSERT INTO employee (full_name, salary, department_id)
VALUES
('Петров Иван', 30000, (select id from department where department.name='Отдел продаж')),
('Иванова Наталья', 50000, (select id from department where department.name='Бухгалтерия')),
('Морских Петр', 100000, (select id from department where department.name='Правление')),
('Улюкаев Владимир', 200000, (select id from department where department.name='Правление')),
('Заморский Виктор', 70000, (select id from department where department.name='Кредитный отдел'));

--5.Вывод сотрудников правления
SELECT employee.id, full_name, salary, department_id FROM 
employee JOIN department ON department.id = employee.department_id
WHERE department.name = 'Правление'; 
--6.Сумма всех зарплат сотрудников
SELECT SUM(salary) FROM employee;
--7.ФИО сотрудника и является ли отдел прибыльным
SELECT full_name, isProfit FROM 
employee JOIN department ON department.id = employee.department_id; 
--8.Вывести на экран только тех сотрудников, которые получают от 10_000 до 100_000 
--(включительно) - вывод: все поля employee
SELECT employee.id, full_name, salary, department_id FROM
employee JOIN department ON department.id = employee.department_id
WHERE (salary>=10000) and (salary<=100000);
--9.Удалить Мирского Петра
DELETE FROM employee
WHERE full_name = 'Морских Петр';
--10.Поменять название Кредитный отдел на депозитный и статус на false
UPDATE department 
SET name = 'Депозитный отдел',isProfit = false
WHERE department.name = 'Кредитный отдел';
--11.Вывод всех сотрудников содержащих иван
SELECT * FROM employee
WHERE full_name ILIKE '%иван%';
--12.Средняя зарплата по отделам
SELECT name, CAST(AVG(salary) as decimal(8,0)) from 
department JOIN employee ON department.id = employee.department_id
GROUP BY name;
--13.Удалить таблицы
DROP TABLE employee;
DROP TABLE department;


select a.first_name,b.title,a.title
	from employees
	where a.emp_no = b.emp_no -- 조인조건
	and a.gender = "F"; -- row 선택조건
	
select count(*)
	from employees a, titles b
	where a.emp_no = b.emp_no;

-- natural join
select count(*)
	from employees
	natural join titles;
	
--join~using
select count(*)
	from employees
	join titles using (emp_no);
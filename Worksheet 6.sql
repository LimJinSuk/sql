-- 기본문제 1 --
select concat(first_name," ",last_name) as 이름
	from employees
	where emp_no =10944;
	
-- 기본문제 2 --
select concat(first_name," ",last_name) as 이름,
		gender as 성별,
		hire_date as 입사일
	from employees
	order by 입사일 ASC;

-- 기본문제 3 --
select if(gender="F","여자","남자")as 성별,
		count(emp_no)
	from employees
	group by gender;

-- 기본문제 4 --
select count(emp_no) as 직원수
	from salaries
	where  to_date = "9999-1-1";	
	
-- 기본문제 5 --
select count(dept_no) as 부서
	from departments;
	
-- 기본문제 6 --
select count(dept_no) as 현재부서매니저
	from dept_manager
	where to_date="9999-1-1";
	
-- 기본문제 7 --
select dept_name as 부서명
	from departments
	order by length(dept_name) DESC;
	
-- 기본문제 8 --
select count(emp_no) as 사원수
	from salaries
	where to_date = "9999-1-1"
    and salary >= 120000;
	
-- 기본문제 9 --
select distinct title as 직책명
	from titles
	order by length(title) DESC;

-- 기본문제 10 --
select count(emp_no) as Engineer수
	from titles
	where  to_date = "9999-1-1"
    and title='Engineer';	

-- 기본문제 11 --
select date_format(from_date,"%Y년 %m월 %d일") as 날짜,title
	from titles
	where emp_no = 13250
    group by title
	order by date(from_date) ASC;
	
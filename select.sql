select a.first_name,b.title,a.title
	from employees
	where a.emp_no = b.emp_no -- 조인조건
	and a.gender = "F"; -- row 선택조건

-- equit join	
select count(*)
	from employees a, titles b
	where a.emp_no = b.emp_no; -- 조인조건

-- natural join
select count(*)
	from employees
	natural join titles;
	
--join ~ using
select count(*)
	from employees
	join titles using (emp_no);
	
-- join ~ on
select count(*)
	from employees a
	join titles b on a.emp_no = b.emp_no;

-- 직책이 engineer인 여직원의 이름과 직책
select a.first_name,b.title
	from employees a,titles b
	where a.emp_no = b.emp_no -- 조인조건
	and b.title = "Engineer"  -- 선택조건
	and a.gender = "F";
	
select a.first_name,b.title
	from employees a
	join titles b
	on a.emp_no = b.emp_no 
	where b.title = "Engineer"  -- 선택조건
	and a.gender = "F";
	
-- 현재 회사 상황을 반영한 직원별 근무부서를  사번, 직원 전체이름, 근무부서 형태로 출력
select a.emp_no as 사번, 
	concat(a.first_name," ",a.last_name) as 전체이름,
	c.dept_name as 근무부서
	
	from employees a , dept_emp b, departments c
	where a.emp_no=b.emp_no
	and c.dept_no = b.dept_no
	and b.to_date = "9999-1-1";
	
-- 현재 회사에서 지급되고 있는 급여체계를 반영한 결과를  사번, 전체이름, 연봉  형태로 출력\
select a.emp_no as 사번, 
	concat(a.first_name," ",a.last_name) as 전체이름, 
	b.salary as 연봉
	
	from employees a, salaries b
	where a.emp_no = b.emp_no
	and b.to_date = "9999-1-1"	
	order by b.salary DESC;

-- 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력
select b.dept_no as 부서번호
	from employees a, dept_emp b
	where a.emp_no = b.emp_no
	and b.to_date = "9999-1-1"
	and concat(a.first_name," ",a.last_name)="Fai Bale";

select a.emp_no as 사번, 
	concat(a.first_name," ",a.last_name) as 전체이름
	from employees a, dept_emp b
	where a.emp_no = b.emp_no
	and b.to_date = "9999-1-1"
	and b.dept_no = "d004";
	
-- subquery 두개 합친 것 
select a.emp_no as 사번, 
	concat(a.first_name," ",a.last_name) as 전체이름
	from employees a, dept_emp b
	where a.emp_no = b.emp_no
	and b.to_date = "9999-1-1"
	and b.dept_no = (
		select b.dept_no as 부서번호
		from employees a, dept_emp b
		where a.emp_no = b.emp_no
		and b.to_date = "9999-1-1"
		and concat(a.first_name," ",a.last_name)="Fai Bale"
		);

-- 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의  이름, 급여를 출력
select concat(a.first_name," ",a.last_name) as 이름 ,b.salary as 급여
	from employees a, salaries b
	where a.emp_no = b.emp_no
	and b.salary < (
		select avg(salary)
		from salaries
		where to_date = "9999-1-1"
		);
		
-- 현재 가장적은 평균 급여를 받고 있는 직책의  평균 급여를 출력
-- : 직책별 가장 적은 평균 급여
select c.title, avg(salary) 
	FROM employees a, salaries b, titles c
	where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and c.to_date = "9999-1-1"
	and b.to_date = "9999-1-1"
	group by c.title
	limit 0,1; -- 0번째 인뎃스부터 1개만 추출 원래는 여러개 출력됨

--Top K
select c.title, avg(a.salary),a.birth_date;

--from 절을 이용한 서브쿼리
select *
	from (
	 	select c.title,avg(a.salary) as avg_salary
			from salaries a, employees b, titles c
			where a.emp_no = b.emp_no
			and b.emp_no = c.emp_no
			and a.to_date = "9999-1-1"
			and c.to_date = "9999-1-1"
			group by c.title )
			a;
	
--현재급여가 50000 이상인 직원 이름 출력
-- 1.join으로 해결
select a.first_name
	from employees a, salaries b
	where a.emp_no = b.emp_no
	and b.to_date = "9999-1-1"
	and b.salary > 50000;
	
-- 2.서브쿼리로 해결
select first_name
	from employees
	where emp_no in (
		select emp_no
		from salaries
		where to_date = "9999-1-1"
		and salary > 50000
		);
	
-- 각 부서별로 최고 월급을 받는 직원의 이름과 월급 출력
select c.dept_no as 부서명,
	max(salary) as max_salary,
	concat(a.first_name," ",a.last_name) as 이름
	
	FROM employees a, salaries b, dept_emp c
	where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and b.to_date = "9999-1-1"
	and c.to_date = "9999-1-1" 
	group by b.dept_no;
	
--1) where 절에 서브쿼리를 사용하는 방법
select a.first_name, c.dept_no, b.salary
	from employees a, salaries b, dept_emp c
	where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and b.to_date = "9999-1-1"
	and c.to_date = "9999-1-1"
	and (c.dept_no, b.salary) in (
		select c.dept_no as 부서명,
		max(salary) as max_salary,
		concat(a.first_name," ",a.last_name) as 이름
		
		FROM employees a, salaries b, dept_emp c
		where a.emp_no = b.emp_no
		and a.emp_no = c.emp_no
		and b.to_date = "9999-1-1"
		and c.to_date = "9999-1-1" 
		group by b.dept_no);
	

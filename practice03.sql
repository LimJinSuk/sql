-- 문제1
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 
select a.emp_no as 사번,
	concat(a.first_name," ",a.last_name) as 이름,
	b.salary as 연봉
	from employees a, salaries b
	where a.emp_no = b.emp_no
	and b.to_date = "9999-1-1"
	order by 연봉 DESC;
	
-- 문제 2
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력
select a.emp_no as 사번,
	concat(a.first_name," ",a.last_name) as 이름,
	b.title as 직책
	from employees a, titles b
	where a.emp_no = b.emp_no
	and b.to_date = "9999-1-1"
	order by 이름;
	
-- 문제 3
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력
select a.emp_no as 사번,
	concat(a.first_name," ",a.last_name) as 이름,
	b.dept_no as 부서
	from employees a, dept_emp b
	where a.emp_no = b.emp_no
	and b.to_date = "9999-1-1"
	order by 이름;

-- 문제 4
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력
select a.emp_no as 사번,
	concat(a.first_name," ",a.last_name) as 이름,
	c.salary as 연봉,
	d.title as 직책,
	b.dept_no as 부서
	from employees a, dept_emp b, salaries c, titles d
	where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and a.emp_no = d.emp_no
	and b.to_date = "9999-1-1"
	and c.to_date = "9999-1-1"
	and d.to_date = "9999-1-1"
	order by 이름;

-- 문제5????????????????????????
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력
-- 현재 ‘Technique Leader’의 직책으로 근무하는 사원은 고려하지 않음
select a.emp_no as 사번, 
	date_format(from_date,"%Y년 %m월 %d일") as 날짜,
	concat(a.first_name," ",a.last_name) as 이름
	from employees a,titles b
	where a.emp_no = b.emp_no
	and b.title = "Technique Leader"
	and b.to_date <> "9999-01-01";
	
-- 문제 6
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회
select concat(a.first_name," ",a.last_name) as 이름,
	b.dept_no as 부서명,
	c.title as 직책
	from employees a, dept_emp b, titles c
	where a.emp_no=b.emp_no
	and a.emp_no = c.emp_no
	and c.to_date = "9999-01-01"
    and b.to_date = "9999-01-01"
	and a.last_name like "S%";
	
-- 문제 7
-- 현재,직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력
select concat( a.first_name, " ", a.last_name ) as 이름,
			b.salary as 월급
	FROM employees a, salaries b, titles c
	where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and b.to_date = "9999-1-1"
	and c.to_date = "9999-1-1"
	and c.title = "Engineer"
	and b.salary >= 40000
	order by b.salary DESC;

-- 문제 8
-- 현재 최소 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력
select c.title as 직책, b.salary as 급여
	FROM employees a, salaries b, titles c
	where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and b.to_date = "9999-1-1"
	and c.to_date = "9999-1-1"
	group by c.title
	having b.salary > 50000
	order by 급여 DESC;  


-- 문제 9
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력
select c.dept_name as 부서, avg(b.salary) as 급여
	FROM employees a, salaries b, departments c, dept_emp d
	where a.emp_no = b.emp_no
	and a.emp_no = d.emp_no
	and c.dept_no = d.dept_no
	and b.to_date = "9999-1-1"
	and d.to_date = "9999-1-1"
	group by c.dept_name
	order by 급여 DESC;
	
-- 문제 10
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력
select c.title as 직책, avg(b.salary) as 급여
	FROM employees a, salaries b, titles c
	where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and b.to_date = "9999-1-1"
	and c.to_date = "9999-1-1"
	group by c.title
	order by 급여 DESC; 
	
-- 문제 1
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명
select count(a.emp_no) as 사원수
	from employees a, salaries b
	where a.emp_no = b.emp_no
	and b.salary > (
		select avg(salary)
		from salaries
		where to_date = "9999-1-1"
		);
		

-- 문제 2
-- 현재,각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 연봉의 내림차순으로 조회
select a.emp_no as 사번, 
	concat(a.first_name," ",a.last_name) as 이름,
	b.salary as 부서연봉
	from employees a, salaries b, dept_emp c
	where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and c.to_date = "9999-1-1"
	and b.to_date = "9999-1-1"
	group by c.dept_no
	order by 부서연봉 DESC;
	
-- 정답:조건에 맞는 것을 테이블로써 가져옴 where보다 가벼움
select a.emp_no, concat(a.first_name, " ", a.last_name), b.salary
   from employees a, 
          salaries b, 
		  dept_emp c,
         (   select b.dept_no, max(c.salary) as max_salary
              from employees a, dept_emp b, salaries c
             where a.emp_no = b.emp_no
               and c.emp_no = a.emp_no
	           and c.to_date = "9999-01-01"
	           and b.to_date = "9999-01-01"
          group by b.dept_no ) d		 
where a.emp_no = b.emp_no
   and a.emp_no = c.emp_no
   and c.dept_no = d.dept_no
   and b.to_date = "9999-01-01"
   and c.to_date = "9999-01-01"
   and b.salary = d.max_salary;

-- 문제 3
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회
select a.emp_no as 사번,
	concat(a.first_name," ",a.last_name) as 이름,
	b.salary as 연봉
	from employees a, salaries b
	where a.emp_no = b.emp_no
	and b.to_date = "9999-1-1"
	and b.salary > (
		select avg(b.salary)
			from employees a, salaries b, dept_emp c
			where a.emp_no = b.emp_no
			and a.emp_no = c.emp_no
			and b.to_date = "9999-1-1"
			and c.to_date = "9999-1-1"
	);
	
--정답
 select a.emp_no, concat(a.first_name, " ", a.last_name), b.salary
   from employees a, 
          salaries b, 
		  dept_emp c,
         (   select b.dept_no, avg(c.salary) as avg_salary
              from employees a, dept_emp b, salaries c
             where a.emp_no = b.emp_no
               and c.emp_no = a.emp_no
	           and c.to_date = "9999-01-01"
	           and b.to_date = "9999-01-01"
          group by b.dept_no ) d		 
where a.emp_no = b.emp_no
   and a.emp_no = c.emp_no
   and c.dept_no = d.dept_no
   and b.to_date = "9999-01-01"
   and c.to_date = "9999-01-01"
   and b.salary > d.avg_salary;
   

-- 문제 4??????????????
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력
select a.emp_no as 사번,
	concat(a.first_name," ",a.last_name) as 이름,
	concat(b.first_name," ",b.last_name) as 매니저_이름,
	c.dept_name as 부서
	from employees a, dept_manager b, departments c
	where a.emp_no = b.emp_no
	and b.to_date = "9999-1-1";
	
--정답
 select e.emp_no as 사번, 
         concat(e.first_name, " ", e.last_name) as 이름, 
		 concat(m.first_name, " ", m.last_name) as 매니저, 
		 d.dept_name as 부서
  from employees e,
         dept_emp de,
	     dept_manager dm,
	     employees m,
         departments d
where e.emp_no = de.emp_no
   and de.dept_no = dm.dept_no
   and dm.emp_no = m.emp_no
   and d.dept_no = de.dept_no
   and de.to_date = "9999-01-01"
   and dm.to_date = "9999-01-01";
   

-- 문제 5???????????
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력
select a.emp_no as 사번,
	concat(a.first_name," ",a.last_name) as 이름,
	e.title as 직책,
	c.salary as 연봉
	from employees a,dept_emp b,salaries c,titles e
	where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and a.emp_no = e.emp_no
	and b.to_date="9999-1-1"
	and c.to_date="9999-1-1"
	and e.to_date="9999-1-1"
	and b.dept_no = (
		select b.dept_no as 부서명,
			avg(c.salary) as 평균연봉
			from employees a,dept_emp b,salaries c
			where a.emp_no = b.emp_no
			and a.emp_no = c.emp_no
			and b.to_date="9999-1-1"
			and c.to_date="9999-1-1"
			group by b.dept_no
			order by 평균연봉 DESC
			limit 0,1
	);

--정답
select a.emp_no, a.first_name, b.title, c.salary
  from employees a,
       titles b,
       salaries c, 
	   dept_emp d,
       (  select b.dept_no, avg(c.salary )
            from employees a, dept_emp b, salaries c
           where a.emp_no = b.emp_no
             and a.emp_no = c.emp_no
             and b.to_date = "9999-01-01"
             and c.to_date = "9999-01-01"
	    group by b.dept_no
        order by avg(c.salary ) desc
           limit 0, 1) e
 where a.emp_no = b.emp_no
    and a.emp_no = c.emp_no
    and a.emp_no = d.emp_no
    and d.dept_no = e.dept_no;
	
		
-- 문제 6
-- 평균 연봉이 가장 높은 부서는
select d.dept_name as 부서명,
	avg(c.salary) as 평균연봉
	from employees a,dept_emp b,salaries c,departments d
	where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and d.dept_no = b.dept_no
	and b.to_date="9999-1-1"
	and c.to_date="9999-1-1"
	group by d.dept_name
	order by 평균연봉 DESC
	limit 0,1;
	

-- 문제 7
-- 평균 연봉이 가장 높은 직책은
select b.title as 직책,
	avg(c.salary) as 평균연봉
	from employees a,titles b,salaries c
	where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and b.to_date="9999-1-1"
	and c.to_date="9999-1-1"
	group by b.title
	order by 평균연봉 DESC
	limit 0,1;
	
-- 문제 8
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력
select * 
 from employees a, salaries b ;



--정답
select d.dept_name as "부서 이름",
         concat(e.first_name, " ", e.last_name) as "사원 이름", 
	     es.salary as 월급, 
         concat(m.first_name, " ", m.last_name) as "매니저 이름", 
         ms.salary as "매니저 월급"
  from employees e,
	     dept_emp de,
	     dept_manager dm,
	     employees m,
         salaries es,
         salaries ms,
         departments d
where e.emp_no = de.emp_no
   and de.dept_no = dm.dept_no
   and dm.emp_no = m.emp_no
   and e.emp_no = es.emp_no
   and m.emp_no = ms.emp_no
   and de.dept_no = d.dept_no
   and de.to_date = "9999-01-01"
   and dm.to_date = "9999-01-01"
   and es.to_date = "9999-01-01"
   and ms.to_date = "9999-01-01"
   and es.salary > ms.salary;







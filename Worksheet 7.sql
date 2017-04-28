-- 집계문제 1 --
select max(salary) as 최고임금,
		min(salary) as 최저임금,
		max(salary)-min(salary) as "최고임금-최저임금"
	from salaries;
	
	
-- 집계문제 2 --
select date_format(max(hire_date),"%Y년 %m월 %d일")as 입사일
	from employees;
		
	
-- ?집계문제 3 --
select date_format(min(hire_date),"%Y년 %m월 %d일")as 입사일
	from employees;


-- 집계문제 4 --
select avg(salary) as 평균연봉
	from salaries  
	where to_date="9999-1-1";
	
	
-- 집계문제 5 --
select max(salary) as 최고연봉, min(salary) as 최저연봉
	from salaries 
	where to_date="9999-1-1";
	
	
-- 집계문제 6 --	
select period_diff(date_format(min(birth_date),"%Y"),
					date_format(now(),"%Y")) as 최연소,
		period_diff(date_format(max(birth_date),"%Y"),
					date_format(now(),"%Y")) as 최고령  
	from employees;
	
select floor( period_diff( date_format( now(), "%Y%m"), date_format( max(birth_date), "%Y%m") ) /12  ) as "제일 어린 사원 나이",
		 floor( period_diff( date_format( now(), "%Y%m"), date_format( min(birth_date), "%Y%m") ) /12  ) as "최고 연장자  사원 나이"
  from employees;
	
	
	
-- PART II: SALARY ANALYSIS
-- 1. View the salaries table

select * from salaries;

-- 2. Return the top 20% of teams in terms of average annual spending

with total_spent as(
select teamID, yearID, sum(salary) as total
from salaries
group by teamID, yearID
order by teamID, yearID 
),
avg_total as (
select teamID, avg(total) as avg_spend,
ntile(5) over(order by avg(total) desc) as spent_pct
from total_spent
group by teamID)

select teamID, round(avg_spend/1000000, 1) as avg_spend_millions
from avg_total
where spent_pct =1;

-- 3. For each team, show the cumulative sum of spending over the years

with total_spent as(
select teamID, yearID, sum(salary) as total
from salaries
group by teamID, yearID
order by teamID, yearID 
)
select teamID, yearID, sum(total) over(partition by teamID order by yearID) as cum_sum
from total_spent
group by teamID, yearID
order by teamID, yearID; 

-- 4. Return the first year that each team's cumulative spending surpassed 1 billion

with total_spent as(
select teamID, yearID, sum(salary) as total
from salaries
group by teamID, yearID
order by teamID, yearID 
),
billion_count as(
select teamID, yearID, round(sum(total) over(partition by teamID order by yearID)/1000000000, 1) as cum_sum_billions
from total_spent
group by teamID, yearID
order by teamID, yearID),

first_year as(
select teamID, min(yearID) as first_year, cum_sum_billions as cum_sum,
row_number() over(partition by teamID order by cum_sum_billions) as rn
from billion_count
where cum_sum_billions>=1
group by teamID , cum_sum)

select teamID, first_year, cum_sum
from first_year
where rn=1
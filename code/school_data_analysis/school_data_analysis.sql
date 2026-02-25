-- PART I: SCHOOL ANALYSIS

-- 1. View the schools and school details tables
select * from schools;
select * from school_details;

-- 2. In each decade, how many schools were there that produced players?
SELECT
    (yearID DIV 10) * 10 AS decade,
    COUNT(DISTINCT schoolID) AS schools_produced_players
FROM schools
GROUP BY decade
ORDER BY decade;

-- 3. What are the names of the top 5 schools that produced the most players?
select s.schoolID, d.name_full, count(distinct s.playerID) as player_count
from schools s
join school_details d 
on s.schoolID =d.schoolID
group by schoolID
order by player_count desc
limit 5;

 -- 4. For each decade, what were the names of the top 3 schools that produced the most players?
with players_per_school as(
select (s.yearID DIV 10)*10 as decade, d.name_full, count(distinct s.playerID) as player_count
from schools s
join school_details d 
on s.schoolID =d.schoolID
group by d.name_full, decade
order by player_count desc),

rn as (select decade, name_full, player_count, 
row_number() over(partition by decade order by player_count desc) as row_num 
from players_per_school)

select decade, name_full, player_count from rn
where row_num <=3
order by decade desc, row_num;
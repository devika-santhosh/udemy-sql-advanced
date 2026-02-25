-- PART IV: PLAYER COMPARISON ANALYSIS

-- 1. View the players table

select * from players;

-- 2. Which players have the same birthday?
with cte as(
select playerID, nameGiven, cast(concat(birthYear, '-', birthMonth, '-', birthDay) as date) as birthday
from players
)

select birthday, group_concat(nameGiven separator ', ') as names, count(nameGiven) as cnt
from cte
where birthday is not null
group by birthday
having count(nameGiven)>1;

-- 3. Create a summary table that shows for each team, what percent of players bat right, left and both
select  teamID,
sum(case when bats = "L" then 1 else 0 end)*100/count(p.playerID) as Left_hand,
sum(case when bats = "R" then 1 else 0 end)*100/count(p.playerID) as Right_hand,
sum(case when bats = "B" then 1 else 0 end)*100/count(p.playerID) as Both_hand
from players p
left join salaries s
on p.playerID=s.playerID
group by teamID;


-- 4. How have average height and weight at debut game changed over the years, and what's the decade-over-decade difference?
with hw as(
select (year(debut) div 10)*10 as decade, avg(height) as avg_height, avg(weight) as avg_weight
from players
group by decade
order by decade
)

select decade, avg_height-lag(avg_height) over(order by decade) as height_diff, 
avg_weight-lag(avg_weight) over(order by decade) as weight_diff
from hw
where decade is not null

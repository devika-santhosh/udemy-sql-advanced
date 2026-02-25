-- PART III: PLAYER CAREER ANALYSIS

-- 1. View the players table and find the number of players in the table

select * from players;
select count(playerID) from players;

-- 2. For each player, calculate their age at their first game, their last game, and their career length (all in years). 
-- Sort from longest career to shortest career.

select playerID, 
cast(concat(birthYear, '-', birthMonth, '-', birthDay) as date) as birth_day, 
timestampdiff(year, cast(concat(birthYear, '-', birthMonth, '-', birthDay) as date), debut) as first_game_age,
timestampdiff(year, cast(concat(birthYear, '-', birthMonth, '-', birthDay) as date), finalGame) as last_game_age,
timestampdiff(year, debut, finalGame) as career_length
from players
order by career_length desc;

-- 3. What team did each player play on for their starting and ending years?

select p.playerID, p.nameGiven, p.debut, p.finalGame, s.teamID, s.yearID, e.teamID, e.yearID
from players p
join salaries s
on p.playerID =s.playerID and year(p.debut)=s.yearID
join salaries e
on p.playerID =e.playerID and year(p.finalGame)=e.yearID;


-- 4. How many players started and ended on the same team and also played for over a decade?

with cte as(
select p.playerID, p.nameGiven, p.debut, p.finalGame, s.teamID as starting_team, s.yearID as starting_year, e.teamID as ending_team, e.yearID as ending_year
from players p
join salaries s
on p.playerID =s.playerID and year(p.debut)=s.yearID
join salaries e
on p.playerID =e.playerID and year(p.finalGame)=e.yearID
),
player_count as
(select playerID
from cte
where starting_team = ending_team and ending_year-starting_year>=10)

select count(*) as total_players from player_count
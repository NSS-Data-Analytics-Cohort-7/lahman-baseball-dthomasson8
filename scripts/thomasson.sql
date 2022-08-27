---1. What range of years for baseball games played does the provided database cover? 
SELECT year
FROM homegames
GROUP BY year
ORDER BY year DESC;
---1. ANSWER: 1871-2016. 145 years.


---2. Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?
SELECT p.namefirst, p.namelast, p.height, p.playerid, a.teamid, a.g_all, a.playerid
FROM people AS p
INNER JOIN appearances as a
ON a.playerid = p.playerid
GROUP BY p.height, p.namefirst, p.namelast, p.playerid, a.teamid, a.g_all, a.playerid
ORDER BY p.height;
---2. ANSWER: Eddie Gaedel, who was 3'7" (43 inches tall). Eddie played in a total of one game for the St. Louis Browns (SLA).


---3. Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?
SELECT *
from schools
WHERE schoolname LIKE 'Vanderbilt%';

SELECT *
FROM collegeplaying
WHERE schoolid LIKE 'vandy';

SELECT *
FROM salaries;

WITH total_salaries AS (
SELECT playerid, SUM(salary) AS total_salary
    FROM salaries
    GROUP BY playerid)
    
SELECT DISTINCT p.playerid, namefirst, namelast, ts.total_salary
FROM people AS p
LEFT JOIN collegeplaying as c
ON p.playerid = c.playerid
LEFT JOIN total_salaries as ts
on p.playerid = ts.playerid
WHERE schoolid LIKE 'vandy' AND ts.total_salary IS NOT NULL
ORDER BY ts.total_salary DESC;
---3. ANSWER: David Price (priceda01) made a total salary of $81,851,296.00 in the majors.


---4. Using the fielding table, group players into three groups based on their position: label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery". Determine the number of putouts made by each of these three groups in 2016.
SELECT sum(po) as pos_putouts,
CASE WHEN pos = 'OF' THEN 'Outfield'
     WHEN pos IN ('SS','1B', '2B', '3B') THEN 'Infield'
     WHEN pos IN ('P','C') THEN 'Battery'
     ELSE 'Other'
     END AS position
FROM fielding
where yearid = '2016'
group by position;
---4. ANSWER: Battery = 41,424. Infield = 58,934. Outfield = 29,560.


---5. 5. Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?
---USE CASE STATEMENT TO GET DECADES.TEAMS IS THE TABLE YOU WANT. USE YOUR BRAIN, YOU ARE NOT DUM DUM.
SELECT *
FROM teams;
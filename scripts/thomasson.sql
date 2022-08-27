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
SELECT *
FROM teams;
---
SELECT ROUND(CAST(sum(so) AS NUMERIC)/sum(g/2),2) AS avg_strikeouts,
       ROUND(CAST(sum(hr) AS NUMERIC)/sum(g/2),2) AS avg_homeruns,
CASE WHEN yearid BETWEEN '1920' AND '1929' THEN '1920s'
     WHEN yearid BETWEEN '1930' AND '1939' THEN '1930s'
     WHEN yearid BETWEEN '1940' AND '1949' THEN '1940s'
     WHEN yearid BETWEEN '1950' AND '1959' THEN '1950s'
     WHEN yearid BETWEEN '1960' AND '1969' THEN '1960s'
     WHEN yearid BETWEEN '1970' AND '1979' THEN '1970s'
     WHEN yearid BETWEEN '1980' AND '1989' THEN '1980s'
     WHEN yearid BETWEEN '1990' AND '1999' THEN '1990s'
     WHEN yearid BETWEEN '2000' AND '2009' THEN '2000s'
     WHEN yearid BETWEEN '2010' AND '2019' THEN '2010s'
     ELSE 'Other'
     END AS decades
FROM teams
GROUP BY decades
ORDER BY decades;
---CAST help from Hannah.
---5. ANSWER: Strikeouts increased as the years went on and homeruns were slowly increasing as well. There were some decades that this was not the case, but as an overall trend, both categories increased.


---6. Find the player who had the most success stealing bases in 2016, where __success__ is measured as the percentage of stolen base attempts which are successful. (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.
SELECT *
FROM battingpost;
---stolen + caught /stolen?
SELECT playerid, sb as stolen_bases, cs as caught_stealing,
       AS attempts
FROM battingpost
WHERE attempts > 19
GROUP BY playerid, sb, cs
ORDER BY cs DESC;

SELECT year
FROM homegames
GROUP BY year
ORDER BY year DESC;
---1. 1871-2016. 145 years.

SELECT p.namefirst, p.namelast, p.height, p.playerid, a.teamid, a.g_all, a.playerid
FROM people AS p
INNER JOIN appearances as a
ON a.playerid = p.playerid
GROUP BY p.height, p.namefirst, p.namelast, p.playerid, a.teamid, a.g_all, a.playerid
ORDER BY p.height;
---2. Eddie Gaedel, who was 3'7" (43 inches tall). Eddie played in a total of one game for the St. Louis Browns (SLA).

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
---3. David Price (priceda01) made a total salary of $81,851,296.00 in the majors.

---COME BACK TO 4 AND JUST MOVE ON!
SELECT * 
FROM fielding
CASE WHEN ;


---USE CASE STATEMENT TO GET DECADES.TEAMS IS THE TABLE YOU WANT. USE YOUR BRAIN, YOU ARE NOT DUM DUM.
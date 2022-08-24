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


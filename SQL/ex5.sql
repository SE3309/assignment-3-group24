-- ex5.sql
-- Part 5: SELECT queries
USE se3309_assignment3;

-- ----------------------------------------------------------
-- QUERY 1: Multi-table JOIN
-- Description: List all members, their names, and the clubs they belong to.
-- ----------------------------------------------------------
SELECT 
    m.student_id_number,
    pu.first_name,
    pu.last_name,
    c.club_name,
    m.role,
    m.status,
    m.date_start
FROM MEMBERSHIP m
JOIN STUDENT_USER su ON m.student_id_number = su.student_id_number
JOIN PERSON_USER pu ON su.person_email = pu.email
JOIN CLUB c ON m.club_id = c.club_id;

-- ----------------------------------------------------------
-- QUERY 2: Subquery (IN)
-- Description: Clubs that have at least one member.
-- ----------------------------------------------------------
SELECT 
    club_id,
    club_name,
    category,
    campus
FROM CLUB
WHERE club_id IN (
    SELECT DISTINCT club_id 
    FROM MEMBERSHIP
);

-- ----------------------------------------------------------
-- QUERY 3: EXISTS Subquery
-- Description: Students who have registered for at least one event.
-- ----------------------------------------------------------
SELECT 
    su.student_id_number,
    pu.first_name,
    pu.last_name
FROM STUDENT_USER su
JOIN PERSON_USER pu ON su.person_email = pu.email
WHERE EXISTS (
    SELECT 1
    FROM REGISTRATION r
    WHERE r.student_id_number = su.student_id_number
);

-- ----------------------------------------------------------
-- QUERY 4: Aggregation + GROUP BY
-- Description: Number of events created by each club.
-- ----------------------------------------------------------
SELECT 
    c.club_id,
    c.club_name,
    COUNT(e.event_id) AS total_events
FROM CLUB c
LEFT JOIN EVENT e ON c.club_id = e.club_id
GROUP BY c.club_id, c.club_name
ORDER BY total_events DESC;

-- ----------------------------------------------------------
-- QUERY 5: GROUP BY + HAVING (interesting query)
-- Description: Events with more than 5 registrations.
-- NOTE: If your dataset is smaller, change > 5 to > 0.
-- ----------------------------------------------------------
SELECT 
    e.club_id,
    e.event_id,
    e.title,
    COUNT(r.student_id_number) AS total_registrations
FROM EVENT e
JOIN REGISTRATION r 
    ON e.club_id = r.club_id 
   AND e.event_id = r.event_id
GROUP BY e.club_id, e.event_id, e.title
HAVING COUNT(r.student_id_number) > 5
ORDER BY total_registrations DESC;

-- ----------------------------------------------------------
-- QUERY 6: Anti-join using NOT IN
-- Description: Students who are NOT members of any club.
-- ----------------------------------------------------------
SELECT 
    su.student_id_number,
    pu.first_name,
    pu.last_name
FROM STUDENT_USER su
JOIN PERSON_USER pu ON su.person_email = pu.email
WHERE su.student_id_number NOT IN (
    SELECT student_id_number FROM MEMBERSHIP
);

-- ----------------------------------------------------------
-- QUERY 7: Filtering + ORDER BY
-- Description: Public events sorted by date.
-- ----------------------------------------------------------
SELECT 
    event_id,
    club_id,
    title,
    starts_at,
    venue_name,
    price_general,
    price_member
FROM EVENT
WHERE is_public = TRUE
ORDER BY starts_at ASC;

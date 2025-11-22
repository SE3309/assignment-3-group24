DROP VIEW IF EXISTS person_public;
DROP VIEW IF EXISTS gender_stats; -- just to clean up incase of re runs of script


CREATE VIEW person_public AS -- first view , projection of PERSON_USER
SELECT
    email,
    username,
    password_hash,
    user_id_number,
    first_name,
    last_name,
    phone,
    background
FROM PERSON_USER;

SELECT * FROM person_public; -- query

INSERT INTO person_public
    (email, username, password_hash, user_id_number, first_name, last_name, phone, background)
VALUES
    ('santiagoa@example.com',
     'santiaUser',
     'hashed_password_santi',
     'USER009',
     'Santiago',
     'Aristizabal',
     '999-999-9999',
     'Engineering');

     SELECT * FROM person_public; -- query after inserting to show system response


-- 2nd view below,  aggregate from Person_user, all rows then group by sex, and count 
     CREATE VIEW gender_stats AS
SELECT
    sex,
    COUNT(*) AS total_users
FROM PERSON_USER
GROUP BY sex;


SELECT * FROM gender_stats; -- query

INSERT INTO gender_stats (sex, total_users) -- attempt to update but should fail since this is not updateble
VALUES ('Male', 10);
-- ============================================
-- Item 3: Three Types of INSERT Statements
-- ============================================

USE se3309_assignment3;

-- ----------------------------------------
-- INSERT Type 1: Basic INSERT with explicit VALUES
-- ----------------------------------------
INSERT INTO PERSON_USER (
    email, 
    username, 
    phone, 
    password_hash, 
    payment_detail, 
    user_id_number, 
    first_name, 
    last_name, 
    birthday, 
    sex, 
    background
)
VALUES (
    'john.doe@example.com',
    'johndoe123',
    '519-555-0100',
    'hashed_password_12345',
    'VISA-1234',
    'USER001',
    'John',
    'Doe',
    '2002-05-15',
    'Male',
    'Computer Science student interested in robotics'
);

-- ----------------------------------------
-- INSERT Type 2: Multiple row INSERT (bulk insert)
-- ----------------------------------------
INSERT INTO PERSON_USER (
    email, username, phone, password_hash, payment_detail, 
    user_id_number, first_name, last_name, birthday, sex, background
)
VALUES 
    ('jane.smith@example.com', 'janesmith', '519-555-0101', 'hashed_password_67890', 
     'MC-5678', 'USER002', 'Jane', 'Smith', '2001-08-22', 'Female', 
     'Engineering student and club organizer'),
    ('bob.wilson@example.com', 'bobwilson', '519-555-0102', 'hashed_password_abcde', 
     'AMEX-9012', 'USER003', 'Bob', 'Wilson', '2003-03-10', 'Male', 
     'Business student passionate about entrepreneurship'),
    ('alice.chen@example.com', 'alicechen', '519-555-0103', 'hashed_password_fghij', 
     'VISA-3456', 'USER004', 'Alice', 'Chen', '2002-11-30', 'Female', 
     'Math student and event coordinator');

-- ----------------------------------------
-- INSERT Type 3: INSERT with SELECT (conditional insert)
-- Inserting users with a generated user_id based on existing data
-- This creates a "guest" user account based on existing user patterns
-- ----------------------------------------
INSERT INTO PERSON_USER (
    email, 
    username, 
    phone, 
    password_hash, 
    payment_detail, 
    user_id_number, 
    first_name, 
    last_name, 
    birthday, 
    sex, 
    background
)
SELECT 
    'guest@example.com' AS email,
    'guestuser' AS username,
    '519-555-9999' AS phone,
    'hashed_password_guest' AS password_hash,
    NULL AS payment_detail,
    CONCAT('USER', LPAD(COUNT(*) + 1, 3, '0')) AS user_id_number,
    'Guest' AS first_name,
    'User' AS last_name,
    '2000-01-01' AS birthday,
    'Other' AS sex,
    'Temporary guest account' AS background
FROM PERSON_USER;

-- ----------------------------------------
-- View the results
-- ----------------------------------------
SELECT * FROM PERSON_USER;
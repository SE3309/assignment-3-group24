USE se3309_assignment3;


-- 1. PERSON_USER (no foreign keys)

CREATE TABLE PERSON_USER (
    email VARCHAR(255) PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    payment_detail VARCHAR(255),
    user_id_number VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birthday DATE,
    sex VARCHAR(20),
    background VARCHAR(500)
);


-- 2. STUDENT_USER (references PERSON_USER)

CREATE TABLE STUDENT_USER (
    student_id_number VARCHAR(50) PRIMARY KEY,
    person_email VARCHAR(255) NOT NULL,
    school VARCHAR(200),
    faculty VARCHAR(200),
    program VARCHAR(200),
    year_of_study INT,
    FOREIGN KEY (person_email) REFERENCES PERSON_USER(email)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- 3. CLUB (references PERSON_USER via email)

CREATE TABLE CLUB (
    club_id VARCHAR(50) PRIMARY KEY,
    club_name VARCHAR(200) NOT NULL,
    campus VARCHAR(100),
    category VARCHAR(100),
    description TEXT,
    status VARCHAR(50),
    founded_date DATE,
    club_email VARCHAR(255),
    website_url VARCHAR(500),
    dues_amount DECIMAL(10,2),
    email VARCHAR(255),
    FOREIGN KEY (email) REFERENCES PERSON_USER(email)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- 4. EVENT (references CLUB)

CREATE TABLE EVENT (
    club_id VARCHAR(50),
    event_id VARCHAR(50),
    starts_at DATETIME NOT NULL,
    title VARCHAR(200) NOT NULL,
    ends_at DATETIME,
    description TEXT,
    status VARCHAR(50),
    is_public BOOLEAN DEFAULT TRUE,
    min_age INT,
    capacity INT,
    waitlist_enabled BOOLEAN DEFAULT FALSE,
    check_in_method VARCHAR(100),
    price_general DECIMAL(10,2),
    price_member DECIMAL(10,2),
    venue_name VARCHAR(200),
    PRIMARY KEY (club_id, event_id),
    FOREIGN KEY (club_id) REFERENCES CLUB(club_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- 5. MEMBERSHIP (references STUDENT_USER and CLUB)

CREATE TABLE MEMBERSHIP (
    student_id_number VARCHAR(50),
    club_id VARCHAR(50),
    date_start DATE NOT NULL,
    status VARCHAR(50),
    role VARCHAR(100),
    term_end DATE,
    dues_price_charged DECIMAL(10,2),
    currency VARCHAR(10),
    payment_status VARCHAR(50),
    paid_at DATETIME,
    payment_method VARCHAR(100),
    receipt_reference VARCHAR(200),
    PRIMARY KEY (student_id_number, club_id),
    FOREIGN KEY (student_id_number) REFERENCES STUDENT_USER(student_id_number)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (club_id) REFERENCES CLUB(club_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- 6. REGISTRATION (references STUDENT_USER and EVENT)

CREATE TABLE REGISTRATION (
    student_id_number VARCHAR(50),
    club_id VARCHAR(50),
    event_id VARCHAR(50),
    starts_at DATETIME,
    title VARCHAR(200),
    registration_time DATETIME NOT NULL,
    status VARCHAR(50),
    ticket_type VARCHAR(100),
    price_charged DECIMAL(10,2),
    currency VARCHAR(10),
    payment_status VARCHAR(50),
    paid_at DATETIME,
    payment_method VARCHAR(100),
    receipt_reference VARCHAR(200),
    checked_in_at DATETIME,
    cancel_reason VARCHAR(500),
    PRIMARY KEY (student_id_number, club_id, event_id),
    FOREIGN KEY (student_id_number) REFERENCES STUDENT_USER(student_id_number)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (club_id, event_id) REFERENCES EVENT(club_id, event_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- 7. WAITLIST (references STUDENT_USER and EVENT)

CREATE TABLE WAITLIST (
    student_id_number VARCHAR(50),
    club_id VARCHAR(50),
    event_id VARCHAR(50),
    starts_at DATETIME,
    title VARCHAR(200),
    position INT NOT NULL,
    status VARCHAR(50),
    invite_sent_at DATETIME,
    invite_expires_at DATETIME,
    converted_to_registration_at DATETIME,
    PRIMARY KEY (student_id_number, club_id, event_id),
    FOREIGN KEY (student_id_number) REFERENCES STUDENT_USER(student_id_number)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (club_id, event_id) REFERENCES EVENT(club_id, event_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

DESCRIBE PERSON_USER;
DESCRIBE STUDENT_USER;
DESCRIBE CLUB;
DESCRIBE EVENT;
DESCRIBE MEMBERSHIP;
DESCRIBE REGISTRATION;
DESCRIBE WAITLIST;


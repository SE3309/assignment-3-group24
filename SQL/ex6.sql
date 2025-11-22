-- ex6.sql
-- Part 6: Data modification commands

USE se3309_assignment3;


INSERT INTO REGISTRATION (
    student_id_number,
    club_id,
    event_id,
    starts_at,
    title,
    registration_time,
    status,
    ticket_type,
    price_charged,
    currency,
    payment_status,
    paid_at,
    payment_method,
    receipt_reference,
    checked_in_at,
    cancel_reason
)
SELECT
    w.student_id_number,
    w.club_id,
    w.event_id,
    w.starts_at,
    w.title,
    NOW() AS registration_time,
    'Confirmed' AS status,
    'General' AS ticket_type,
    e.price_general AS price_charged,
    'CAD' AS currency,
    'Paid' AS payment_status,
    NOW() AS paid_at,
    'Credit Card' AS payment_method,
    CONCAT('WL-', w.student_id_number, '-', w.event_id) AS receipt_reference,
    NULL AS checked_in_at,
    NULL AS cancel_reason
FROM WAITLIST AS w
JOIN EVENT AS e
      ON w.club_id = e.club_id
     AND w.event_id = e.event_id
LEFT JOIN REGISTRATION AS r
      ON r.student_id_number = w.student_id_number
     AND r.club_id = w.club_id
     AND r.event_id = w.event_id
WHERE w.status = 'invited'
  AND w.converted_to_registration_at IS NULL
  AND r.student_id_number IS NULL;



UPDATE MEMBERSHIP AS m
JOIN CLUB AS c
      ON m.club_id = c.club_id
SET m.dues_price_charged = c.dues_amount,
    m.currency = 'CAD'
WHERE m.dues_price_charged IS NULL
  AND c.dues_amount IS NOT NULL;



DELETE w
FROM WAITLIST AS w
JOIN EVENT AS e
      ON w.club_id = e.club_id
     AND w.event_id = e.event_id
WHERE e.ends_at < NOW() - INTERVAL 365 DAY
  AND w.status = 'expired';

/*
11. Birthday Attendance.

Writing a query to return the fraction of students,
rounded to two decimal places, who
attended school on their birthday. */

/*Returning the fraction of students who attended on their birthday. */
WITH BIRTHDAY_ATTENDANCE ( -- Attendance on birthday dates
    STUDENT_ID,
    ATTENDANCE
) AS (
    SELECT
        S.STUDENT_ID,
        A.ATTENDANCE
    FROM
        STUDENTS_P11   S
        LEFT JOIN ATTENDANCE_P11 A ON S.STUDENT_ID = A.STUDENT_ID
                                      AND EXTRACT(MONTH FROM A.SCHOOL_DATE) = EXTRACT(MONTH FROM S.DATE_BIRTH)
                                      AND EXTRACT(DAY FROM A.SCHOOL_DATE) = EXTRACT(DAY FROM S.DATE_BIRTH)
)
SELECT
    ROUND(
        AVG(ATTENDANCE),
        2
    ) AS FRACTION
FROM
    BIRTHDAY_ATTENDANCE;

/* 
05. Super Users.

A company defines its super users as
those who have made at least two
transactions. 
Writing a query to return, for each user, the
date when they become a super user, ordered by oldest super users first.
Users who are not super users should
also be present in the table. */


SELECT
    *
FROM
    USERS_P5;


CREATE TABLE RANKINGS_P5
    AS
        SELECT
            USER_ID,
            TRANSACTION_DATE,
            ROW_NUMBER()
            OVER(PARTITION BY USER_ID
                 ORDER BY
                     TRANSACTION_DATE
            ) AS RANKED_DATE
        FROM
            USERS_P5;


SELECT
    *
FROM
    RANKINGS_P5;


CREATE TABLE DIUSERS_P5
    AS
        SELECT DISTINCT
            ( USER_ID )
        FROM
            USERS_P5;


SELECT
    *
FROM
    DIUSERS_P5;


CREATE TABLE SUPERUSERS_P5
    AS
        SELECT
            USER_ID,
            TRANSACTION_DATE
        FROM
            RANKINGS_P5
        WHERE
            RANKED_DATE = 2


SELECT
    *
FROM
    SUPERUSERS_P5;


SELECT
    D.USER_ID,
    S.TRANSACTION_DATE
FROM
    DIUSERS_P5    D
    LEFT JOIN SUPERUSERS_P5 S ON D.USER_ID = S.USER_ID;

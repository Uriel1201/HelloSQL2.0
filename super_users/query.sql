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

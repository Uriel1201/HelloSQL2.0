with F2_USERS(
    user_id,
    join_date
) as (SELECT
    E.USER_ID,
    U.JOIN_DATE
FROM
         EVENTS_P8 E
    INNER JOIN USERS_P8 U ON E.USER_ID = U.USER_ID
WHERE
    E.TYPE = 'F2')


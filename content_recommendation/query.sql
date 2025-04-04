/*  
06. Content Recommendations

Writing a query to return page recommendations
to a social media user based on the
pages that their friends have liked, but
that they have not yet marked as liked. */


SELECT
    *
FROM
    FRIENDS_P6;


SELECT
    *
FROM
    LIKES_P6;



CREATE TABLE LIKES_FRIENDS_P6
    AS
        SELECT
            F.USER_ID,
            LI.PAGE_LIKES AS RECOMMENDATION
        FROM
                 FRIENDS_P6 F
            INNER JOIN LIKES_P6 LI ON F.FRIEND = LI.USER_ID;


SELECT
    *
FROM
    LIKES_FRIENDS_P6;


CREATE TABLE RECOMMENDATION_P6
    AS
        SELECT
            LF.USER_ID,
            LF.RECOMMENDATION,
            LI.PAGE_LIKES
        FROM
            LIKES_FRIENDS_P6 LF
            LEFT JOIN LIKES_P6         LI ON LF.USER_ID = LI.USER_ID
                                     AND LF.RECOMMENDATION = LI.PAGE_LIKES;

SELECT DISTINCT
    USER_ID,
    RECOMMENDATION
FROM
    RECOMMENDATION_P6
WHERE
    PAGE_LIKES IS NULL
ORDER BY
    USER_ID;

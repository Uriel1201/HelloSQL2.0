SELECT
    *
FROM
    FRIENDS_P6;


SELECT
    *
FROM
    LIKES_P6;


CREATE TABLE LIKES_FRIENDS_p6
    AS
        SELECT
            F.USER_ID,
            LI.PAGE_LIKES
        FROM
                 FRIENDS_P6 F
            INNER JOIN LIKES_P6 LI ON F.FRIEND = LI.USER_ID;


SELECT
    *
FROM
    LIKES_FRIENDS_P6;


CREATE TABLE RECOMMENDATIONS_P6
    AS
        SELECT
            LF.USER_ID,
            LI.PAGE_LIKES AS RECOMMENDED
        FROM
            LIKES_FRIENDS_P6 LF
            LEFT JOIN LIKES_P6         LI ON LF.USER_ID = LI.USER_ID
                                     AND LF.PAGE_LIKES = LI.PAGE_LIKES;

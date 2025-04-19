/* 
10. Project Aggregation 

Writing a query to return the start and end
dates of each project, and the number of
days it took to complete. */

/* Querying original data*/
SELECT
    *
FROM
    PROJECTS_P10;

                /*Querying the duration of each unique project.*/

WITH SORTED ( -- ordering dates
    S_D,
    E_D,
    PREV_END
) AS (
    SELECT
        START_DATE,
        END_DATE,
        LAG(END_DATE)
        OVER(
            ORDER BY
                START_DATE
        )
    FROM
        PROJECTS_P10
), PROJECT_FLAGS ( -- identifying unique projects
    S_D,
    E_D,
    PROJECT_ID
) AS (
    SELECT
        S_D,
        E_D,
        SUM(
            CASE
                WHEN PREV_END IS NULL THEN
                    1
                WHEN PREV_END = S_D THEN
                    0
                ELSE
                    1
            END
        )
    FROM
        SORTED
    GROUP BY
        S_D,
        E_D,
        PREV_END
)
SELECT
    MIN(S_D)            AS PROJECT_START,
    MAX(E_D)            AS PROJECT_END,
    MAX(E_D) - MIN(S_D) AS DURATION
FROM
    PROJECT_FLAGS
GROUP BY
    PROJECT_ID
ORDER BY
    3,
    1;
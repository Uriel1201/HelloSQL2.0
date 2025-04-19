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
) 
SELECT
    S_D,
    E_D,
    CASE
        WHEN PREV_END IS NULL THEN
            1
        WHEN PREV_END = S_D THEN
            0
        ELSE
            1
    END AS FLAG
FROM
    SORTED
GROUP BY
    S_D,
    E_D,
    PREV_END

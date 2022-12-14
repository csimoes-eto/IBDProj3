--1
SELECT
    l.vat,
    l.phone,
    l.address,
    l.name,
    p.area
FROM
    Landowner l
    INNER JOIN Property p ON l.lo_id = p.lo_id
WHERE
    l.yearofbirth BETWEEN 1992
    AND 2004
    AND p.area > 2000;

--2
SELECT
    DISTINCT l.vat,
    l.name
FROM
    Landowner l
    INNER JOIN Property p ON l.lo_id = p.lo_id
    INNER JOIN StandFire sf ON sf.pr_id = p.prop_id
    INNER JOIN Fire f ON f.f_id = sf.f_id
WHERE
    YEAR(f.dstart) = 2021;

--3
SELECT
    l.lo_id,
    l.name,
    l.vat
FROM
    Landowner l
    INNER JOIN Property p ON p.lo_id = l.lo_id
    INNER JOIN Stand st on st.prop_id = p.prop_id
    INNER JOIN Species sp on sp.spec_id = st.spec_id
WHERE
    sp.name = "Cork Oak"
    AND l.lo_id NOT IN (
        SELECT
            l2.lo_id
        FROM
            Landowner l2
            INNER JOIN Property p2 ON p2.lo_id = l2.lo_id
            INNER JOIN Stand st2 ON st2.prop_id = p2.prop_id
            INNER JOIN Species sp ON sp.spec_id = st2.spec_id
        WHERE
            sp.name = "Eucalyptus"
    );

--4
SELECT
    DISTINCT l.vat,
    l.name
FROM
    Landowner l
    LEFT OUTER JOIN Property p ON l.lo_id = p.lo_id
    LEFT OUTER JOIN StandFire sf ON p.prop_id = sf.pr_id
WHERE
    sf.f_id IS NULL;

--5
SELECT
    sf.pr_id as property_id,
    YEAR(f.dstart) as year,
    SUM(sf.area_burned) as Total_Burnt
FROM
    StandFire sf
    INNER JOIN Fire f ON f.f_id = sf.f_id
GROUP BY
    year,
    property_id;

--6
SELECT
    b.prop_id1,
    b.st_id1,
    b.prop_id2,
    b.st_id2,
    f.f_id,
    YEAR(f.dstart) AS year
FROM
    Border b
    INNER JOIN StandFire sf ON (
        sf.pr_id = b.prop_id1
        AND sf.st_id = b.st_id1
    )
    OR (
        sf.pr_id = b.prop_id2
        AND sf.st_id = b.st_id2
    )
    INNER JOIN Fire f ON f.f_id = sf.f_id
WHERE
    f.ftype = "C"
    AND YEAR(f.dstart) = 2021;

--7
SELECT
    YEAR(f.dstart) as year,
    l.name,
    SUM(sf.area_burned) as area_burnt_in_year
FROM
    StandFire sf
    INNER JOIN Fire f ON f.f_id = sf.f_id
    INNER JOIN Property p ON p.prop_id = sf.pr_id
    INNER JOIN Landowner l ON l.lo_id = p.lo_id
GROUP BY
    year,
    l.lo_id
HAVING
    area_burnt_in_year = (
        SELECT
            SUM(sf2.area_burned)
        FROM
            StandFire sf2
            INNER JOIN Fire f2 ON f2.f_id = sf2.f_id
            INNER JOIN Property p2 ON p2.prop_id = sf2.pr_id
            INNER JOIN Landowner l2 ON l2.lo_id = p2.lo_id
        WHERE
            year(f2.dstart) = year
        GROUP BY
            l2.lo_id
        ORDER BY
            area_burned DESC
        LIMIT
            1
    );

--8
SELECT
    l.lo_id,
    l.name,
    l.vat
FROM
    Stand st
    INNER JOIN Species sp ON sp.spec_id = st.spec_id
    INNER JOIN Property p ON p.prop_id = st.prop_id
    INNER JOIN Landowner l ON l.lo_id = p.lo_id
GROUP BY
    l.lo_id
HAVING
    COUNT(DISTINCT st.spec_id) = (
        SELECT
            COUNT(*)
        FROM
            Species
    );
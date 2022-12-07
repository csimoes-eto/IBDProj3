--1
SELECT
    l.vat,
    l.phone,
    l.address,
    l.name,
    p.area
FROM
    Landowner l,
    Property p
WHERE
    l.lo_id = p.lo_id
    AND l.yearofbirth BETWEEN 1992
    AND 2004
    AND p.area > 2000;

--2
SELECT
    DISTINCT l.vat,
    l.name,
    f.dstart
FROM
    Landowner l,
    Stand s,
    Fire f,
    Property p,
    StandFire fs
WHERE
    l.lo_id = p.lo_id
    AND p.prop_id = fs.pr_id
    AND fs.f_id = f.f_id
    AND f.dstart >= "2021-01-01T00:00:00.000"
    AND f.dstart <= "2021-12-31T23:59:59:999";

--3
SELECT
    l.lo_id,
    l.vat,
    l.name,
    st.prop_id,
    st.st_id,
    st.spec_id
FROM
    Landowner l,
    Property p,
    Stand st
WHERE
    st.spec_id = 1
    AND st.prop_id = p.prop_id
    AND p.lo_id = l.lo_id
    AND l.lo_id NOT IN (
        SELECT
            l.lo_id
        FROM
            Landowner l,
            Property p,
            Stand st
        WHERE
            st.spec_id = 2
            AND st.prop_id = p.prop_id
            AND p.lo_id = l.lo_id
    );

--4
SELECT
    l.lo_id,
    l.vat,
    l.name
FROM
    Landowner l,
    Property p,
    Stand s
WHERE
    l.lo_id = p.lo_id
    AND p.prop_id = s.prop_id
    AND s.st_id NOT IN (
        SELECT
            sf.st_id
        FROM
            StandFire sf
    );

--5 - ainda n sei 
-- SELECT
--     p.prop_id,
--     CAST(SUBSTRING(f.dstart, 1, 4) AS INT) AS "year",
--     SUM(sf.area_burned) AS "Tot. Area Burnt"
-- FROM
--     Property p,
--     Stand s,
--     Fire f,
--     StandFire sf
-- WHERE
--     sf.f_id = f.f_id
-- GROUP BY
--     sf.pr_id;


--6
SELECT
    DISTINCT s.st_id
FROM
    Stand s,
    Border b,
    Fire f
WHERE
    s.st_id = b.st_id1
    OR s.st_id = b.st_id2 IN (
        SELECT
            s2.st_id
        FROM
            StandFire sf,
            Fire f2,
            Stand s2
        WHERE
            f2.ftype = "C"
            AND sf.f_id = f2.f_id
            AND sf.st_id = s2.st_id
    );
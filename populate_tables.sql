-- POPULATE TABLES
INSERT INTO
    Landowner (lo_id, name, vat, phone, address, yearofbirth)
VALUES
    (
        1,
        "Amália Rodrigues",
        111111111,
        912334432,
        "Campo de Santa Clara, Lisboa",
        1920
    ),
    (
        2,
        "Júlio Santos",
        222222222,
        913339921,
        "Rua de Baixo, Lisboa",
        1965
    ),
    (
        3,
        "Renato Alexanddre",
        333333333,
        913394563,
        "Rua de Cima, Lisboa",
        1984
    ),
    (
        4,
        "Bruno Aleixo",
        444444444,
        913421273,
        "Rua de Ali, Coimbra",
        1996
    ),
    (
        5,
        "Sra. No Eucalyptus",
        555555555,
        912312254,
        "Rua da Feira, Setubal",
        2000
    ),
    (
        6,
        "Sr. No Fire",
        666666666,
        912232374,
        "Rua do Monte, Montijo",
        1987
    );

INSERT INTO
    Property (prop_id, area, lo_id)
VALUES
    (1, 2005, 4),
    (2, 1300, 2),
    (3, 2001, 1),
    (4, 1233, 3),
    (5, 3000, 1),
    (6, 1000, 5),
    (7, 500, 6);

INSERT INTO
    Species (spec_id, name)
VALUES
    (1, "Cork Oak"),
    (2, "Eucalytus");

INSERT INTO
    Stand (prop_id, st_id, spec_id, plant_year, area)
VALUES
    (1, 1, 1, 1990, 2005),
    (2, 2, 2, 2000, 1300),
    (3, 3, 1, 1800, 2001),
    (4, 4, 2, 1923, 1233),
    (5, 5, 1, 1978, 1500),
    (5, 6, 2, 1984, 1500),
    (6, 7, 1, 1954, 1000),
    (7, 8, 1, 1920, 500);

INSERT INTO
    Border (prop_id1, st_id1, prop_id2, st_id2)
VALUES
    (1, 1, 2, 2),
    (2, 2, 3, 3),
    (3, 3, 5, 5),
    (5, 5, 5, 6);

INSERT INTO
    Fire (f_id, dstart, ftype)
VALUES
    (1, "2019-08-23", "C"),
    (2, "2020-07-28", "G"),
    (3, "2020-08-21", "C"),
    (4, "2021-08-01", "G"),
    (5, "2021-09-05", "G"),
    (6, "2022-08-08", "C");

INSERT INTO
    StandFire (pr_id, st_id, f_id, perc_burned, area_burned)
VALUES
    (1, 1, 1, 35, 697),
    (2, 2, 2, 50, 1000),
    (2, 2, 3, 10, 200),
    (2, 2, 4, 100, 2000),
    (3, 3, 4, 20, 360),
    (4, 4, 5, 50, 962),
    (5, 5, 6, 100, 1500),
    (5, 6, 6, 100, 1500),
    (6, 7, 6, 50, 500);
-- IBD 2022/2023
-- this schema does not intend to cover all the constraints in the UoD
-- but rather provide a model that is workable and simple

SET foreign_key_checks = 0;
drop table if exists Landowner;
drop table if exists Property;
drop table if exists Species;
drop table if exists Stand;
drop table if exists Border;
drop table if exists Fire;
drop table if exists StandFire;
SET foreign_key_checks = 1;

-- ----------------------------------------------------------------------------
create table Landowner(
	lo_id int primary key, 
	name varchar(64),
	vat int unique,
	phone int,
	address varchar(32),
	yearofbirth int
);

create table Property(
	prop_id int primary key,
	area float,
	lo_id int,
	constraint fk_prop_lo  foreign key (lo_id) references Landowner(lo_id)
);

create table Species(
	spec_id int primary key,
	name varchar(16)
);

create table Stand(
	prop_id int,
	st_id int,
	spec_id int,
	plant_year int,
	area float,
	constraint pk_stand primary key (prop_id, st_id),
	constraint fk_stand_prop  foreign key (prop_id) references Property(prop_id),
	constraint fk_stand_spec  foreign key (spec_id) references Species(spec_id)
);

create table Border (
	prop_id1 int,
	st_id1 int,
	prop_id2 int,
	st_id2 int,
	constraint pk_border primary key (prop_id1, st_id1, prop_id2, st_id2),
	constraint fk_border1  foreign key (prop_id1, st_id1) references Stand(prop_id, st_id),
	constraint fk_border2  foreign key (prop_id2, st_id2) references Stand(prop_id, st_id)
);

create table Fire(
	f_id int primary key,
	dstart datetime,
	ftype char(1),
	constraint ck_fire CHECK (ftype IN ('C', 'G'))   -- 'C' - canopy fire 'G' - ground fire
);

create table StandFire(
	pr_id int,
	st_id int,
	f_id int, 
	perc_burned float,
	area_burned float,     -- this was not not in the UoD!
	constraint pk_StandFire primary key(pr_id, st_id, f_id),
	constraint fk_standfire1  foreign key (pr_id, st_id) references Stand(prop_id, st_id),
	constraint fk_standfire2  foreign key (f_id) references Fire(f_id)
);



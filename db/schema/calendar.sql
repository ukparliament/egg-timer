drop table if exists sitting_dates;
drop table if exists adjournment_days;
drop table if exists non_sitting_days;
drop table if exists sitting_days;
drop table if exists sessions;
drop table if exists prorogations;
drop table if exists parliament_periods;
drop table if exists houses;
drop table if exists dates;

create table parliament_periods (
	id serial,
	number int not null,
	start_on date not null,
	end_on date null,
	primary key (id)
);
create table prorogations (
	id serial,
	number int not null,
	start_on date not null,
	end_on date null,
	parliament_period_id int not null,
	constraint fk_parliament_period foreign key (parliament_period_id) references parliament_periods(id),
	primary key (id)
);
create table sessions (
	id serial,
	number int not null,
	start_on date not null,
	end_on date null,
	parliament_period_id int not null,
	constraint fk_parliament_period foreign key (parliament_period_id) references parliament_periods(id),
	primary key (id)
);
create table houses (
	id serial,
	name varchar(50) not null,
	primary key (id)
);
create table dates (
	id serial,
	date date not null,
	primary key (id)
);
create table sitting_days (
	id serial,
	session_id int not null,
	house_id int not null,
	constraint fk_session foreign key (session_id) references sessions(id),
	constraint fk_house foreign key (house_id) references houses(id),
	primary key (id)
);
create table non_sitting_days (
	id serial,
	session_id int not null,
	house_id int not null,
	date_id int not null,
	constraint fk_session foreign key (session_id) references sessions(id),
	constraint fk_house foreign key (house_id) references houses(id),
	constraint fk_date foreign key (date_id) references dates(id),
	primary key (id)
);
create table adjournment_days (
	id serial,
	session_id int not null,
	house_id int not null,
	date_id int not null,
	constraint fk_session foreign key (session_id) references sessions(id),
	constraint fk_house foreign key (house_id) references houses(id),
	constraint fk_date foreign key (date_id) references dates(id),
	primary key (id)
);
create table sitting_dates (
	id serial,
	sitting_day_id int not null,
	date_id int not null,
	constraint fk_sitting_day foreign key (sitting_day_id) references sitting_days(id),
	constraint fk_date foreign key (date_id) references dates(id),
	primary key (id)
);
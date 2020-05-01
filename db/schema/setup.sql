drop table if exists dissolution_days;
drop table if exists prorogation_days;
drop table if exists sitting_dates;
drop table if exists adjournment_days;
drop table if exists sitting_days;
drop table if exists sessions;
drop table if exists prorogation_periods;
drop table if exists parliament_periods;
drop table if exists dissolution_periods;
drop table if exists houses;
drop table if exists calendar_dates;

create table parliament_periods (
	id serial,
	number int not null,
	start_on date not null,
	end_on date null,
	primary key (id)
);
create table dissolution_periods (
	id serial,
	number int not null,
	start_on date not null,
	end_on date null,
	primary key (id)
);
create table prorogation_periods (
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
create table calendar_dates (
	id serial,
	date date not null,
	primary key (id)
);
create table sitting_days (
	id serial,
	google_event_id varchar(255) not null,
	session_id int not null,
	house_id int not null,
	constraint fk_session foreign key (session_id) references sessions(id),
	constraint fk_house foreign key (house_id) references houses(id),
	primary key (id)
);
create table adjournment_days (
	id serial,
	google_event_id varchar(255) not null,
	session_id int not null,
	house_id int not null,
	calendar_date_id int not null,
	constraint fk_session foreign key (session_id) references sessions(id),
	constraint fk_house foreign key (house_id) references houses(id),
	constraint fk_calendar_date foreign key (calendar_date_id) references calendar_dates(id),
	primary key (id)
);
create table sitting_dates (
	id serial,
	google_event_id varchar(255) not null,
	sitting_day_id int not null,
	calendar_date_id int not null,
	constraint fk_sitting_day foreign key (sitting_day_id) references sitting_days(id),
	constraint fk_calendar_date foreign key (calendar_date_id) references calendar_dates(id),
	primary key (id)
);
create table prorogation_days (
	id serial,
	google_event_id varchar(255) not null,
	dissolution_period_id int not null,
	calendar_date_id int not null,
	constraint fk_dissolution_period foreign key (dissolution_period_id) references dissolution_periods(id),
	constraint fk_calendar_date foreign key (calendar_date_id) references calendar_dates(id),
	primary key (id)
);
create table dissolution_days (
	id serial,
	google_event_id varchar(255) not null,
	prorogation_period_id int not null,
	calendar_date_id int not null,
	constraint fk_prorogation_period foreign key (prorogation_period_id) references prorogation_periods(id),
	constraint fk_calendar_date foreign key (calendar_date_id) references calendar_dates(id),
	primary key (id)
);

drop table if exists sync_tokens;
create table sync_tokens (
	id serial,
	google_calendar_id varchar(255) not null,
	token varchar(255) not null,
	primary key (id)
);
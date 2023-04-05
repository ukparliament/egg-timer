drop table if exists recess_dates;
drop table if exists dissolution_days;
drop table if exists prorogation_days;
drop table if exists adjournment_days;
drop table if exists virtual_sitting_days;
drop table if exists sitting_days;
drop table if exists houses;
drop table if exists sessions;
drop table if exists prorogation_periods;
drop table if exists dissolution_periods;
drop table if exists parliament_periods;
drop table if exists sync_tokens;
drop table if exists procedures;

create sequence parliament_periods_id_seq as integer;
create table parliament_periods (
	id int not null,
	number int not null,
	start_date date not null,
	end_date date null,
	primary key (id)
);
alter sequence parliament_periods_id_seq owned by parliament_periods.id;
alter table parliament_periods alter column id set default nextval('parliament_periods_id_seq');

create sequence dissolution_periods_id_seq;
create table dissolution_periods (
	id int not null,
	number int not null,
	start_date date not null,
	end_date date null,
	primary key (id)
);
alter sequence dissolution_periods_id_seq owned by dissolution_periods.id;
alter table dissolution_periods alter column id set default nextval('dissolution_periods_id_seq');

create sequence prorogation_periods_id_seq;
create table prorogation_periods (
	id int not null,
	number int not null,
	start_date date not null,
	end_date date null,
	parliament_period_id int not null,
	constraint fk_parliament_period foreign key (parliament_period_id) references parliament_periods(id),
	primary key (id)
);
alter sequence prorogation_periods_id_seq owned by prorogation_periods.id;
alter table prorogation_periods alter column id set default nextval('prorogation_periods_id_seq');

create sequence sessions_id_seq;
create table sessions (
	id int not null,
	number int not null,
	start_date date not null,
	end_date date null,
	citation varchar(255) not null,
	parliament_period_id int not null,
	constraint fk_parliament_period foreign key (parliament_period_id) references parliament_periods(id),
	primary key (id)
);
alter sequence sessions_id_seq owned by sessions.id;
alter table sessions alter column id set default nextval('sessions_id_seq');

create sequence houses_id_seq;
create table houses (
	id int not null,
	name varchar(50) not null,
	primary key (id)
);
alter sequence houses_id_seq owned by houses.id;
alter table houses alter column id set default nextval('houses_id_seq');

create sequence sitting_days_id_seq;
create table sitting_days (
	id int not null,
	start_date date not null,
	end_date date not null,
	google_event_id varchar(255) not null,
	session_id int not null,
	house_id int not null,
	constraint fk_session foreign key (session_id) references sessions(id),
	constraint fk_house foreign key (house_id) references houses(id),
	primary key (id)
);
alter sequence sitting_days_id_seq owned by sitting_days.id;
alter table sitting_days alter column id set default nextval('sitting_days_id_seq');

create sequence virtual_sitting_days_id_seq;
create table virtual_sitting_days (
	id int not null,
	start_date date not null,
	end_date date not null,
	google_event_id varchar(255) not null,
	session_id int not null,
	house_id int not null,
	constraint fk_session foreign key (session_id) references sessions(id),
	constraint fk_house foreign key (house_id) references houses(id),
	primary key (id)
);
alter sequence virtual_sitting_days_id_seq owned by virtual_sitting_days.id;
alter table virtual_sitting_days alter column id set default nextval('virtual_sitting_days_id_seq');

create sequence adjournment_days_id_seq;
create table adjournment_days (
	id int not null,
	date date not null,
	google_event_id varchar(255) not null,
	session_id int not null,
	house_id int not null,
	constraint fk_session foreign key (session_id) references sessions(id),
	constraint fk_house foreign key (house_id) references houses(id),
	primary key (id)
);
alter sequence adjournment_days_id_seq owned by adjournment_days.id;
alter table adjournment_days alter column id set default nextval('adjournment_days_id_seq');

create sequence prorogation_days_id_seq;
create table prorogation_days (
	id int not null,
	date date not null,
	google_event_id varchar(255),
	prorogation_period_id int not null,
	constraint fk_prorogation_period foreign key (prorogation_period_id) references prorogation_periods(id),
	primary key (id)
);
alter sequence prorogation_days_id_seq owned by prorogation_days.id;
alter table prorogation_days alter column id set default nextval('prorogation_days_id_seq');

create sequence dissolution_days_id_seq;
create table dissolution_days (
	id int not null,
	date date not null,
	google_event_id varchar(255),
	dissolution_period_id int not null,
	constraint fk_dissolution_period foreign key (dissolution_period_id) references dissolution_periods(id),
	primary key (id)
);
alter sequence dissolution_days_id_seq owned by dissolution_days.id;
alter table dissolution_days alter column id set default nextval('dissolution_days_id_seq');

create sequence sync_tokens_id_seq;
create table sync_tokens (
	id int not null,
	google_calendar_id varchar(255) not null,
	token varchar(255) not null,
	primary key (id)
);
alter sequence sync_tokens_id_seq owned by sync_tokens.id;
alter table sync_tokens alter column id set default nextval('sync_tokens_id_seq');

create sequence procedures_id_seq;
create table procedures (
	id int not null,
	display_order int not null,
	name varchar(255) not null,
	active boolean not null,
	typical_day_count int,
	has_day_count_caveats boolean,
	primary key (id)
);
alter sequence procedures_id_seq owned by procedures.id;
alter table procedures alter column id set default nextval('procedures_id_seq');

create sequence recess_dates_id_seq;
create table recess_dates (
	id int not null,
	description varchar(255) not null,
	start_date date not null,
	end_date date not null,
	google_event_id varchar(255) not null,
	house_id int not null,
	constraint fk_house foreign key (house_id) references houses(id),
	primary key (id)
);
alter sequence recess_dates_id_seq owned by recess_dates.id;
alter table recess_dates alter column id set default nextval('recess_dates_id_seq');
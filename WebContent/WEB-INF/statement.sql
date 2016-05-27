drop table jMember;

create table jMember(
	id varchar2(50) primary key,
	pwd varchar2(50) not null,
	name varchar2(50) not null,
	email varchar2(50) unique,
	auth number not null
);

select * from jMember;

drop table jBBS;

create table jBBS(
	seq number(8) primary key,
	id varchar2(50) not null,
	title varchar2(200) not null,
	content varchar2(4000),
	wdate date not null,
	ref number(8) not null,
	step number(8) not null,
	depth number(8) not null,
	parent number(8) not null,
	readcount number(8) not null,
	del number(1) not null
);

create sequence seq_jbbs
start with 1 increment by 1;

alter table jBBS
add constraint fk_jbbs_id foreign key(id)
references jMember(id);

select * from jBBS;

create table jmycalendar(
	seq number(8) primary key,
	id varchar2(50) not null,
	title varchar2(200)not null,
	content varchar2(4000) not null,
	rdate varchar2(12) not null,
	wdate date not null
);

create sequence seq_jmycalendar
start with 1 increment by 1;

alter table jmycalendar
add constraint fk_jmycalendar_id foreign key(id)
references jMember(id);

select * from jmycalendar;

delete from jmycalendar where id = 'first';

insert into jmycalendar(seq, id, title, content, rdate, wdate) 
values(seq_jmycalendar.nextval, 'first', 'asdf', 'asdfwer', '20160101', sysdate);
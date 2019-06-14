drop database smc;
create database smc;

use smc;

create table patient (
	cpf varchar(11) primary key not null,
	name varchar(150) not null,
	email varchar(100) not null,
	genre varchar(10) not null,
	birthDate date not null,
	height float not null,
	bloodType varchar(5) not null,
	telephone varchar(12));
	
create table medic (
	crm varchar(7) primary key not null,
	name varchar(150) not null);
	
create table manager (
	id int primary key not null,
	accessLevel int not null);
	
create table clinic (
	cnpj varchar(12) primary key not null,
	name varchar(150) not null,
	address varchar(150) not null);
	
create table user (
	userName varchar(150) primary key not null,
	userPassword varchar(150) not null);
	
create table patientUser (
	patient_fk varchar(11) not null,
	user_fk varchar(150) not null);
	
create table medicUser (
	medic_fk varchar(7) not null,
	user_fk varchar(150) not null);
	
create table managerUser (
	manager_fk int not null,
	user_fk varchar(150) not null);
	
create table speciality (
	name varchar(100) primary key not null);
	
create table medicSpeciality (
	medic_fk varchar(7) not null,
	speciality_fk varchar(100) not null);
	
create table medicClinic (
	medic_fk varchar(7) not null,
	clinic_fk varchar(12) not null);
	
create table account (
	id bigint primary key not null auto_increment,
	patient_fk varchar(11) not null);
	
create table specialityKeys (
	id bigint primary key not null auto_increment,	
	account_fk bigint not null,
	medic_fk varchar(7) not null,
	speciality_fk varchar(100) not null,
	creationDate date not null,	
	useDate date,
	used boolean not null);
	
create table medicalRecord (
	id bigint primary key not null auto_increment,
	patient_fk varchar(11) not null);
	
create table consult (
	id bigint primary key not null auto_increment,
	patient_fk varchar(11) not null,
	medic_fk varchar(7) not null,
	specialityKeys_fk bigint not null,
	creationDate date not null,
	consultDate date not null,
	consulted boolean not null);
	
create table medicSchedule (
	medic_fk varchar(11) not null,
	clinic_fk varchar(12) not null,
	monday varchar(20),
	tuesday varchar(20),
	wednesday varchar(20),
	thursday varchar(20),
	friday varchar(20),
	saturday varchar(20),
	sunday varchar(20));
	
create table medicAgenda (
	medic_fk varchar(11) not null,
	consult_fk bigint not null);
	
alter table patientUser add foreign key (patient_fk) references patient (cpf);
alter table patientUser add foreign key (user_fk) references user (userName);

alter table medicUser add foreign key (medic_fk) references medic (crm);
alter table medicUser add foreign key (user_fk) references user (userName);

alter table managerUser add foreign key (manager_fk) references manager (id);
alter table managerUser add foreign key (user_fk) references user (userName);

alter table medicSpeciality add foreign key (medic_fk) references medic (crm);
alter table medicSpeciality add foreign key (speciality_fk) references speciality (name);

alter table medicClinic add foreign key (medic_fk) references medic (crm);
alter table medicClinic add foreign key (clinic_fk) references clinic (cnpj);

alter table account add foreign key (patient_fk) references patient (cpf);

alter table specialityKeys add foreign key (account_fk) references account (id);
alter table specialityKeys add foreign key (medic_fk) references medic (crm);
alter table specialityKeys add foreign key (speciality_fk) references speciality (name);

alter table medicalRecord add foreign key (patient_fk) references patient (cpf);

alter table consult add foreign key (patient_fk) references patient (cpf);
alter table consult add foreign key (medic_fk) references medic (crm);
alter table consult add foreign key (specialityKeys_fk) references specialityKeys (id);

alter table medicSchedule add foreign key (medic_fk) references medic (crm);
alter table medicSchedule add foreign key (clinic_fk) references clinic (cnpj);

alter table medicAgenda add foreign key (medic_fk) references medic (crm);
alter table medicAgenda add foreign key (consult_fk) references consult (id);
create sequence Expeditori_idExpeditor_Seq
    start with 1
    maxvalue 99999
    nocache nocycle;

create table Expeditori
(
    id_expeditor int
        constraint Expeditori_id_expeditor_pk primary key,
    nume         varchar(30)
        constraint Expeditori_nume_nn not null,
    prenume      varchar(30)
        constraint Expeditori_prenume_nn not null,
    nr_telefon   char(10)
);
/

create sequence Depozite_idDepozit_Seq
    start with 1
    maxvalue 99999
    nocache nocycle;

create table Depozite
(
    id_depozit     int
        constraint Depozite_id_depozit_pk primary key,
    denumire       varchar(30)
        constraint Depozite_denumire_nn not null,
    adresa_depozit varchar(50)
        constraint Depozite_adresa_depozit_nn not null
);
/

create sequence Destinatari_idDestinatar_Seq
    start with 1
    maxvalue 99999
    nocache nocycle;

create table Destinatari
(
    id_destinatar int
        constraint Destinatari_id_destinatar_pk primary key,
    nume          varchar(30)
        constraint Destinatari_nume_nn not null,
    prenume       varchar(30)
        constraint Destinatari_prenume_nn not null,
    nr_telefon    char(10)
        constraint Destinatari_nr_telefon_nn not null,
    adresa        varchar(30)
        constraint Destinatari_adresa_nn not null

);
/

create sequence Facturi_idFactura_Seq
    start with 1
    maxvalue 99999
    nocache nocycle;

create table Facturi
(
    id_factura   int
        constraint Facturi_id_factura_pk primary key,
    id_expeditor int
        constraint Facturi_id_expeditori_fk references EXPEDITORI (id_expeditor) on delete set null,
    suma         number(5, 2)
        constraint Facturi_suma_nn not null
        constraint Facturi_suma_ck check (suma > 0)

);
/

create table Masini
(
    nr_inmatriculare varchar(10)
        constraint Masini_nr_inmatriculare_pk primary key,
    marca            varchar(20),
    model_masini     varchar(30),
    an_fabricatie    char(4),
    tip_combustibil  varchar(10)
        constraint Masini_tip_combustibil_nn not null

);
/
create sequence Curieri_idCurier_Seq
    start with 1
    maxvalue 99999
    nocache nocycle;

create table Curieri
(
    id_curier      int
        constraint Curieri_id_curier_pk primary key,
    nume           varchar(30)
        constraint Curieri_nume_nn not null,
    prenume        varchar(30)
        constraint Curieri_prenume_nn not null,
    nr_telefon     char(10)
        constraint Curieri_nr_telefon_nn not null,
    data_angajarii date default trunc(sysdate)
        constraint Curieri_data_angajarii_nn not null,
    salariu        number(7, 2)
        constraint Curieri_salariu_nn not null
        constraint Curieri_salariu_ck check ( salariu > 2999 )
);
/

create table Colete
(
    AWB           char(11)
        constraint Colete_AWB_pk primary key,
    id_factura    int
        constraint Colete_id_factura_fk references FACTURI (id_factura) on delete cascade,
    id_destinatar int
        constraint Colete_id_destinatar_fk references DESTINATARI (id_destinatar) on delete cascade,
    id_curieri    int
        constraint Colete_id_curier_fk references CURIERI (id_curier) on delete set null,
    denumire      varchar(30)
        constraint Colete_denumire_nn not null,
    luginme       number(5, 2)
        constraint Colete_lungime_nn not null
        constraint Colete_min_lungime_ck check ( luginme > 0 ),
    constraint Colete_max_lungime_ck check ( luginme < 60 ),
    latime        number(5, 2)
        constraint Colete_latime_nn not null
        constraint Colete_min_latime_ck check ( latime > 0 ),
    constraint Colete_max_latime_ck check ( latime < 50 ),
    inatlime      number(5, 2)
        constraint Colete_inaltime_nn not null
        constraint Colete_min_inaltime_ck check ( inatlime > 0 ),
    constraint Colete_max_inaltime_ck check ( inatlime < 30 ),
    greutate      number(5, 2)
        constraint Colete_greutate_nn not null
        constraint Colete_min_greutate_ck check ( greutate > 0 ),
    constraint Colete_max_greutate_ck check ( greutate < 30 )
);
/

create table Evidenta_masini
(
    id_evidenta_masini int
        constraint Evidenta_masini_id_evidenta_pk primary key,
    id_curier          int
        constraint Evidenta_masini_id_curier_fk references CURIERI (id_curier) on delete set null,
    nr_inmatriculare   varchar(10)
        constraint Evidenta_masini_numar_fk references MASINI (nr_inmatriculare) on delete cascade,
    data_preluare      date default trunc(sysdate)
        constraint Evidenta_masini_d_preluare_nn not null,
    ora_preluare       varchar(5)
        constraint Evidenta_masini_o_preluare_nn not null,
    data_predare       date default null,
    ora_predare        varchar(5)
);
/
create table Evidenta_colete
(
    id_evidenta_colet int
        constraint Evidenta_colete_id_evidenta_pk primary key,
    AWB               char(11)
        constraint Evidenta_colete_AWB_fk references COLETE (AWB) on delete cascade,
    id_depozit        int
        constraint Evidenta_colete_id_depozit_fk references DEPOZITE (id_depozit) on delete set null,
    data_parasire     date default trunc(sysdate)
        constraint Evidenta_colete_data_nn not null,
    ora_parasire      varchar(5)
        constraint Evidenta_colete_ora_nn not null
);
/

insert into Expeditori (id_expeditor, nume, prenume, nr_telefon)
values (Expeditori_idExpeditor_Seq.nextval, 'Becul', 'Costel', '0744517590');

insert into Expeditori (id_expeditor, nume, prenume, nr_telefon)
values (Expeditori_idExpeditor_Seq.nextval, 'Popescu', 'Andrei George', '0771335308');

insert into Expeditori (id_expeditor, nume, prenume, nr_telefon)
values (Expeditori_idExpeditor_Seq.nextval, 'Ionescu', 'Mihai-Leonard', '0745328941');

insert into Expeditori (id_expeditor, nume, prenume, nr_telefon)
values (Expeditori_idExpeditor_Seq.nextval, 'Besel', 'Marin-Adrian', '0741273748');

insert into Expeditori (id_expeditor, nume, prenume, nr_telefon)
values (Expeditori_idExpeditor_Seq.nextval, 'Zamfir', 'Rica', '0748128156');

insert into Expeditori (id_expeditor, nume, prenume, nr_telefon)
values (Expeditori_idExpeditor_Seq.nextval, 'Sumudica', 'Marius', '0755651056');

select *
from Masini;

insert into Masini(nr_inmatriculare, marca, model_masini, an_fabricatie, tip_combustibil)
values ('AG 74 PSW', 'Volkswagen', 'Caddy', '2010', 'Benzina');

insert into Masini(nr_inmatriculare, marca, model_masini, an_fabricatie, tip_combustibil)
values ('B 143 PSW', 'Mercedes', 'Vito', '2006', 'Diesel');

insert into Masini(nr_inmatriculare, marca, model_masini, an_fabricatie, tip_combustibil)
values ('AG 02 PSW', 'Dacia', 'Dokker', '2014', 'Benzina');

insert into Masini(nr_inmatriculare, marca, model_masini, an_fabricatie, tip_combustibil)
values ('DB 08 PSW', 'Volkswagen', 'Caddy', '2012', 'Benzina');

insert into Masini(nr_inmatriculare, marca, model_masini, an_fabricatie, tip_combustibil)
values ('DB 04 PSW', 'Ford', 'Transit', '2011', 'Diesel');

insert into Masini(nr_inmatriculare, marca, model_masini, an_fabricatie, tip_combustibil)
values ('CT 98 PSW', 'Volkswagen', 'Transporter', '2010', 'Diesel');

insert into Masini(nr_inmatriculare, marca, model_masini, an_fabricatie, tip_combustibil)
values ('CT 65 PSW', 'Dacia', 'Dokker', '2007', 'GPL');


insert into Depozite(id_depozit, denumire, adresa_depozit)
values (Depozite_idDepozit_Seq.nextval, 'Posta Romana Wish Bucuresti', 'Str.Academiei 14, Bucuresti');

insert into Depozite(id_depozit, denumire, adresa_depozit)
values (Depozite_idDepozit_Seq.nextval, 'Posta Romana Wish Arges', 'Str.Calea Magurii, Campulung Muscel');

insert into Depozite(id_depozit, denumire, adresa_depozit)
values (Depozite_idDepozit_Seq.nextval, 'Posta Romana Wish Dambovita', 'Str.Crangului 26, Targoviste');

insert into Depozite(id_depozit, denumire, adresa_depozit)
values (Depozite_idDepozit_Seq.nextval, 'Posta Romana Wish Constanta', 'Str.Ion Ratiu 192, Constanta');



insert into Destinatari(id_destinatar, nume, prenume, nr_telefon, adresa)
values (Destinatari_idDestinatar_Seq.nextval, 'Love', 'Petrica', '0748256931', 'Strada Gruiului 10, Campulung');

insert into Destinatari(id_destinatar, nume, prenume, nr_telefon, adresa)
values (Destinatari_idDestinatar_Seq.nextval, 'Popa', 'Cristian', '0745212986', 'Aleea Valea Florilor 4, Bucuresti');

insert into Destinatari(id_destinatar, nume, prenume, nr_telefon, adresa)
values (Destinatari_idDestinatar_Seq.nextval, 'Achimescu', 'Valentin-Ionut', '0745561153',
        'Strada Crinului, Targoviste');

insert into Destinatari(id_destinatar, nume, prenume, nr_telefon, adresa)
values (Destinatari_idDestinatar_Seq.nextval, 'Micle', 'Veronica', '0784120762', 'Aleea Godeanu 1, Ovidiu');

insert into Destinatari(id_destinatar, nume, prenume, nr_telefon, adresa)
values (Destinatari_idDestinatar_Seq.nextval, 'Trufica', 'Iosif', '0777651946',
        'Str.General Grigore Grecescu 2, Magurele');

insert into Destinatari(id_destinatar, nume, prenume, nr_telefon, adresa)
values (Destinatari_idDestinatar_Seq.nextval, 'Lastun', 'Otilia-Bogdana', '0756971600', 'Str.Iancu Bacalu 27, Pitesti');

insert into Facturi(id_factura, id_expeditor, suma)
values (1, 1, 37.59);

insert into Facturi(id_factura, id_expeditor, suma)
values (2, 2, 42.46);

insert into Facturi(id_factura, id_expeditor, suma)
values (3, 3, 37.59);

insert into Facturi(id_factura, id_expeditor, suma)
values (4, 4, 58.70);

insert into Facturi(id_factura, id_expeditor, suma)
values (5, 4, 25.13);

insert into Facturi(id_factura, id_expeditor, suma)
values (6, 6, 35.09);


insert into Curieri(id_curier, nume, prenume, nr_telefon, data_angajarii, salariu)
values (Curieri_idCurier_Seq.nextval, 'Poenaru', 'Radu', '0789948132', TO_DATE('2019-06-27', 'YYYY-MM_DD'), 3900);

insert into Curieri(id_curier, nume, prenume, nr_telefon, data_angajarii, salariu)
values (Curieri_idCurier_Seq.nextval, 'Craciun', 'Landon', '0744468548', TO_DATE('2017-02-15', 'YYYY-MM_DD'), 4250);

insert into Curieri(id_curier, nume, prenume, nr_telefon, data_angajarii, salariu)
values (Curieri_idCurier_Seq.nextval, 'Jordan', 'Mihai', '0723323516', TO_DATE('2023-01-06', 'YYYY-MM_DD'), 3000);

insert into Curieri(id_curier, nume, prenume, nr_telefon, data_angajarii, salariu)
values (Curieri_idCurier_Seq.nextval, 'Cotolan', 'Sever', '0784526179', TO_DATE('2020-03-21', 'YYYY-MM_DD'), 3750);

insert into Curieri(id_curier, nume, prenume, nr_telefon, data_angajarii, salariu)
values (Curieri_idCurier_Seq.nextval, 'Ulmeanu', 'Cristian', '0742984333', TO_DATE('2021-01-17', 'YYYY-MM_DD'), 3170.50);

insert into Curieri(id_curier, nume, prenume, nr_telefon, data_angajarii, salariu)
values (Curieri_idCurier_Seq.nextval, 'Duta', 'Andrei-Daniel', '0745565354', TO_DATE('2018-01-08', 'YYYY-MM_DD'), 4000);

insert into Curieri(id_curier, nume, prenume, nr_telefon, data_angajarii, salariu)
values (Curieri_idCurier_Seq.nextval, 'Nedelcu', 'Marius', '0755713682', TO_DATE('2020-03-03', 'YYYY-MM_DD'), 3500);


insert into Colete(AWB, id_factura, id_destinatar, id_curieri, denumire, luginme, latime, inatlime, greutate)
values ('96320835270', 7, 2, 1, 'Masina de jucarie', 20, 10, 10, 0.50);

insert into Colete(AWB, id_factura, id_destinatar, id_curieri, denumire, luginme, latime, inatlime, greutate)
values ('35803967779', 8, 3, 5, 'Boxe audio', 48.90, 35.60, 20, 5.13);

insert into Colete(AWB, id_factura, id_destinatar, id_curieri, denumire, luginme, latime, inatlime, greutate)
values ('97787599869', 9, 5, 3, 'Consola PS4', 27.2, 25.8, 14.5, 3.55);

insert into Colete(AWB, id_factura, id_destinatar, id_curieri, denumire, luginme, latime, inatlime, greutate)
values ('37350064416', 10, 4, 2, 'Borcane de miere', 47.8, 25.5, 11.5, 10);

insert into Colete(AWB, id_factura, id_destinatar, id_curieri, denumire, luginme, latime, inatlime, greutate)
values ('12500286284', 11, 1, 1, 'Periferice gaming', 28, 10.6, 9, 1.4);

insert into Colete(AWB, id_factura, id_destinatar, id_curieri, denumire, luginme, latime, inatlime, greutate)
values ('20784117836', 12, 4, 4, 'Numere de inmatriculare', 30, 5, 5, 0.6);


insert into Evidenta_masini(id_evidenta_masini, id_curier, nr_inmatriculare, data_preluare, ora_preluare, data_predare,
                            ora_predare)
values (1, 1, 'AG 74 PSW', TO_DATE('2022-12-20', 'YYYY-MM-DD'), '12:30', TO_DATE('2022-12-22', 'YYYY-MM-DD'), '18:00');

insert into Evidenta_masini(id_evidenta_masini, id_curier, nr_inmatriculare, data_preluare, ora_preluare, data_predare,
                            ora_predare)
values (2, 2, 'B 143 PSW', TO_DATE('2022-06-14', 'YYYY-MM-DD'), '10:20', TO_DATE('2022-06-15', 'YYYY-MM-DD'), '21:15');

insert into Evidenta_masini(id_evidenta_masini, id_curier, nr_inmatriculare, data_preluare, ora_preluare, data_predare,
                            ora_predare)
values (3, 3, 'DB 04 PSW', TO_DATE('2022-09-03', 'YYYY-MM-DD'), '08:00', TO_DATE('2022-09-06', 'YYYY-MM-DD'), '12:00');

insert into Evidenta_masini(id_evidenta_masini, id_curier, nr_inmatriculare, data_preluare, ora_preluare, data_predare,
                            ora_predare)
values (4, 4, 'CT 98 PSW', TO_DATE('2021-11-24', 'YYYY-MM-DD'), '14:30', TO_DATE('2021-11-26', 'YYYY-MM-DD'), '11:50');

insert into Evidenta_masini(id_evidenta_masini, id_curier, nr_inmatriculare, data_preluare, ora_preluare, data_predare,
                            ora_predare)
values (5, 5, 'B 143 PSW', TO_DATE('2022-10-14', 'YYYY-MM-DD'), '12:15', TO_DATE('2022-10-16', 'YYYY-MM-DD'), '12:35');

insert into Evidenta_masini(id_evidenta_masini, id_curier, nr_inmatriculare, data_preluare, ora_preluare, data_predare,
                            ora_predare)
values (6, 1, 'AG 02 PSW', TO_DATE('2023-01-12', 'YYYY-MM-DD'), '19:00', null, null);


insert into Evidenta_colete(id_evidenta_colet, AWB, id_depozit, data_parasire, ora_parasire)
values (1, '96320835270', 2, TO_DATE('2022-12-20', 'YYYY-MM-DD'), '13:00');

insert into Evidenta_colete(id_evidenta_colet, AWB, id_depozit, data_parasire, ora_parasire)
values (2, '35803967779', 1, TO_DATE('2022-10-14', 'YYYY-MM-DD'), '11:00');

insert into Evidenta_colete(id_evidenta_colet, AWB, id_depozit, data_parasire, ora_parasire)
values (3, '97787599869', 2, TO_DATE('2022-09-03', 'YYYY-MM-DD'), '08:20');

insert into Evidenta_colete(id_evidenta_colet, AWB, id_depozit, data_parasire, ora_parasire)
values (4, '37350064416', 1, TO_DATE('2022-06-14', 'YYYY-MM-DD'), '10:55');

insert into Evidenta_colete(id_evidenta_colet, AWB, id_depozit, data_parasire, ora_parasire)
values (5, '12500286284', 1, TO_DATE('2023-01-12', 'YYYY-MM-DD'), '19:30');

insert into Evidenta_colete(id_evidenta_colet, AWB, id_depozit, data_parasire, ora_parasire)
values (6, '20784117836', 4, TO_DATE('2021-11-24', 'YYYY-MM-DD'), '15:00');

insert into Evidenta_colete(id_evidenta_colet, AWB, id_depozit, data_parasire, ora_parasire)
values (7, '37350064416', 4, TO_DATE('2021-06-15', 'YYYY-MM-DD'), '10:00');


create or replace view Livrari_efectuate as
select cr.nume, cr.prenume, count(col.AWB) nr_colete
from Curieri cr inner join Colete col on cr.id_curier = col.id_curieri
group by cr.nume, cr.prenume;

create or replace view Colete_primite as
select d.nume, d.prenume
from Destinatari d inner join Colete col on d.id_destinatar = col.id_destinatar;


-----------------------------------------
--Codul pentru stergerea tabelelor--

drop sequence Depozite_idDepozit_Seq;
alter table Depozite
    drop constraint Depozite_denumire_nn
    drop constraint Depozite_adresa_depozit_nn;
drop table Depozite;

drop sequence Expeditori_idExpeditor_Seq;
alter table Expeditori
    drop constraint Expeditori_nume_nn
    drop constraint Expeditori_prenume_nn;
drop table Expeditori;

drop sequence Destinatari_idDestinatar_Seq;
alter table Destinatari
    drop constraint Destinatari_nume_nn
    drop constraint Destinatari_prenume_nn
    drop constraint Destinatari_nr_telefon_nn
    drop constraint Destinatari_adresa_nn;
drop table Destinatari;

drop sequence FACTURI_IDFACTURA_SEQ;
alter table Facturi
    drop constraint Facturi_id_factura_pk
    drop constraint Facturi_suma_nn;
    drop constraint Facturi_suma_ck;
drop table Facturi;

alter table Masini
    drop constraint Masini_tip_combustibil_nn;
drop table Masini;

drop sequence Curieri_idCurier_Seq;
alter table Curieri
    drop constraint Curieri_nume_nn
    drop constraint Curieri_prenume_nn
    drop constraint Curieri_nr_telefon_nn
    drop constraint Curieri_data_angajarii_nn
    drop constraint Curieri_salariu_nn
    drop constraint Curieri_salariu_ck;
drop table Curieri;

alter table Colete
    drop constraint Colete_id_factura_fk
    drop constraint Colete_id_destinatar_fk
    drop constraint Colete_id_curier_fk
    drop constraint Colete_denumire_nn
    drop constraint Colete_lungime_nn
    drop constraint Colete_min_lungime_ck
    drop constraint Colete_max_lungime_ck
    drop constraint Colete_latime_nn
    drop constraint Colete_min_latime_ck
    drop constraint Colete_max_latime_ck
    drop constraint Colete_inaltime_nn
    drop constraint Colete_min_inaltime_ck
    drop constraint Colete_max_inaltime_ck
    drop constraint Colete_greutate_nn
    drop constraint Colete_min_greutate_ck
    drop constraint Colete_max_greutate_ck;

drop table Colete;

alter table Evidenta_masini
    drop constraint Evidenta_masini_id_curier_fk
    drop constraint Evidenta_masini_numar_fk
    drop constraint Evidenta_masini_d_preluare_nn
    drop constraint Evidenta_masini_o_preluare_nn;
drop table Evidenta_masini;

alter table Evidenta_colete
    drop constraint Evidenta_colete_id_depozit_fk
    drop constraint Evidenta_colete_id_depozit_fk;
drop table Evidenta_colete












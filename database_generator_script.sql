create table circuite
(
    circuit_id     varchar(50) primary key,
    lungime        float       not null,
    an_constructie year        null,
    tip_circuit    varchar(20) not null,
    check (lower(tip_circuit) = 'normal' or lower(tip_circuit) = 'stradal'),
    check (lungime > 0),
    check (an_constructie > 0)
);

create table furnizori_motoare
(
    furnizor_id       varchar(40) primary key,
    cai_putere        int         not null,
    nr_cilindri       int default 6,
    brand_combustibil varchar(40) not null,
    check (cai_putere > 0),
    check (nr_cilindri > 0)
);

create table grands_prix
(
    grand_prix_id varchar(50) primary key,
    circuit_id    varchar(50) null,
    data_cursa    date        not null,
    nr_ture       int         not null,
    check (nr_ture > 0),
    constraint grands_prix_circuit_id_fk foreign key (circuit_id) references circuite (circuit_id) on delete set null
);

create table echipe
(
    echipe_id   varchar(40) primary key,
    furnizor_id varchar(40) null,
    culoare     varchar(30) null,
    sediu_tara  varchar(20) null,
    sediu_oras  varchar(20) null,
    buget_anual float default 0,
    check (buget_anual >= 0),
    constraint echipe_furnizor_id_fk foreign key (furnizor_id) references furnizori_motoare (furnizor_id) on delete set null
);

create table sponsori
(
    sponsor_id        varchar(40) primary key,
    echipe_id         varchar(40) not null,
    suma_sponsorizare float       not null,
    check (suma_sponsorizare >= 0),
    constraint sponsori_echipe_id_fk foreign key (echipe_id) references echipe (echipe_id) on delete cascade
);

create table angajati_echipe
(
    angajat_id     int primary key auto_increment,
    echipa_id      varchar(40) not null,
    nume           varchar(20) not null,
    prenume        varchar(20) not null,
    post           varchar(20) not null,
    data_angajarii date        not null,
    check (data_angajarii <= sysdate()),
    constraint angajati_echipe_echipe_id_fk foreign key (echipa_id) references echipe (echipe_id) on delete cascade
);

create table piloti
(
    pilot_id      int primary key,
    echipa_id     varchar(40) not null,
    nume          varchar(20) not null,
    prenume       varchar(20) not null,
    varsta        int         null,
    nationalitate varchar(20) null,
    salariu       float       null,
    numar_titluri int default 0,
    check (varsta >= 18),
    check (salariu >= 0),
    check (numar_titluri >= 0),
    constraint piloti_echipe_id_fk foreign key (echipa_id) references echipe (echipe_id) on delete cascade
);

create table echipe_participante
(
    grand_prix_id varchar(50),
    echipa_id     varchar(40),
    primary key (grand_prix_id, echipa_id),
    constraint echipe_participante_echipe_id_fk foreign key (echipa_id) references echipe (echipe_id) on delete cascade,
    constraint echipe_participante_grandprix_id_fk foreign key (grand_prix_id) references grands_prix (grand_prix_id) on delete cascade
);

insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Autodromo Enzo e Dino Ferrari', 4.909, 1980, 'normal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Autódromo Internacional do Algarve', 4.653, 2020, 'stradal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Autodromo Nazionale Monza', 5.793, 1950, 'normal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Bahrain International Circuit', 5.412, 2004, 'normal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Bahrain International Circuit – Outer Track', 3.543, 2020, 'normal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Circuit de Barcelona-Catalunya', 4.655, 1991, 'stradal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Circuit de Spa-Francorchamps', 7.004, 1950, 'normal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Hungaroring', 4.381, 1986, 'normal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Intercity Istanbul Park', 5.338, 2005, 'normal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Mugello', 5.245, 2020, 'normal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Nürburgring', 5.148, 1951, 'normal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Red Bull Ring', 4.318, 1970, 'normal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Silverstone Circuit', 5.891, 1950, 'normal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Sochi Autodrom', 5.848, 2014, 'normal');
insert into gcmf1.circuite (circuit_id, lungime, an_constructie, tip_circuit)
values ('Yas Marina Circuit', 5.554, 2009, 'normal');

insert into gcmf1.furnizori_motoare (furnizor_id, cai_putere, nr_cilindri, brand_combustibil)
values ('Ferrari', 1001, 6, 'Shell');
insert into gcmf1.furnizori_motoare (furnizor_id, cai_putere, nr_cilindri, brand_combustibil)
values ('Mercedes-AMG', 1040, 6, 'Petronas');
insert into gcmf1.furnizori_motoare (furnizor_id, cai_putere, nr_cilindri, brand_combustibil)
values ('Renault', 980, 6, 'Castrol');
insert into gcmf1.furnizori_motoare (furnizor_id, cai_putere, nr_cilindri, brand_combustibil)
values ('Honda', 997, default, 'Mobil1');

insert into gcmf1.echipe (echipe_id, furnizor_id, culoare, sediu_tara, sediu_oras, buget_anual)
values ('Alfa Romeo Racing ORLEN', 'Ferrari', 'Rosu si alb', 'Switzerland', 'Hinwil', 7770180);
insert into gcmf1.echipe (echipe_id, furnizor_id, culoare, sediu_tara, sediu_oras, buget_anual)
values ('Aston Martin Red Bull Racing', 'Honda', 'Albastru inchis', 'United Kingdom', 'Milton Keynes', 9952150);
insert into gcmf1.echipe (echipe_id, furnizor_id, culoare, sediu_tara, sediu_oras, buget_anual)
values ('BWT Racing Point F1 Team', 'Mercedes-AMG', 'Roz', 'United Kingdom', 'Silverstone', 9730430);
insert into gcmf1.echipe (echipe_id, furnizor_id, culoare, sediu_tara, sediu_oras, buget_anual)
values ('Haas F1 Team', 'Ferrari', 'Negru si alb', 'United States', 'Kannapolis', 4826050);
insert into gcmf1.echipe (echipe_id, furnizor_id, culoare, sediu_tara, sediu_oras, buget_anual)
values ('McLaren F1 Team', 'Renault', 'Portocaliu', 'United Kingdom', 'Woking', 5830380);
insert into gcmf1.echipe (echipe_id, furnizor_id, culoare, sediu_tara, sediu_oras, buget_anual)
values ('Mercedes-AMG Petronas F1 Team', 'Mercedes-AMG', 'Negru', 'United Kingdom', 'Brackley', 7209300);
insert into gcmf1.echipe (echipe_id, furnizor_id, culoare, sediu_tara, sediu_oras, buget_anual)
values ('Renault DP World F1 Team', 'Renault', 'Negru si galben', 'United Kingdom', 'Enstone', 7209300);
insert into gcmf1.echipe (echipe_id, furnizor_id, culoare, sediu_tara, sediu_oras, buget_anual)
values ('Scuderia AlphaTauri Honda', 'Honda', 'Albastru inchis si alb', 'Italy', 'Faenza', 7684800);
insert into gcmf1.echipe (echipe_id, furnizor_id, culoare, sediu_tara, sediu_oras, buget_anual)
values ('Scuderia Ferrari Mission Winnow', 'Ferrari', 'Rosu', 'Italy', 'Maranello', 11781700);
insert into gcmf1.echipe (echipe_id, furnizor_id, culoare, sediu_tara, sediu_oras, buget_anual)
values ('Williams Racing', 'Mercedes-AMG', 'Turcoaz si alb', 'United Kingdom', 'Grove', 3544310);

insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (3, 'Renault DP World F1 Team', 'Ricciardo', 'Daniel', 31, 'australian', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (4, 'McLaren F1 Team', 'Norris', 'Lando', 21, 'britanic', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (5, 'Scuderia Ferrari Mission Winnow', 'Vettel', 'Sebastian', 33, 'german', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (6, 'Williams Racing', 'Latifi', 'Nicholas', 25, 'canadian', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (7, 'Alfa Romeo Racing ORLEN', 'Räikkönen', 'Kimi', 41, 'finlandez', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (8, 'Haas F1 Team', 'Grosjean', 'Romain', 34, 'francez', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (10, 'Scuderia AlphaTauri Honda', 'Gasly', 'Pierre', 24, 'francez', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (11, 'BWT Racing Point F1 Team', 'Perez', 'Sergio', 30, 'mexican', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (16, 'Scuderia Ferrari Mission Winnow', 'Leclerc', 'Charles', 23, 'monegasc', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (18, 'BWT Racing Point F1 Team', 'Stroll', 'Lance', 22, 'canadian', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (20, 'Haas F1 Team', 'Magnussen', 'Kevin', 28, 'danez', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (23, 'Aston Martin Red Bull Racing', 'Albon', 'Alexander', 24, 'tailandez', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (26, 'Scuderia AlphaTauri Honda', 'Kvyat', 'Daniil', 26, 'rus', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (31, 'Renault DP World F1 Team', 'Ocon', 'Esteban', 24, 'francez', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (33, 'Aston Martin Red Bull Racing', 'Verstappen', 'Max', 23, 'olandez', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (44, 'Mercedes-AMG Petronas F1 Team', 'Hamilton', 'Lewis', 35, 'britanic', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (55, 'McLaren F1 Team', 'Sainz', 'Carlos', 26, 'spaniol', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (63, 'Williams Racing', 'Russell', 'George', 22, 'britanic', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (77, 'Mercedes-AMG Petronas F1 Team', 'Bottas', 'Valtteri', 31, 'finlandez', null, 0);
insert into gcmf1.piloti (pilot_id, echipa_id, nume, prenume, varsta, nationalitate, salariu, numar_titluri)
values (99, 'Alfa Romeo Racing ORLEN', 'Giovinazzi', 'Antonio', 27, 'italian', null, 0);

insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Rolex Grosser Preis Von Österreich', 'Red Bull Ring', '2020-07-05', 71);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Pirelli Grosser Preis Der Steiermark', 'Red Bull Ring', '2020-07-12', 71);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Aramco Magyar Nagydíj', 'Hungaroring', '2020-07-19', 70);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Pirelli British Grand Prix', 'Silverstone Circuit', '2020-08-02', 52);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Emirates 70th Anniversary Grand Prix', 'Silverstone Circuit', '2020-08-09', 52);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Aramco Gran Premio De España', 'Circuit de Barcelona-Catalunya', '2020-08-16', 66);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Rolex Belgian Grand Prix', 'Circuit de Spa-Francorchamps', '2020-08-30', 44);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Gran Premio Heineken D’italia', 'Autodromo Nazionale Monza', '2020-09-06', 53);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Pirelli Gran Premio Della Toscana Ferrari 1000', 'Mugello', '2020-09-13', 59);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('VTB Russian Grand Prix', 'Sochi Autodrom', '2020-09-27', 53);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Aramco Grosser Preis Der Eifel', 'Nürburgring', '2020-10-11', 60);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Heineken Grande Prémio De Portugal', 'Autódromo Internacional do Algarve', '2020-10-25', 66);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Emirates Gran Premio Dell''emilia Romagna', 'Autodromo Enzo e Dino Ferrari', '2020-11-01', 63);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('DHL Turkish Grand Prix', 'Intercity Istanbul Park', '2020-11-15', 58);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Gulf Air Bahrain Grand Prix', 'Bahrain International Circuit', '2020-11-29', 57);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Rolex Sakhir Grand Prix', 'Bahrain International Circuit – Outer Track', '2020-12-06', 87);
insert into gcmf1.grands_prix (grand_prix_id, circuit_id, data_cursa, nr_ture)
values ('Etihad Airways Abu Dhabi Grand Prix', 'Yas Marina Circuit', '2020-12-13', 55);

insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Adler Pelzer Group', 'Alfa Romeo Racing ORLEN', 995988);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Mitsubishi Electric', 'Alfa Romeo Racing ORLEN', 441959);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Singapore Airlines', 'Alfa Romeo Racing ORLEN', 8847607);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Carbon Connect', 'Alfa Romeo Racing ORLEN', 6727599);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('ORLEN', 'Alfa Romeo Racing ORLEN', 4783457);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Tag Heuer', 'Aston Martin Red Bull Racing', 1994993);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Puma', 'Aston Martin Red Bull Racing', 746071);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Mobil 1 Esso', 'Aston Martin Red Bull Racing', 729198);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Oneplus', 'Aston Martin Red Bull Racing', 1663960);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Technogym', 'Aston Martin Red Bull Racing', 8406132);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Bombardier', 'BWT Racing Point F1 Team', 6655824);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Hackett', 'BWT Racing Point F1 Team', 579402);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('3D Systems', 'BWT Racing Point F1 Team', 3345905);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('BWT', 'BWT Racing Point F1 Team', 9377093);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Magnesium', 'BWT Racing Point F1 Team', 315073);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Haas Automation', 'Haas F1 Team', 2737385);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Jack & Jones', 'Haas F1 Team', 753127);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('MindMaze', 'Haas F1 Team', 7389458);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Alpinestars', 'Haas F1 Team', 777229);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('DEF', 'Haas F1 Team', 762704);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('British-American Tobacco', 'McLaren F1 Team', 355839);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Dell', 'McLaren F1 Team', 3602136);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Huski chocolate', 'McLaren F1 Team', 719984);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Automation Anywhere', 'McLaren F1 Team', 4559753);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Estrella Galicia', 'McLaren F1 Team', 455753);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Petronas', 'Mercedes-AMG Petronas F1 Team', 2912083);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Tommy Hilfiger', 'Mercedes-AMG Petronas F1 Team', 9989430);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Bose', 'Mercedes-AMG Petronas F1 Team', 556609);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Monster Energy', 'Mercedes-AMG Petronas F1 Team', 8566830);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Police', 'Mercedes-AMG Petronas F1 Team', 6734366);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Castrol', 'Renault DP World F1 Team', 5414601);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Microsoft', 'Renault DP World F1 Team', 834366);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Boeing', 'Renault DP World F1 Team', 538496);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('HP', 'Renault DP World F1 Team', 3944185);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Le coq sportif', 'Renault DP World F1 Team', 2733060);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('myWorld', 'Scuderia AlphaTauri Honda', 943928);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Randstad', 'Scuderia AlphaTauri Honda', 3310270);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('MOOSE', 'Scuderia AlphaTauri Honda', 7941665);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Hangar 7', 'Scuderia AlphaTauri Honda', 33092928);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('RDS', 'Scuderia AlphaTauri Honda', 1975482);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Philip Morris International', 'Scuderia Ferrari Mission Winnow', 681426);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('UPS', 'Scuderia Ferrari Mission Winnow', 4330926);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Ray Ban', 'Scuderia Ferrari Mission Winnow', 437423);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Palantir', 'Scuderia Ferrari Mission Winnow', 793641);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Hublot', 'Scuderia Ferrari Mission Winnow', 653501);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('ROKiT', 'Williams Racing', 2179716);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Financial Times', 'Williams Racing', 280487);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('NetJets', 'Williams Racing', 7664655);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Lavazza', 'Williams Racing', 711710);
insert into gcmf1.sponsori (sponsor_id, echipe_id, suma_sponsorizare)
values ('Thales', 'Williams Racing', 8914125);

insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Alfa Romeo Racing ORLEN', 'Farry', 'Mauricio', 'mecanic', '2019-03-13');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Alfa Romeo Racing ORLEN', 'Ledeker', 'Elmore', 'mecanic', '2019-10-26');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Alfa Romeo Racing ORLEN', 'Bednall', 'Barnabe', 'mecanic', '2019-02-04');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Alfa Romeo Racing ORLEN', 'Coatsworth', 'Alphard', 'mecanic', '2019-08-24');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Alfa Romeo Racing ORLEN', 'Kubista', 'Aluin', 'mecanic', '2019-12-31');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Alfa Romeo Racing ORLEN', 'Danniel', 'Edwin', 'strateg de cursa', '2019-01-28');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Alfa Romeo Racing ORLEN', 'Norewood', 'Caryl', 'strateg de cursa', '2019-05-11');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Alfa Romeo Racing ORLEN', 'Tripony', 'Iggy', 'inginer de cursa', '2019-01-31');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Alfa Romeo Racing ORLEN', 'Blacklawe', 'David', 'inginer de cursa', '2019-07-21');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Alfa Romeo Racing ORLEN', 'Georgeau', 'Diego', 'director echipa', '2019-03-01');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Aston Martin Red Bull Racing', 'Link', 'Ali', 'mecanic', '2019-08-26');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Aston Martin Red Bull Racing', 'Witheford', 'Rodney', 'mecanic', '2019-12-23');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Aston Martin Red Bull Racing', 'Pettiford', 'Sloane', 'mecanic', '2019-09-01');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Aston Martin Red Bull Racing', 'Clinkard', 'Laurie', 'mecanic', '2019-09-21');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Aston Martin Red Bull Racing', 'Thunderman', 'Willey', 'mecanic', '2019-09-10');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Aston Martin Red Bull Racing', 'Jobbins', 'Thibaut', 'strateg de cursa', '2019-06-04');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Aston Martin Red Bull Racing', 'Philpotts', 'Mike', 'strateg de cursa', '2019-03-01');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Aston Martin Red Bull Racing', 'Noquet', 'Philbert', 'inginer de cursa', '2019-11-07');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Aston Martin Red Bull Racing', 'Baversor', 'Stanfield', 'inginer de cursa', '2019-07-11');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Aston Martin Red Bull Racing', 'Alleway', 'Roddy', 'director echipa', '2019-12-10');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('BWT Racing Point F1 Team', 'Ternent', 'Karim', 'mecanic', '2019-08-16');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('BWT Racing Point F1 Team', 'Admans', 'Cross', 'mecanic', '2019-12-05');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('BWT Racing Point F1 Team', 'Valentelli', 'Randell', 'mecanic', '2019-01-06');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('BWT Racing Point F1 Team', 'Pitson', 'Toddy', 'mecanic', '2019-07-15');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('BWT Racing Point F1 Team', 'Slayton', 'Curtice', 'mecanic', '2019-01-01');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('BWT Racing Point F1 Team', 'Adey', 'Dal', 'strateg de cursa', '2019-01-31');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('BWT Racing Point F1 Team', 'McAlpin', 'Barthel', 'strateg de cursa', '2019-04-29');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('BWT Racing Point F1 Team', 'Goroni', 'Irv', 'inginer de cursa', '2019-03-06');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('BWT Racing Point F1 Team', 'Wharby', 'Lay', 'inginer de cursa', '2019-10-20');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('BWT Racing Point F1 Team', 'Dutson', 'Ichabod', 'director echipa', '2019-05-30');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Haas F1 Team', 'Wenban', 'Maurise', 'mecanic', '2019-03-24');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Haas F1 Team', 'Nettleship', 'Rowland', 'mecanic', '2019-06-26');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Haas F1 Team', 'Craighill', 'Casar', 'mecanic', '2019-01-01');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Haas F1 Team', 'Blue', 'Sim', 'mecanic', '2019-01-29');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Haas F1 Team', 'Grivori', 'Stavros', 'mecanic', '2019-05-22');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Haas F1 Team', 'Peart', 'Aldrich', 'strateg de cursa', '2019-05-12');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Haas F1 Team', 'Cran', 'Yance', 'strateg de cursa', '2019-08-23');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Haas F1 Team', 'Burdikin', 'Ives', 'inginer de cursa', '2019-03-17');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Haas F1 Team', 'Wassell', 'Stefan', 'inginer de cursa', '2019-05-06');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Haas F1 Team', 'Hinkensen', 'Randie', 'director echipa', '2019-07-04');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('McLaren F1 Team', 'Beckley', 'Fredric', 'mecanic', '2019-12-12');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('McLaren F1 Team', 'Soares', 'Stanwood', 'mecanic', '2019-10-17');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('McLaren F1 Team', 'Panter', 'Ephrem', 'mecanic', '2019-10-10');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('McLaren F1 Team', 'Froude', 'Wylie', 'mecanic', '2019-03-22');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('McLaren F1 Team', 'Lowder', 'Pavel', 'mecanic', '2019-08-11');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('McLaren F1 Team', 'Lindenbaum', 'Clement', 'strateg de cursa', '2019-08-19');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('McLaren F1 Team', 'Downe', 'Kendricks', 'strateg de cursa', '2019-08-23');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('McLaren F1 Team', 'Jeandel', 'Washington', 'inginer de cursa', '2019-03-18');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('McLaren F1 Team', 'Jewkes', 'Ilaire', 'inginer de cursa', '2019-02-24');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('McLaren F1 Team', 'Waldrum', 'Hector', 'director echipa', '2019-10-03');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Mercedes-AMG Petronas F1 Team', 'Antony', 'Wash', 'mecanic', '2019-12-12');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Mercedes-AMG Petronas F1 Team', 'Mollett', 'Leonerd', 'mecanic', '2019-11-01');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Mercedes-AMG Petronas F1 Team', 'Towson', 'Adolpho', 'mecanic', '2019-12-31');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Mercedes-AMG Petronas F1 Team', 'Bartley', 'Elroy', 'mecanic', '2019-06-25');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Mercedes-AMG Petronas F1 Team', 'Althrop', 'Jozef', 'mecanic', '2019-07-13');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Mercedes-AMG Petronas F1 Team', 'Tasch', 'Pancho', 'strateg de cursa', '2019-07-20');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Mercedes-AMG Petronas F1 Team', 'Pic', 'Bail', 'strateg de cursa', '2019-09-24');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Mercedes-AMG Petronas F1 Team', 'Barwood', 'Jeremy', 'inginer de cursa', '2019-08-18');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Mercedes-AMG Petronas F1 Team', 'Scoffham', 'Neron', 'inginer de cursa', '2019-08-18');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Mercedes-AMG Petronas F1 Team', 'Polden', 'Kingsley', 'director echipa', '2019-05-22');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Renault DP World F1 Team', 'Blackston', 'Nehemiah', 'mecanic', '2019-10-30');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Renault DP World F1 Team', 'Vasiliu', 'Mackenzie', 'mecanic', '2019-01-14');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Renault DP World F1 Team', 'Stovold', 'Bancroft', 'mecanic', '2019-08-20');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Renault DP World F1 Team', 'Rohfsen', 'Victor', 'mecanic', '2019-07-25');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Renault DP World F1 Team', 'Petry', 'Dante', 'mecanic', '2019-05-23');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Renault DP World F1 Team', 'Victoria', 'Crawford', 'strateg de cursa', '2019-06-20');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Renault DP World F1 Team', 'Leys', 'Bartolomeo', 'strateg de cursa', '2019-11-17');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Renault DP World F1 Team', 'Darby', 'Kylie', 'inginer de cursa', '2019-09-29');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Renault DP World F1 Team', 'Sandwich', 'Walker', 'inginer de cursa', '2019-03-14');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Renault DP World F1 Team', 'Tritton', 'Ab', 'director echipa', '2019-12-10');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia AlphaTauri Honda', 'Couvert', 'Shepherd', 'mecanic', '2019-07-12');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia AlphaTauri Honda', 'Saunier', 'Thorstein', 'mecanic', '2019-01-20');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia AlphaTauri Honda', 'Donnison', 'Morgan', 'mecanic', '2019-09-10');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia AlphaTauri Honda', 'Zecchii', 'Lenci', 'mecanic', '2019-01-13');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia AlphaTauri Honda', 'Novkovic', 'Maurie', 'mecanic', '2019-11-27');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia AlphaTauri Honda', 'Mathonnet', 'Nikolai', 'strateg de cursa', '2019-12-29');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia AlphaTauri Honda', 'Pitway', 'Waring', 'strateg de cursa', '2019-01-13');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia AlphaTauri Honda', 'Montgomery', 'Jody', 'inginer de cursa', '2019-03-14');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia AlphaTauri Honda', 'Farrimond', 'Reuben', 'inginer de cursa', '2019-03-24');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia AlphaTauri Honda', 'Radloff', 'Tammy', 'director echipa', '2019-03-15');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia Ferrari Mission Winnow', 'Hazeup', 'Sinclair', 'mecanic', '2019-06-27');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia Ferrari Mission Winnow', 'Leschelle', 'Brandy', 'mecanic', '2019-06-01');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia Ferrari Mission Winnow', 'Grichukhanov', 'Benny', 'mecanic', '2019-11-27');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia Ferrari Mission Winnow', 'Maynell', 'Tiebout', 'mecanic', '2019-09-16');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia Ferrari Mission Winnow', 'Aleksandrikin', 'Alaster', 'mecanic', '2019-09-13');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia Ferrari Mission Winnow', 'Fieller', 'Kile', 'strateg de cursa', '2019-06-29');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia Ferrari Mission Winnow', 'Seys', 'Rowney', 'strateg de cursa', '2019-06-10');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia Ferrari Mission Winnow', 'Campanelli', 'Cornelius', 'inginer de cursa', '2019-12-20');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia Ferrari Mission Winnow', 'Feely', 'Falkner', 'inginer de cursa', '2019-11-19');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Scuderia Ferrari Mission Winnow', 'Cloutt', 'Hagen', 'director echipa', '2019-10-12');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Williams Racing', 'Leworthy', 'Yule', 'mecanic', '2019-08-28');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Williams Racing', 'Showen', 'Roman', 'mecanic', '2019-10-28');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Williams Racing', 'Whightman', 'Jakie', 'mecanic', '2019-09-27');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Williams Racing', 'Jorat', 'Giusto', 'mecanic', '2019-03-25');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Williams Racing', 'Grouse', 'Burke', 'mecanic', '2019-01-04');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Williams Racing', 'Morrison', 'Denver', 'strateg de cursa', '2019-06-16');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Williams Racing', 'MacAdam', 'Loren', 'strateg de cursa', '2019-01-28');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Williams Racing', 'Sandes', 'Alaric', 'inginer de cursa', '2019-10-28');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Williams Racing', 'Llewellyn', 'Mattie', 'inginer de cursa', '2019-11-28');
insert into gcmf1.angajati_echipe(echipa_id, nume, prenume, post, data_angajarii)
values ('Williams Racing', 'Marwood', 'Farrell', 'director echipa', '2019-10-06');

insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Gran Premio De España', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Grosser Preis Der Eifel', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Magyar Nagydíj', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('DHL Turkish Grand Prix', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates 70th Anniversary Grand Prix', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates Gran Premio Dell''emilia Romagna', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Etihad Airways Abu Dhabi Grand Prix', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gran Premio Heineken D’italia', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gulf Air Bahrain Grand Prix', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Heineken Grande Prémio De Portugal', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli British Grand Prix', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Gran Premio Della Toscana Ferrari 1000', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Grosser Preis Der Steiermark', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Belgian Grand Prix', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Grosser Preis Von Österreich', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Sakhir Grand Prix', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('VTB Russian Grand Prix', 'Alfa Romeo Racing ORLEN');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Gran Premio De España', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Grosser Preis Der Eifel', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Magyar Nagydíj', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('DHL Turkish Grand Prix', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates 70th Anniversary Grand Prix', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates Gran Premio Dell''emilia Romagna', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Etihad Airways Abu Dhabi Grand Prix', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gran Premio Heineken D’italia', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gulf Air Bahrain Grand Prix', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Heineken Grande Prémio De Portugal', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli British Grand Prix', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Gran Premio Della Toscana Ferrari 1000', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Grosser Preis Der Steiermark', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Belgian Grand Prix', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Grosser Preis Von Österreich', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Sakhir Grand Prix', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('VTB Russian Grand Prix', 'Aston Martin Red Bull Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Gran Premio De España', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Grosser Preis Der Eifel', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Magyar Nagydíj', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('DHL Turkish Grand Prix', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates 70th Anniversary Grand Prix', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates Gran Premio Dell''emilia Romagna', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Etihad Airways Abu Dhabi Grand Prix', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gran Premio Heineken D’italia', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gulf Air Bahrain Grand Prix', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Heineken Grande Prémio De Portugal', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli British Grand Prix', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Gran Premio Della Toscana Ferrari 1000', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Grosser Preis Der Steiermark', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Belgian Grand Prix', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Grosser Preis Von Österreich', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Sakhir Grand Prix', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('VTB Russian Grand Prix', 'BWT Racing Point F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Gran Premio De España', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Grosser Preis Der Eifel', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Magyar Nagydíj', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('DHL Turkish Grand Prix', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates 70th Anniversary Grand Prix', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates Gran Premio Dell''emilia Romagna', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Etihad Airways Abu Dhabi Grand Prix', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gran Premio Heineken D’italia', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gulf Air Bahrain Grand Prix', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Heineken Grande Prémio De Portugal', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli British Grand Prix', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Gran Premio Della Toscana Ferrari 1000', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Grosser Preis Der Steiermark', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Belgian Grand Prix', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Grosser Preis Von Österreich', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Sakhir Grand Prix', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('VTB Russian Grand Prix', 'Haas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Gran Premio De España', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Grosser Preis Der Eifel', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Magyar Nagydíj', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('DHL Turkish Grand Prix', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates 70th Anniversary Grand Prix', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates Gran Premio Dell''emilia Romagna', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Etihad Airways Abu Dhabi Grand Prix', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gran Premio Heineken D’italia', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gulf Air Bahrain Grand Prix', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Heineken Grande Prémio De Portugal', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli British Grand Prix', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Gran Premio Della Toscana Ferrari 1000', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Grosser Preis Der Steiermark', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Belgian Grand Prix', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Grosser Preis Von Österreich', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Sakhir Grand Prix', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('VTB Russian Grand Prix', 'McLaren F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Gran Premio De España', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Grosser Preis Der Eifel', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Magyar Nagydíj', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('DHL Turkish Grand Prix', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates 70th Anniversary Grand Prix', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates Gran Premio Dell''emilia Romagna', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Etihad Airways Abu Dhabi Grand Prix', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gran Premio Heineken D’italia', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gulf Air Bahrain Grand Prix', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Heineken Grande Prémio De Portugal', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli British Grand Prix', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Gran Premio Della Toscana Ferrari 1000', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Grosser Preis Der Steiermark', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Belgian Grand Prix', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Grosser Preis Von Österreich', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Sakhir Grand Prix', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('VTB Russian Grand Prix', 'Mercedes-AMG Petronas F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Gran Premio De España', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Grosser Preis Der Eifel', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Magyar Nagydíj', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('DHL Turkish Grand Prix', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates 70th Anniversary Grand Prix', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates Gran Premio Dell''emilia Romagna', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Etihad Airways Abu Dhabi Grand Prix', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gran Premio Heineken D’italia', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gulf Air Bahrain Grand Prix', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Heineken Grande Prémio De Portugal', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli British Grand Prix', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Gran Premio Della Toscana Ferrari 1000', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Grosser Preis Der Steiermark', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Belgian Grand Prix', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Grosser Preis Von Österreich', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Sakhir Grand Prix', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('VTB Russian Grand Prix', 'Renault DP World F1 Team');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Gran Premio De España', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Grosser Preis Der Eifel', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Magyar Nagydíj', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('DHL Turkish Grand Prix', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates 70th Anniversary Grand Prix', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates Gran Premio Dell''emilia Romagna', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Etihad Airways Abu Dhabi Grand Prix', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gran Premio Heineken D’italia', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gulf Air Bahrain Grand Prix', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Heineken Grande Prémio De Portugal', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli British Grand Prix', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Gran Premio Della Toscana Ferrari 1000', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Grosser Preis Der Steiermark', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Belgian Grand Prix', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Grosser Preis Von Österreich', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Sakhir Grand Prix', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('VTB Russian Grand Prix', 'Scuderia AlphaTauri Honda');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Gran Premio De España', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Grosser Preis Der Eifel', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Magyar Nagydíj', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('DHL Turkish Grand Prix', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates 70th Anniversary Grand Prix', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates Gran Premio Dell''emilia Romagna', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Etihad Airways Abu Dhabi Grand Prix', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gran Premio Heineken D’italia', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gulf Air Bahrain Grand Prix', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Heineken Grande Prémio De Portugal', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli British Grand Prix', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Gran Premio Della Toscana Ferrari 1000', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Grosser Preis Der Steiermark', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Belgian Grand Prix', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Grosser Preis Von Österreich', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Sakhir Grand Prix', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('VTB Russian Grand Prix', 'Scuderia Ferrari Mission Winnow');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Gran Premio De España', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Grosser Preis Der Eifel', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Aramco Magyar Nagydíj', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('DHL Turkish Grand Prix', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates 70th Anniversary Grand Prix', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Emirates Gran Premio Dell''emilia Romagna', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Etihad Airways Abu Dhabi Grand Prix', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gran Premio Heineken D’italia', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Gulf Air Bahrain Grand Prix', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Heineken Grande Prémio De Portugal', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli British Grand Prix', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Gran Premio Della Toscana Ferrari 1000', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Pirelli Grosser Preis Der Steiermark', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Belgian Grand Prix', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Grosser Preis Von Österreich', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('Rolex Sakhir Grand Prix', 'Williams Racing');
insert into gcmf1.echipe_participante (grand_prix_id, echipa_id)
values ('VTB Russian Grand Prix', 'Williams Racing');

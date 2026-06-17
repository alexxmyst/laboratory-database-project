--tables
-- Table: Analiza
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-RRRR';

-- Table: Sprzet
CREATE TABLE Sprzet (
    ID integer  NOT NULL,
    nazwa varchar2(20)  NOT NULL,
    coBada varchar2(15) NULL,
    CONSTRAINT Sprzet_pk PRIMARY KEY (ID)
) ;

INSERT INTO Sprzet values (10, 'swider', 'gleba');
INSERT INTO Sprzet values (20, 'Egner', 'gleba');
INSERT INTO Sprzet values (30, 'probnik', 'woda');
INSERT INTO Sprzet values (40, 'sonda', 'woda');
insert into Sprzet values (50, 'sito', 'woda');

-- Table: Typ_analizy
CREATE TABLE Typ_analizy (
    ID integer  NOT NULL,
    nazwa varchar2(20)  NOT NULL,
    CONSTRAINT Typ_analizy_pk PRIMARY KEY (ID)
) ;

insert into Typ_analizy values (001, 'spektofotometria');
insert into Typ_analizy values (002, 'kolorymetria');
insert into Typ_analizy values (003, 'sedymentacja');
insert into Typ_analizy values (004, 'filtrowanie');
insert into Typ_analizy values (005, 'pehametr');

-- Table: Klient
CREATE TABLE Klient (
    ID integer  NOT NULL,
    Nazwa varchar2(15)  NOT NULL,
    typ_klien varchar2(15)  NOT NULL,
    email varchar2(15)  NULL,
    tel number(9,0)  NULL,
    CONSTRAINT Klient_pk PRIMARY KEY (ID)
) ;

Insert into Klient values (1001,'ProEko','firma','proeko@gmail.pl',500900500);
Insert into Klient values (1002,'Kowalski','osoba','kowal@gmail.pl', null);
Insert into Klient values (1003,'CleanUp','firma','clean@gmail.pl',503900735);
Insert into Klient values (1004,'AgroAge','firma','agro@gmail.pl',505895896);
Insert into Klient values (1005,'Nowak','osoba','nowak@gmail.pl', 606548302);
Insert into Klient values (1006,'Trashout','firma','trash@gmail.pl', NULL);

-- Table: Pobor
CREATE TABLE Pobor (
    Id integer  NOT NULL,
    Adres varchar2(15)  NOT NULL,
    data date  NOT NULL,
    Sprzet_ID integer  NOT NULL,
    CONSTRAINT Pobor_pk PRIMARY KEY (Id)
) ;

Insert into Pobor values (100, 'Warszawa' , '12-12-2025', 10);
Insert into Pobor values (200, 'Krakow' , '12-03-2024', 10);
Insert into Pobor values (300, 'Wroclaw' , '02-09-2025', 30);
Insert into Pobor values (400, 'Torun' , '24-06-2024', 20);
Insert into Pobor values (500, 'Warszawa' , '12-12-2025', 10);
Insert into Pobor values (600, 'Kielce' , '15-03-2024', 30);
Insert into Pobor values (700, 'Katowice' , '23-09-2025', 40);
Insert into Pobor values (800, 'Olsztyn' , '30-06-2024', 20);

-- Table: Probka
CREATE TABLE Probka (
    Id integer  NOT NULL,
    Pobor_Id integer  NOT NULL,
    CONSTRAINT Probka_pk PRIMARY KEY (Id)
) ;

insert into Probka values (51, 100);
insert into Probka values (52, 100);
insert into Probka values (53, 200);
insert into Probka values (54, 100);
insert into Probka values (55, 600);
insert into Probka values (56, 700);
insert into Probka values (57, 200);
insert into Probka values (58, 800);


-- Table: Pracownik
CREATE TABLE Pracownik (
    Pesel integer  NOT NULL,
    imie varchar2(15)  NOT NULL,
    nazwisko varchar2(15)  NOT NULL,
    Stanowisko varchar2(15)  NOT NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY (Pesel)
) ;

Insert into Pracownik values (11111, 'Karol', 'Paciorek', 'KIEROWNIK');
Insert into Pracownik values (22222, 'Maria', 'Nowak', 'ASYSTENT');
Insert into Pracownik values (33333, 'Tomasz', 'Polak', 'ASYSTENT');
Insert into Pracownik values (44444, 'Lidia', 'Zarazek', 'LIDER');

-- Table: Raport
CREATE TABLE Raport (
    Id integer  NOT NULL,
    Klient_ID integer  NOT NULL,
    raport varchar2(15)  NOT NULL,
    data date  NOT NULL,
    Status varchar2(15)  NULL,
    CONSTRAINT Raport_pk PRIMARY KEY (Id)
) ;

insert into Raport values (61, 1001, 'Zestawienie', '02-09-2025', 'Draft');
insert into Raport values (62, 1001, 'Porownanie', '12-12-2025', 'Draft');
insert into Raport values (63, 1002, 'Analiza', '29-12-2024', 'Wydane');
insert into Raport values (64, 1005, 'Trendy', '09-12-2023', 'Rewizja');
insert into Raport values (65, 1004, 'Porownanie', '08-03-2025', 'Wydane');
insert into Raport values (66, 1006, 'Zestawienie', '03-05-2025', 'Zaplanowane');
insert into Raport values (67, 1006, 'Porownanie', '30-04-202', 'Zaplanowane');
insert into Raport values (68, 1003, 'Badanie', '12-12-2024', 'Draft');


-- Table: Raport_przyg
CREATE TABLE Raport_przyg (
    Raport_Id integer  NOT NULL,
    Pracownik_Pesel integer  NOT NULL,
    rozdzial_rap varchar2(20)  NOT NULL,
    CONSTRAINT Raport_przyg_pk PRIMARY KEY (Raport_Id,Pracownik_Pesel)
) ;

insert into Raport_przyg values (61, 11111, 'Wstep');
insert into Raport_przyg values (61, 22222, 'Opis');
insert into Raport_przyg values (63, 11111, 'Wstep');
insert into Raport_przyg values (63, 33333, 'Podsum');
insert into Raport_przyg values (66, 22222, 'Wstep');
insert into Raport_przyg values (68, 11111, 'Opis');
insert into Raport_przyg values (65, 11111, 'Opis');
insert into Raport_przyg values (66, 11111, 'Podsum');


-- Table: Analiza
CREATE TABLE Analiza (
    Id integer  NOT NULL,
    Pracownik_Pesel integer  NOT NULL,
    Data date  NOT NULL,
    Probka_Id integer  NOT NULL,
    Typ_analizy_ID integer  NOT NULL,
    CONSTRAINT Analiza_pk PRIMARY KEY (Id)
) ;

INSERT into Analiza values (501, 22222, '25-05-2025', 51, 001);
INSERT into Analiza values (502, 11111, '30-12-2025', 53, 001);
INSERT into Analiza values (503, 44444, '26-01-2026', 57, 002);
INSERT into Analiza values (504, 22222, '15-10-2025', 58, 005);
INSERT into Analiza values (505, 44444, '21-11-2024', 52, 003);
INSERT into Analiza values (506, 33333, '03-05-2025', 52, 004);
INSERT into Analiza values (507, 33333, '04-12-2024', 56, 002);
INSERT into Analiza values (508, 22222, '06-04-2025', 58, 002);

-- Table: Wynik
CREATE TABLE Wynik (
    ID integer  NOT NULL,
    wynik number(6,2)  NOT NULL,
    Analiza_Id integer  NOT NULL,
    Raport_Id integer  NOT NULL,
    cobada varchar2(20) NULL,
    CONSTRAINT Wynik_pk PRIMARY KEY (ID)
) ;

INSERT into Wynik values (301, 14.05, 501, 61 ,'fosfor');
INSERT into Wynik values (302, 13.5, 501, 61 ,'fosfor');
INSERT into Wynik values (303, 0.03, 502, 63 ,'azot');
INSERT into Wynik values (304, 0.05, 502, 63 ,'azot');
INSERT into Wynik values (305, 10.5, 501, 64 ,'fosfor');
INSERT into Wynik values (306, 14.5, 505, 68 ,'miedz');
INSERT into Wynik values (307, 1.05, 506, 68 ,'zelazo');
INSERT into Wynik values (308, 5.09, 506, 65 ,'zelazo');
INSERT into Wynik values (309, 4.08, 506, 63 ,'zelazo');

-- foreign keys
-- Reference: Analiza_Pracownik (table: Analiza)
ALTER TABLE Analiza ADD CONSTRAINT Analiza_Pracownik
    FOREIGN KEY (Pracownik_Pesel)
    REFERENCES Pracownik (Pesel);

-- Reference: Analiza_Probka (table: Analiza)
ALTER TABLE Analiza ADD CONSTRAINT Analiza_Probka
    FOREIGN KEY (Probka_Id)
    REFERENCES Probka (Id);

-- Reference: Analiza_Typ_analizy (table: Analiza)
ALTER TABLE Analiza ADD CONSTRAINT Analiza_Typ_analizy
    FOREIGN KEY (Typ_analizy_ID)
    REFERENCES Typ_analizy (ID);

-- Reference: Probka_Pobor (table: Probka)
ALTER TABLE Probka ADD CONSTRAINT Probka_Pobor
    FOREIGN KEY (Pobor_Id)
    REFERENCES Pobor (Id);

-- Reference: Raport_Klient (table: Raport)
ALTER TABLE Raport ADD CONSTRAINT Raport_Klient
    FOREIGN KEY (Klient_Pesel)
    REFERENCES Klient (ID);

-- Reference: Raport_przyg_Pracownik (table: Raport_przyg)
ALTER TABLE Raport_przyg ADD CONSTRAINT Raport_przyg_Pracownik
    FOREIGN KEY (Pracownik_Pesel)
    REFERENCES Pracownik (Pesel);

-- Reference: Raport_przyg_Raport (table: Raport_przyg)
ALTER TABLE Raport_przyg ADD CONSTRAINT Raport_przyg_Raport
    FOREIGN KEY (Raport_Id)
    REFERENCES Raport (Id);

-- Reference: Wynik_Analiza (table: Wynik)
ALTER TABLE Wynik ADD CONSTRAINT Wynik_Analiza
    FOREIGN KEY (Analiza_Id)
    REFERENCES Analiza (Id);

-- Reference: Wynik_Raport (table: Wynik)
ALTER TABLE Wynik ADD CONSTRAINT Wynik_Raport
    FOREIGN KEY (Raport_Id)
    REFERENCES Raport (Id);

commit;
-- End of file.

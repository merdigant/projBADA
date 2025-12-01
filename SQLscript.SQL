/*
Created: 27.11.2022
Modified: 09.12.2022
Project: Operator_sieci_komorkowej
Model: Operator_sieci_komorkowej_Model_Logiczny
Company: EiTI, PW
Author: Patryk_Jankowicz_Grzegorz_Wszola
Database: Oracle 12c Release 2
*/


-- Create sequences section -------------------------------------------------

CREATE SEQUENCE IdOperatoraSieciKomorkowejSEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE IdWlascicielaSEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE IdKlientaSEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE IdPocztySEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE IdPakietuUslugSEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE IdStanowiskaSEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE IdNieruchomosciSEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE IdPracownikaSEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE IdAdresuSEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE IdUslugiSEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE IdLIistyUslugSEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE IdFirmyOchroniarskiejSEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE IdInfrastrukturySEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

-- Create tables section -------------------------------------------------

-- Table Stacje_przekaznikowe

CREATE TABLE Stacje_przekaznikowe(
  Id_infrastruktury Integer NOT NULL,
  Wysokosc_masztu Varchar2(3 ) NOT NULL,
  Ilosc_anten Varchar2(2 ) NOT NULL,
  Zasięg Varchar2(5 ) NOT NULL,
  Liczba_klientow Varchar2(5 )
)
/

-- Add keys for table Stacje_przekaznikowe

ALTER TABLE Stacje_przekaznikowe ADD CONSTRAINT Unique_Identifier5 PRIMARY KEY (Id_infrastruktury)
/

-- Table Serwerownie

CREATE TABLE Serwerownie(
  Id_infrastruktury Integer NOT NULL,
  Pojemnosc_dyskow Varchar2(3 ) NOT NULL,
  Czy_backupowana Char(1 ) NOT NULL,
  Predkosc_polaczenia Varchar2(5 ) NOT NULL,
  Wilgotnosc Varchar2(2 ) NOT NULL,
  Temperatura Float NOT NULL
)
/

-- Add keys for table Serwerownie

ALTER TABLE Serwerownie ADD CONSTRAINT UI_Serwerownie PRIMARY KEY (Id_infrastruktury)
/

-- Table Agregatornie

CREATE TABLE Agregatornie(
  Id_infrastruktury Integer NOT NULL,
  Liczba_agregatorow Varchar2(2 ) NOT NULL,
  Maksymalna_moc Varchar2(5 ) NOT NULL,
  Czas_pracy Varchar2(2 ) NOT NULL,
  Zuzycie_paliwa Float NOT NULL
)
/

-- Add keys for table Agregatornie

ALTER TABLE Agregatornie ADD CONSTRAINT UI_Agregatornie PRIMARY KEY (Id_infrastruktury)
/

-- Table Operatorzy_sieci_komorkowej

CREATE TABLE Operatorzy_sieci_komorkowej(
  Id_operatora_sieci_komorkowej Integer NOT NULL,
  Nazwa_operatora Varchar2(100 ) NOT NULL,
  Data_zalozenia Date NOT NULL,
  Kapital Number(10,2) NOT NULL
)
/

-- Add keys for table Operatorzy_sieci_komorkowej

ALTER TABLE Operatorzy_sieci_komorkowej ADD CONSTRAINT Operator_Sieci_KomorkowejPK PRIMARY KEY (Id_operatora_sieci_komorkowej)
/

-- Table Pracownicy

CREATE TABLE Pracownicy(
  Id_pracownika Integer NOT NULL,
  Imie Varchar2(20 ) NOT NULL,
  Nazwisko Varchar2(30 ) NOT NULL,
  PESEL Char(11 ),
  Data_urodzenia Date NOT NULL,
  Data_zatrudnienia Date NOT NULL,
  Nr_telefonu Varchar2(9 ),
  Adres_email Varchar2(50 ),
  Id_operatora_sieci_komorkowej Integer NOT NULL,
  Nr_adresu Integer NOT NULL,
  Id_stanowiska Integer NOT NULL
)
/

-- Create indexes for table Pracownicy

CREATE INDEX IX_zatrudnia ON Pracownicy (Id_operatora_sieci_komorkowej)
/

CREATE INDEX IX_Relationship9 ON Pracownicy (Nr_adresu)
/

CREATE INDEX IX_Relationship13 ON Pracownicy (Id_stanowiska)
/

-- Add keys for table Pracownicy

ALTER TABLE Pracownicy ADD CONSTRAINT PracownikPK PRIMARY KEY (Id_pracownika)
/

-- Table Klienci

CREATE TABLE Klienci(
  Id_klienta Integer NOT NULL,
  Imie Varchar2(20 ) NOT NULL,
  Nazwisko Varchar2(30 ) NOT NULL,
  Numer_telefonu Varchar2(9 ),
  Adres_email Varchar2(50 ) NOT NULL,
  Czy_newsletter Char(1 ) NOT NULL,
  Id_operatora_sieci_komorkowej Integer NOT NULL,
  Nr_adresu Integer NOT NULL
)
/

-- Create indexes for table Klienci

CREATE INDEX IX_Posiada_klienta ON Klienci (Id_operatora_sieci_komorkowej)
/

CREATE INDEX IX_Relationship7 ON Klienci (Nr_adresu)
/

-- Add keys for table Klienci

ALTER TABLE Klienci ADD CONSTRAINT KlientPK PRIMARY KEY (Id_klienta)
/

-- Table Uslugi

CREATE TABLE Uslugi(
  Id_uslugi Integer NOT NULL,
  Czas_trwania Varchar2(3 ),
  Id_operatora_sieci_komorkowej Integer NOT NULL,
  Id_klienta Integer NOT NULL,
  Id_Listy_Uslug Integer NOT NULL
)
/

-- Create indexes for table Uslugi

CREATE INDEX IX_Oferuje ON Uslugi (Id_operatora_sieci_komorkowej)
/

CREATE INDEX IX_Korzysta ON Uslugi (Id_klienta)
/

CREATE INDEX IX_Uslugi_maja ON Uslugi (Id_Listy_Uslug)
/

-- Add keys for table Uslugi

ALTER TABLE Uslugi ADD CONSTRAINT UslugaPK PRIMARY KEY (Id_uslugi)
/

-- Table Nieruchomosci

CREATE TABLE Nieruchomosci(
  Id_nieruchomosci Integer NOT NULL,
  Rodzaj_nieruchomosci Varchar2(25 ) NOT NULL,
  Powierzchnia Varchar2(5 ) NOT NULL,
  Waznosc_badan_ppoz Date NOT NULL,
  Maksymalna_liczba_stanowisk Varchar2(3 ),
  Czy_monitorowane Char(1 ) NOT NULL,
  Id_operatora_sieci_komorkowej Integer NOT NULL,
  Nr_adresu Integer NOT NULL,
  Id_firmy_ochroniarskiej Integer
)
/

-- Create indexes for table Nieruchomosci

CREATE INDEX IX_Posiada_nieruchomosc ON Nieruchomosci (Id_operatora_sieci_komorkowej)
/

CREATE INDEX IX_Relationship8 ON Nieruchomosci (Nr_adresu)
/

CREATE INDEX IX_Nieruchomosc_ma_firme_ochroniarska ON Nieruchomosci (Id_firmy_ochroniarskiej)
/

-- Add keys for table Nieruchomosci

ALTER TABLE Nieruchomosci ADD CONSTRAINT NieruchomoscPK PRIMARY KEY (Id_nieruchomosci)
/

-- Table Infrastruktury

CREATE TABLE Infrastruktury(
  Id_infrastruktury Integer NOT NULL,
  Czy_krytyczna Char(1 ) NOT NULL,
  Wartosc Number(10,2) NOT NULL,
  Data_konserwacji Date NOT NULL,
  Czy_monitorowane Char(1 ) NOT NULL,
  Czy_zasilanie_awaryjne Char(1 ) NOT NULL,
  Id_operatora_sieci_komorkowej Integer NOT NULL,
  Nr_adresu Integer NOT NULL,
  Id_firmy_ochroniarskiej Integer
)
/

-- Create indexes for table Infrastruktury

CREATE INDEX IX_Dysponuje ON Infrastruktury (Id_operatora_sieci_komorkowej)
/

CREATE INDEX Infrastruktura_ma_adres ON Infrastruktury (Nr_adresu)
/

CREATE INDEX IX_Relationship3 ON Infrastruktury (Id_firmy_ochroniarskiej)
/

-- Add keys for table Infrastruktury

ALTER TABLE Infrastruktury ADD CONSTRAINT InfrastrukturaPK PRIMARY KEY (Id_infrastruktury)
/

-- Table Pracownicy_Uslugi

CREATE TABLE Pracownicy_Uslugi(
  Id_pracownika Integer NOT NULL,
  Id_uslugi Integer NOT NULL
)
/

-- Table Pracownicy_Infrastruktury

CREATE TABLE Pracownicy_Infrastruktury(
  Id_pracownika Integer NOT NULL,
  Id_infrastruktury Integer NOT NULL,
  Czy_administrator Char(1 ) NOT NULL
)
/

-- Table Pracownicy_Nieruchomosci

CREATE TABLE Pracownicy_Nieruchomosci(
  Id_pracownika Integer NOT NULL,
  Id_nieruchomosci Integer NOT NULL,
  Czy_administrator Char(1 ) NOT NULL
)
/

-- Table Listy_Uslug

CREATE TABLE Listy_Uslug(
  Id_Listy_Uslug Integer NOT NULL,
  Rodzaj_uslugi Varchar2(25 ) NOT NULL,
  Koszt Number(10,2),
  Czy_zdalna Char(1 ) NOT NULL,
  Czy_gwarancja Char(1 )
)
/

-- Add keys for table Listy_Uslug

ALTER TABLE Listy_Uslug ADD CONSTRAINT PK_Listy_Uslug PRIMARY KEY (Id_Listy_Uslug)
/

-- Table Adresy

CREATE TABLE Adresy(
  Id_adresu Integer NOT NULL,
  Miejscowosc Varchar2(40 ) NOT NULL,
  Ulica Varchar2(40 ) NOT NULL,
  Numer_budynku Varchar2(4 ),
  Numer_lokalu Varchar2(4 ),
  Id_poczty Integer NOT NULL
)
/

-- Create indexes for table Adresy

CREATE INDEX IX_Relationship4 ON Adresy (Id_poczty)
/

-- Add keys for table Adresy

ALTER TABLE Adresy ADD CONSTRAINT PK_Adresy PRIMARY KEY (Id_adresu)
/

-- Table Poczty

CREATE TABLE Poczty(
  Id_poczty Integer NOT NULL,
  Kod_poczty Char(6 ) NOT NULL,
  Miejscowosc_Poczty Varchar2(40 ) NOT NULL
)
/

-- Add keys for table Poczty

ALTER TABLE Poczty ADD CONSTRAINT PK_Poczty PRIMARY KEY (Id_poczty)
/

ALTER TABLE Poczty ADD CONSTRAINT Kod_poczty UNIQUE (Kod_poczty)
/

-- Table Wlasciciele

CREATE TABLE Wlasciciele(
  Id_wlasciciela Integer NOT NULL,
  Imie Varchar2(20 ) NOT NULL,
  Nazwisko Varchar2(30 ) NOT NULL,
  Numer_telefonu Varchar2(9 ) NOT NULL,
  Id_operatora_sieci_komorkowej Integer NOT NULL,
  Id_adresu Integer NOT NULL
)
/

-- Create indexes for table Wlasciciele

CREATE INDEX IX_Relationship5 ON Wlasciciele (Id_operatora_sieci_komorkowej)
/

CREATE INDEX IX_Relationship6 ON Wlasciciele (Id_adresu)
/

-- Add keys for table Wlasciciele

ALTER TABLE Wlasciciele ADD CONSTRAINT PK_Wlasciciele PRIMARY KEY (Id_wlasciciela)
/

-- Table Stanowiska

CREATE TABLE Stanowiska(
  Id_stanowiska Integer NOT NULL,
  Rodzaj_wyksztalcenia Varchar2(15 ) NOT NULL,
  Czy_mobilne Char(1 ) NOT NULL,
  Rodzaj_stanowiska Varchar2(25 ) NOT NULL
)
/

-- Add keys for table Stanowiska

ALTER TABLE Stanowiska ADD CONSTRAINT PK_Stanowiska PRIMARY KEY (Id_stanowiska)
/

-- Table Pakiety_uslug

CREATE TABLE Pakiety_uslug(
  Id_pakietu_uslug Integer NOT NULL,
  Rodzaj_pakietu Varchar2(40 ) NOT NULL,
  Cena Number(10,2) NOT NULL,
  Data_obowiazywania Date NOT NULL,
  Id_klienta Integer NOT NULL
)
/

-- Create indexes for table Pakiety_uslug

CREATE INDEX IX_Relationship1 ON Pakiety_uslug (Id_klienta)
/

-- Add keys for table Pakiety_uslug

ALTER TABLE Pakiety_uslug ADD CONSTRAINT PK_Pakiety_uslug PRIMARY KEY (Id_pakietu_uslug)
/

-- Table Firmy_ochroniarskie

CREATE TABLE Firmy_ochroniarskie(
  Id_firmy_ochroniarskiej Integer NOT NULL,
  Nazwa Varchar2(30 ) NOT NULL,
  Czy_oferuje_monitoring Char(1 ) NOT NULL,
  awaryjny_numer_telefonu Varchar2(9 ) NOT NULL,
  Id_adresu Integer NOT NULL
)
/

-- Create indexes for table Firmy_ochroniarskie

CREATE INDEX IX_Relationship2 ON Firmy_ochroniarskie (Id_adresu)
/

-- Add keys for table Firmy_ochroniarskie

ALTER TABLE Firmy_ochroniarskie ADD CONSTRAINT PK_Firmy_ochroniarskie PRIMARY KEY (Id_firmy_ochroniarskiej)
/

-- Trigger for sequence IdOperatoraSieciKomorkowejSEQ for column Id_operatora_sieci_komorkowej in table Operatorzy_sieci_komorkowej ---------
CREATE OR REPLACE TRIGGER ts_Operatorzy_sieci_komorkowej_IdOperatoraSieciKomorkowejSEQ BEFORE INSERT
ON Operatorzy_sieci_komorkowej FOR EACH ROW
BEGIN
  :new.Id_operatora_sieci_komorkowej := IdOperatoraSieciKomorkowejSEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Operatorzy_sieci_komorkowej_IdOperatoraSieciKomorkowejSEQ AFTER UPDATE OF Id_operatora_sieci_komorkowej
ON Operatorzy_sieci_komorkowej FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_operatora_sieci_komorkowej in table Operatorzy_sieci_komorkowej as it uses sequence.');
END;
/

-- Trigger for sequence IdPracownikaSEQ for column Id_pracownika in table Pracownicy ---------
CREATE OR REPLACE TRIGGER ts_Pracownicy_IdPracownikaSEQ BEFORE INSERT
ON Pracownicy FOR EACH ROW
BEGIN
  :new.Id_pracownika := IdPracownikaSEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Pracownicy_IdPracownikaSEQ AFTER UPDATE OF Id_pracownika
ON Pracownicy FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_pracownika in table Pracownicy as it uses sequence.');
END;
/

-- Trigger for sequence IdKlientaSEQ for column Id_klienta in table Klienci ---------
CREATE OR REPLACE TRIGGER ts_Klienci_IdKlientaSEQ BEFORE INSERT
ON Klienci FOR EACH ROW
BEGIN
  :new.Id_klienta := IdKlientaSEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Klienci_IdKlientaSEQ AFTER UPDATE OF Id_klienta
ON Klienci FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_klienta in table Klienci as it uses sequence.');
END;
/

-- Trigger for sequence IdUslugiSEQ for column Id_uslugi in table Uslugi ---------
CREATE OR REPLACE TRIGGER ts_Uslugi_IdUslugiSEQ BEFORE INSERT
ON Uslugi FOR EACH ROW
BEGIN
  :new.Id_uslugi := IdUslugiSEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Uslugi_IdUslugiSEQ AFTER UPDATE OF Id_uslugi
ON Uslugi FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_uslugi in table Uslugi as it uses sequence.');
END;
/

-- Trigger for sequence IdNieruchomosciSEQ for column Id_nieruchomosci in table Nieruchomosci ---------
CREATE OR REPLACE TRIGGER ts_Nieruchomosci_IdNieruchomosciSEQ BEFORE INSERT
ON Nieruchomosci FOR EACH ROW
BEGIN
  :new.Id_nieruchomosci := IdNieruchomosciSEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Nieruchomosci_IdNieruchomosciSEQ AFTER UPDATE OF Id_nieruchomosci
ON Nieruchomosci FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_nieruchomosci in table Nieruchomosci as it uses sequence.');
END;
/

-- Trigger for sequence IdInfrastrukturySEQ for column Id_infrastruktury in table Infrastruktury ---------
CREATE OR REPLACE TRIGGER ts_Infrastruktury_IdInfrastrukturySEQ BEFORE INSERT
ON Infrastruktury FOR EACH ROW
BEGIN
  :new.Id_infrastruktury := IdInfrastrukturySEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Infrastruktury_IdInfrastrukturySEQ AFTER UPDATE OF Id_infrastruktury
ON Infrastruktury FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_infrastruktury in table Infrastruktury as it uses sequence.');
END;
/

-- Trigger for sequence IdLIistyUslugSEQ for column Id_Listy_Uslug in table Listy_Uslug ---------
CREATE OR REPLACE TRIGGER ts_Listy_Uslug_IdLIistyUslugSEQ BEFORE INSERT
ON Listy_Uslug FOR EACH ROW
BEGIN
  :new.Id_Listy_Uslug := IdLIistyUslugSEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Listy_Uslug_IdLIistyUslugSEQ AFTER UPDATE OF Id_Listy_Uslug
ON Listy_Uslug FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_Listy_Uslug in table Listy_Uslug as it uses sequence.');
END;
/

-- Trigger for sequence IdAdresuSEQ for column Id_adresu in table Adresy ---------
CREATE OR REPLACE TRIGGER ts_Adresy_IdAdresuSEQ BEFORE INSERT
ON Adresy FOR EACH ROW
BEGIN
  :new.Id_adresu := IdAdresuSEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Adresy_IdAdresuSEQ AFTER UPDATE OF Id_adresu
ON Adresy FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_adresu in table Adresy as it uses sequence.');
END;
/

-- Trigger for sequence IdPocztySEQ for column Id_poczty in table Poczty ---------
CREATE OR REPLACE TRIGGER ts_Poczty_IdPocztySEQ BEFORE INSERT
ON Poczty FOR EACH ROW
BEGIN
  :new.Id_poczty := IdPocztySEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Poczty_IdPocztySEQ AFTER UPDATE OF Id_poczty
ON Poczty FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_poczty in table Poczty as it uses sequence.');
END;
/

-- Trigger for sequence IdWlascicielaSEQ for column Id_wlasciciela in table Wlasciciele ---------
CREATE OR REPLACE TRIGGER ts_Wlasciciele_IdWlascicielaSEQ BEFORE INSERT
ON Wlasciciele FOR EACH ROW
BEGIN
  :new.Id_wlasciciela := IdWlascicielaSEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Wlasciciele_IdWlascicielaSEQ AFTER UPDATE OF Id_wlasciciela
ON Wlasciciele FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_wlasciciela in table Wlasciciele as it uses sequence.');
END;
/

-- Trigger for sequence IdStanowiskaSEQ for column Id_stanowiska in table Stanowiska ---------
CREATE OR REPLACE TRIGGER ts_Stanowiska_IdStanowiskaSEQ BEFORE INSERT
ON Stanowiska FOR EACH ROW
BEGIN
  :new.Id_stanowiska := IdStanowiskaSEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Stanowiska_IdStanowiskaSEQ AFTER UPDATE OF Id_stanowiska
ON Stanowiska FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_stanowiska in table Stanowiska as it uses sequence.');
END;
/

-- Trigger for sequence IdPakietuUslugSEQ for column Id_pakietu_uslug in table Pakiety_uslug ---------
CREATE OR REPLACE TRIGGER ts_Pakiety_uslug_IdPakietuUslugSEQ BEFORE INSERT
ON Pakiety_uslug FOR EACH ROW
BEGIN
  :new.Id_pakietu_uslug := IdPakietuUslugSEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Pakiety_uslug_IdPakietuUslugSEQ AFTER UPDATE OF Id_pakietu_uslug
ON Pakiety_uslug FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_pakietu_uslug in table Pakiety_uslug as it uses sequence.');
END;
/

-- Trigger for sequence IdFirmyOchroniarskiejSEQ for column Id_firmy_ochroniarskiej in table Firmy_ochroniarskie ---------
CREATE OR REPLACE TRIGGER ts_Firmy_ochroniarskie_IdFirmyOchroniarskiejSEQ BEFORE INSERT
ON Firmy_ochroniarskie FOR EACH ROW
BEGIN
  :new.Id_firmy_ochroniarskiej := IdFirmyOchroniarskiejSEQ.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Firmy_ochroniarskie_IdFirmyOchroniarskiejSEQ AFTER UPDATE OF Id_firmy_ochroniarskiej
ON Firmy_ochroniarskie FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column Id_firmy_ochroniarskiej in table Firmy_ochroniarskie as it uses sequence.');
END;
/


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE Pracownicy ADD CONSTRAINT Operatorzy_zatrudniaja_pracownikow FOREIGN KEY (Id_operatora_sieci_komorkowej) REFERENCES Operatorzy_sieci_komorkowej (Id_operatora_sieci_komorkowej)
/



ALTER TABLE Klienci ADD CONSTRAINT Operatorzy_posiadaja_klientow FOREIGN KEY (Id_operatora_sieci_komorkowej) REFERENCES Operatorzy_sieci_komorkowej (Id_operatora_sieci_komorkowej)
/



ALTER TABLE Uslugi ADD CONSTRAINT Operatorzy_oferuja_uslugi FOREIGN KEY (Id_operatora_sieci_komorkowej) REFERENCES Operatorzy_sieci_komorkowej (Id_operatora_sieci_komorkowej)
/



ALTER TABLE Infrastruktury ADD CONSTRAINT Operator_dysponuje_infrastruktura FOREIGN KEY (Id_operatora_sieci_komorkowej) REFERENCES Operatorzy_sieci_komorkowej (Id_operatora_sieci_komorkowej)
/



ALTER TABLE Nieruchomosci ADD CONSTRAINT Operatorzy_posiadaja_nieruchomosci FOREIGN KEY (Id_operatora_sieci_komorkowej) REFERENCES Operatorzy_sieci_komorkowej (Id_operatora_sieci_komorkowej)
/



ALTER TABLE Uslugi ADD CONSTRAINT Klienici_korzystaja_z_uslug FOREIGN KEY (Id_klienta) REFERENCES Klienci (Id_klienta)
/



ALTER TABLE Uslugi ADD CONSTRAINT Uslugi_maja_listy_uslug FOREIGN KEY (Id_Listy_Uslug) REFERENCES Listy_Uslug (Id_Listy_Uslug)
/



ALTER TABLE Adresy ADD CONSTRAINT Adresy_maja_poczty FOREIGN KEY (Id_poczty) REFERENCES Poczty (Id_poczty)
/



ALTER TABLE Klienci ADD CONSTRAINT Klienci_maja_adresy FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Id_adresu)
/



ALTER TABLE Nieruchomosci ADD CONSTRAINT Nieruchomosci_maja_adresy FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Id_adresu)
/



ALTER TABLE Pracownicy ADD CONSTRAINT Pracownicy_maja_adresy FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Id_adresu)
/



ALTER TABLE Infrastruktury ADD CONSTRAINT Infrastruktura_ma_adres FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Id_adresu)
/



ALTER TABLE Stacje_przekaznikowe ADD CONSTRAINT Infrastruktura_Stacja_przekaznikowa FOREIGN KEY (Id_infrastruktury) REFERENCES Infrastruktury (Id_infrastruktury)
/



ALTER TABLE Agregatornie ADD CONSTRAINT Infrastruktura_Agregatornia FOREIGN KEY (Id_infrastruktury) REFERENCES Infrastruktury (Id_infrastruktury)
/



ALTER TABLE Serwerownie ADD CONSTRAINT Infrastruktura_Serwerownia FOREIGN KEY (Id_infrastruktury) REFERENCES Infrastruktury (Id_infrastruktury)
/



ALTER TABLE Wlasciciele ADD CONSTRAINT Operator_ma_wlasciciela FOREIGN KEY (Id_operatora_sieci_komorkowej) REFERENCES Operatorzy_sieci_komorkowej (Id_operatora_sieci_komorkowej)
/



ALTER TABLE Wlasciciele ADD CONSTRAINT Wlasciciel_ma_adres FOREIGN KEY (Id_adresu) REFERENCES Adresy (Id_adresu)
/



ALTER TABLE Pracownicy ADD CONSTRAINT Pracownicy_maja_stanowiska FOREIGN KEY (Id_stanowiska) REFERENCES Stanowiska (Id_stanowiska)
/



ALTER TABLE Firmy_ochroniarskie ADD CONSTRAINT Firma_ochroniarska_ma_adres FOREIGN KEY (Id_adresu) REFERENCES Adresy (Id_adresu)
/



ALTER TABLE Infrastruktury ADD CONSTRAINT Infrastruktura_ma_firme_ochroniarska FOREIGN KEY (Id_firmy_ochroniarskiej) REFERENCES Firmy_ochroniarskie (Id_firmy_ochroniarskiej)
/



ALTER TABLE Nieruchomosci ADD CONSTRAINT Nieruchomosci_maja_firme_ochroniarska FOREIGN KEY (Id_firmy_ochroniarskiej) REFERENCES Firmy_ochroniarskie (Id_firmy_ochroniarskiej)
/



ALTER TABLE Pakiety_uslug ADD CONSTRAINT Klienci_posiadaja_pakiety_uslug FOREIGN KEY (Id_klienta) REFERENCES Klienci (Id_klienta)
/






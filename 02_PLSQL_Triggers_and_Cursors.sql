--------------------------------------------------------
--  File created - środa-czerwca-17-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure SPRAWDZRAPORT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "S999613"."SPRAWDZRAPORT" 
As
    CURSOR oneRaport IS 
        SELECT * FROM raport FOR UPDATE;

    raportwiersz oneRaport%ROWTYPE;
    dataraportu DATE;
    statusraportu varchar2(15);
BEGIN

    OPEN oneRaport;
    LOOP
        FETCH oneRaport INTO raportwiersz;
        EXIT WHEN oneRaport%NOTFOUND;

        dataraportu := raportwiersz.data;
        statusraportu := raportwiersz.status;

        IF TRUNC(dataraportu) <> TRUNC(SYSDATE) THEN

            IF TRUNC(dataraportu) > TRUNC(SYSDATE) THEN
                UPDATE raport SET status = 'W przygotowaniu' WHERE CURRENT OF oneRaport;
                DBMS_OUTPUT.PUT_LINE('Id: ' || raportwiersz.id || ' - Uwaga! Ustawiona data z przyszłości. Zmieniono status na: "W przygotowaniu"');
            ELSE
                IF MONTHS_BETWEEN(SYSDATE, dataraportu) >= 24 and statusraportu <> 'zarchiwizowany' THEN
                    UPDATE raport SET status = 'zarchiwizowany' WHERE CURRENT OF oneRaport;
                    DBMS_OUTPUT.PUT_LINE('Id: ' || raportwiersz.id || ' - Raport starszy niż 2 lata. Zmieniono status na "zarchiwizowany"');
                END IF;
            END IF;

        END IF;
    END LOOP;
    CLOSE oneRaport;

END;

/

create or replace procedure wstawRaport(
    nazwaRap in varchar, 
    klientID in int, 
    stat in varchar, 
    dataRaportu in date default SYSDATE
) as
    ile integer;
    IDraportu integer;
    aktStatus varchar(50);
    liczbaKlient int;
    brak_klienta exception;
begin 

    select count(*) into ile from Klient where ID = klientID;

    if ile = 0 then
        raise brak_klienta;
    else
        select count(*) into ile from Raport where raport = nazwaRap and Klient_pesel = klientID;

        if (ile > 0) then
            select status into aktStatus from Raport where raport = nazwaRap and Klient_pesel = klientID;

            update Raport 
            set data = SYSDATE 
            where raport = nazwaRap and Klient_pesel = klientID;

            if aktStatus = stat then
                dbms_output.put_line('Status raportu jest aktualny: ' || stat);
            else 
                update Raport 
                set status = stat
                where raport = nazwaRap and Klient_pesel = klientID;
                dbms_output.put_line('Zaktualizowano status raportu na: ' || stat);
            end if;
        else 
            select max(id) + 1 into IDraportu from Raport;
            insert into Raport (ID, Klient_pesel, raport, Status, data) 
            values (IDraportu, klientID, nazwaRap, stat, SYSDATE);

            dbms_output.put_line('Wstawiono raport: ' || nazwaRap || ' w dniu ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD'));
        end if;
    end if;

exception
    when brak_klienta then
        dbMs_OUTPUT.PUT_LINE('Nie ma podanego klienta - ' || klientID || '. Stworz jego konto w systemie!');
        select count(*) into liczbaKlient from Klient;
        dbMs_OUTPUT.PUT_LINE('Aktualna liczba klientow w systemie: ' || liczbaKlient);
    when others then
        dbMs_OUTPUT.PUT_LINE('Wystąpił nieoczekiwany błąd: ' || SQLERRM);
end wstawRaport;

create or replace TRIGGER checkWynik1
BEFORE INSERT OR UPDATE OR DELETE
ON wynik
FOR EACH ROW
BEGIN


    IF UPDATING THEN
        IF :old.cobada <> :new.cobada THEN
            RAISE_APPLICATION_ERROR(-20511, 'Nie wolno zmienić badanego pierwiastka!');
        END IF;

        IF :old.wynik <> :new.wynik THEN
            IF :new.wynik < 0 THEN 
                RAISE_APPLICATION_ERROR(-20512, 'Wynik analizy nie może być ujemny');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Nadpisano wartosc wyniku z ' || :old.wynik || ' na ' || :new.wynik);
            END IF;
        END IF;
    END IF;

    IF DELETING THEN
        IF :old.wynik >= 0 THEN
            RAISE_APPLICATION_ERROR(-20015, 'Nie wolno usunąć wyniku z nieujemną wartoscią');
        END IF;
    END IF;

    IF INSERTING THEN
        IF :new.wynik < 0  THEN
            RAISE_APPLICATION_ERROR(-20013, 'Nie wolno wstawić wyniku z nieujemną wartoscią');
        end if;
        IF :new.wynik > 150 then
        DBMS_OUTPUT.PUT_LINE('Uwaga! Wartość graniczna zawartości pierwiastka!');
            END IF;
        END IF;
END;

create or replace trigger sprawdzWynik
before insert or update
on wynik
for each row
begin
    if updating or inserting then
        if :new.wynik < 0 then
        raise_application_error(-20510, 'Wynik analizy nie może być ujemny');
        end if;
end if;
end;


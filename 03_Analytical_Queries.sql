select p.pesel, count (*)
from pracownik p
join raport_przyg rp on rp.pracownik_pesel = p.pesel
join raport r on r.id = rp.Raport_id
where extract (year from r.data) = 2025
group by p.pesel
having count (*) >1;

SELECT s.cobada, p.adres, pr.id Próbka
from sprzet s
join pobor p on p.sprzet_id = s.id
join probka pr on p.id = pr.pobor_id
where p.id in (
	select p.id
	from pobor p
where p.adres = 'Warszawa');

select a.probka_id, count(*), n.avg_srednia
from analiza a
join (
select avg(cnt) avg_srednia
from (select  count(*) cnt
    from analiza
    group by probka_id) t
) n on 1=1
group by a.probka_id, n.avg_srednia
having count(*) > n.avg_srednia;

select wynik, w.cobada pierwiastek
from wynik w
where wynik >
(select avg(w2.wynik)
from wynik w2
where w2.cobada = w.cobada);

select p.id, count(*) “ilość próbek”
from pobor p
join probka pr on p.id = pr.pobor_id 
group by p.id
having count(*) = 
(select max(count(*))
from probka pr
group by pr.pobor_id);

select a.pracownik_pesel pesel, a.probka_id probka, count(*) "ile razy"
from analiza a
group by a.pracownik_pesel, a.probka_id
having count(*) = (
select min(count(*))
from analiza a1
where a1.pracownik_pesel = a.pracownik_pesel
group by a1.probka_id);

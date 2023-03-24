USE Spital;

--interogare1 afiseaza toti pacientii care au fost internati intr-una din lunile iulie sau august din 2022(1 DISTINCT , 1 WHERE)
select * from Pacient;
select * from Internare;

SELECT DISTINCT P.nume_p FROM Pacient P, Internare I WHERE P.cod_p=I.cod_p AND data_internare>='2022-07-01' AND I.data_externare<='2022-08-31';


--interogare2 afiseaza saloanele ocupate dintr-o anumita zi si numarul de pacienti din ele(1 WHERE,1 GROUP BY, 1 INFO FROM >2 TABLES,1 FROM M-N TABLES)
select * from Pacient;
select * from Internare;
select * from Salon;

SELECT S.cod_s, COUNT(P.cod_p) AS nr_pacienti 
FROM Pacient P, Salon S, Internare I 
WHERE I.cod_s=S.cod_s AND P.cod_p=I.cod_p AND I.data_internare<='2022-05-14' AND I.data_externare>='2022-05-14'
GROUP BY S.cod_s;

--interogare3 afiseaza totalul de pacienti ingrijiti de fiecare asistent dintr-un anumit salon(WHERE,GROUP BY)
select * from Pacient;
select * from Internare;
select * from Salon;
select * from Asistent;
select * from Salon_Asistent;

SELECT A.nume_a, COUNT(I.cod_p) AS nr_pacienti FROM Internare I,Asistent A WHERE A.cod_a=I.cod_a AND I.cod_s=1 GROUP BY A.nume_a;

--interogare4 cati asistenti detine fiecare sectie cu cel putin 3 asistenti(1 WHERE, 1 GROUP BY,1 HAVING )
select * from Salon;
select * from Asistent;
select * from Salon_Asistent;
select * from Sectie;

SELECT Se.denumire_s, COUNT(A.nume_a) as nr_asistenti FROM Asistent A, Sectie Se, Salon_Asistent S_A
WHERE A.cod_a=S_A.cod_a AND S_A.cod_s=Se.cod_s GROUP BY Se.denumire_s HAVING COUNT(A.nume_a)>=3

--interogare5 afisati toate bolile pe care le-a avut un pacient(1 WHERE,1 DISTINCT)
select * from Boala;
select * from Pacient;
select * from Reteta;

SELECT DISTINCT B.nume_b FROM Boala B, Reteta R, Pacient P WHERE p.nume_p='Variu Andrei' AND P.cod_p=R.cod_p AND R.cod_b=B.cod_b;


--interogare6 afisati saloanele impreuna cu nr de asistenti?(WHERE, GROUP BY)

select * from Salon;
select * from Asistent;
select * from Salon_Asistent;
--SELECT COUNT(S_A2.cod_a) FROM Salon_Asistent S_A2 GROUP BY S_A2.cod_s;

SELECT S.cod_s, COUNT(A.nume_a) AS nr_asistent 
FROM Salon S, Asistent A, Salon_Asistent S_A 
WHERE S.cod_s=S_A.cod_s AND A.cod_a=S_A.cod_a
GROUP BY S.cod_s;


--interogare7 afisati medicii, impreuna cu nr de pacienti, care au avut cel putin 2 pacienti internati intr-o anumita data

select * from Internare;

SELECT M.nume_m, COUNT(I.cod_p) FROM Medic M,Internare I 
WHERE I.cod_m=M.cod_m AND I.data_internare<='2022-05-14' AND I.data_externare>='2022-05-14'
GROUP BY M.nume_m
HAVING COUNT(I.cod_p)>1;


--interogare8 afisati toate retetele care contin un anumit medicament(INFO FROM >2)

select * from Reteta;
select * from Reteta_Medicament;
select * from Medicament;

SELECT R.cod_r FROM Reteta R, Medicament M, Reteta_Medicament R_M WHERE M.nume_m = 'nitroglicerina' AND R.cod_r=R_M.cod_r AND M.cod_m=R_M.cod_m;


--interogare9 afisati numele pacientilor internati intr-un anumit salon intr-o anumita data(INFO FROM >2)
select * from Pacient;
select * from Internare;
select * from Salon;

SELECT P.nume_p FROM Pacient P, Internare I, Salon S 
WHERE S.cod_s=1 AND I.data_internare<='2022-05-14' AND I.data_externare>='2022-05-14' AND P.cod_p=I.cod_p AND S.cod_s=I.cod_s;


--interogare10 afisati pacientii care ai fost internati de un anumit medic(INFO FROM >2)
select * from Pacient;
select * from Internare;
select * from Medic;

SELECT DISTINCT P.nume_p from Pacient P, Internare I, Medic M
WHERE P.cod_p=I.cod_p AND M.cod_m=I.cod_m AND M.nume_m='Pop Ioan';


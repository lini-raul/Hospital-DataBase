USE Spital;
go

--afisati pacientii care ai fost internati de un anumit medic(INFO FROM >2)
CREATE VIEW view_4 AS
	SELECT DISTINCT P.nume_p from Pacient P, Internare I, Medic M
WHERE P.cod_p=I.cod_p AND M.cod_m=I.cod_m AND M.nume_m='Pop Ioan';
go

--internarile dintr-o anumita perioada
CREATE VIEW view_5 AS
	SELECT I.cod_i from Internare I
WHERE I.data_internare>='2022-08-19' AND I.data_externare<='2022-08-25';
go

select nume_p from view_4;
select cod_i from view_5;

go
--index's view_4
CREATE INDEX IX_Pacient_cod_p_nume_asc ON Pacient
(cod_p ASC, nume_p ASC);

CREATE INDEX IX_Medic_cod_m_asc_nume_m_asc ON Medic
(cod_m ASC, nume_m ASC);

CREATE INDEX IX_Internare_cod_p_asc_cod_m_asc ON Internare
(cod_p ASC, cod_m ASC);



--index's view_5
CREATE INDEX IX_Internare_cod_i_data_internar_data_externare ON Internare
(cod_i ASC, data_internare ASC, data_externare ASC);




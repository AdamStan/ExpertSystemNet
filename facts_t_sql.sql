CREATE TABLE [dbo].Facts
(
	[Id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	fact_name VARCHAR(64) NOT NULL,
	fact_description VARCHAR(255) NULL,
	is_true bit NULL
)

insert into Facts (fact_name) values 
	('jedzenie'), -- 1
	('zwierzeta'), -- 2
	('schronienie'), -- 3
	('opal'), -- 4
	('grupa'), -- 5
	('masz_cos_cennego'), -- 6
	('wrog'), -- 7
	('jestes_slaby'), -- 8
	('uczulenie'), -- 9
	('zwierzeta_dzikie'), -- 10
	('owady'), -- 11
	('trujace_grzybki'), -- 12
	('jadowite_pajaki'), -- 13
	('ubranie'), -- 14
	('dolegliwosci'), -- 15
	('surowica'), -- 16
	('gory'),  -- 17
	('wspinaczka'), -- 18
	('szczyt'), -- 19
	('burza'), -- 20
	('medykamenty'), -- 21
	('bron'), -- 22
	('bhp'), -- 23
	('uzycie_broni'), -- 24
	('slady'), -- 25
	('schron'), -- 26
	('kombinezon_przeciwpromienny'), -- 27
	('barykada'); -- 28

update Facts set fact_description = 'Czy masz jedzenie?' where Id = 1;
update Facts set fact_description = 'Czy w pobliżu są zwierzęta?' where Id = 2;
update Facts set fact_description = 'Czy masz schronienie?' where Id = 3;
update Facts set fact_description = 'Czy masz opal?' where Id = 4;
update Facts set fact_description = 'Czy jestes w grupie?' where Id = 5;
update Facts set fact_description = 'Czy masz cos cennego?' where Id = 6;
update Facts set fact_description = 'Czy masz wroga?' where Id = 7;
update Facts set fact_description = 'Czy jestes slaby?' where Id = 8;
update Facts set fact_description = 'Czy masz uczulenie?' where Id = 9;
update Facts set fact_description = 'Czy w okolicy są dzikie zwierzeta?' where Id = 10;
update Facts set fact_description = 'Czy w pobliżu są jakieś owady?' where Id = 11;
update Facts set fact_description = 'Czy jesz trujące grzybki?' where Id = 12;
update Facts set fact_description = 'Czy twoj sąsiad miał jadowite pająki?' where Id = 13;
update Facts set fact_description = 'Czy masz ubranie?' where Id = 14;
update Facts set fact_description = 'Czy masz jakies dolegliwosci?' where Id = 15;
update Facts set fact_description = 'Czy masz surowice?' where Id = 16;
update Facts set fact_description = 'Czy jestes w gorach?' where Id = 17;
update Facts set fact_description = 'Czy wspinasz sie?' where Id = 18;
update Facts set fact_description = 'Jestes na szczycie?' where Id = 19;
update Facts set fact_description = 'Jest burza?' where Id = 20;
update Facts set fact_description = 'Czy masz medykamenty?' where Id = 21;
update Facts set fact_description = 'Czy masz bron?' where Id = 22;
update Facts set fact_description = 'Przestrzegasz bhp?' where Id = 23;
update Facts set fact_description = 'Umiesz obslugiwac bron?' where Id = 24;
update Facts set fact_description = 'Czy widziales/as jakies slady?' where Id = 25;
update Facts set fact_description = 'Czy mozesz sie schowac do schronu?' where Id = 26;
update Facts set fact_description = 'Czy masz kombinezon przeciwpromienny?' where Id = 27;
update Facts set fact_description = 'Czy barykada?' where Id = 28;

CREATE TABLE [dbo].Conclusions
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	conclusion_name VARCHAR(64)
)

insert into Conclusions VALUES 
	('smierc_z_glodu'), ('smierc_z_zimna'),
	('zjedzony_przez_niedzwiedzia'), ('smierc_w_pozarze'),
	('smierc_ktos_cie_zabije'), ('smierc_choroba'),
	('wstrzas_anafilaktyczny'), ('wypadek'),
	('piorun'), ('zjedzony_przez_zombie'),
	('smierc_przez_napromieniowanie'), ('zastrzelisz_sie');
	
CREATE TABLE FactsToConclusions (
	fact_id INT,
	conclusion_id INT,
	CONSTRAINT fk_fact FOREIGN KEY (fact_id) REFERENCES Facts(Id),
	CONSTRAINT fk_conclusion FOREIGN KEY (conclusion_id) REFERENCES Conclusions(Id)
)

ALTER TABLE FactsToConclusions 
	ADD val bit;
	

select * from Conclusions c
inner join FactsToConclusions ftc on c.Id = ftc.conclusion_id
inner join Facts f on f.Id = ftc.fact_id
	

insert into FactsToConclusions (conclusion_id, fact_id,  val) values
-- smierc z glodu:
	(1,1,0), -- jedzenie : nie
	(1,2,0), -- zwierzeta : nie
	(1,8,1), -- jestes_slaby : tak
-- smierc z zimna
	(2,3,0), -- schronienie : nie
	(2,4,0), -- opal : nie
	(2,14,0), -- ubranie : nie
-- zjedzony_przez_niedzwiedzia
	(3,3,1), -- schronienie : tak
	(3,10,1), -- zwierzeta_dzikie : tak
	(3,25,1), -- slady : tak
	(3,8,1), -- jestes_slaby : tak
-- smierc_w_pozarze
	(4,4,1), -- opal : tak
	(4,23,0), -- bhp : nie
-- smierc_ktos_cie_zabije
	(5,5,1), -- grupa : tak
	(5,6,1), -- masz_cos_cennego : tak
	(5,8,1), -- jestes_slaby : tak
	(5,7,1), -- wrog : tak
	(5,28,1), -- barykada : tak
-- smierc_choroba
	(6,9,1), -- uczulenie : tak
	(6,10,1), -- zwierzeta_dzikie : tak
	(6,15,1), -- dolegliwosci : tak
	(6,21,0), -- medykamenty : nie
-- wstrzas_anafilaktyczny
	(7,9,1), -- uczulenie : tak
	(7,13,1), -- jadowite_pajaki : tak
	(7,16,0), -- surowica : nie
-- wypadek
	(8,17,1), -- gory : tak
	(8,18,0), -- wspinaczka : nie
-- piorun
	(9,17,1), -- gory : tak
	(9,18,1), -- wspinaczka : tak
	(9,19,1), -- szczyt : tak
	(9,20,1), -- burza : tak
-- zjedzony_przez_zombie
	(10,8,1), -- jestes_slaby : tak
	(10,5,0), -- grupa : nie
	(10,22,0), -- bron : nie
-- smierc_przez_napromieniowanie
	(11,27,0), -- kombinezon_przeciwpromienny : nie
	(11,26,0), -- schron : nie
-- zastrzelisz_sie
	(12,22,1), -- bron : tak
	(12,24,0); -- uzycie_broni : nie
	
	
ALTER TABLE Conclusions ADD description VARCHAR(160)

update Conclusions set description = 'Umrzesz z głodu' where Id = 1
update Conclusions set description = 'Umrzesz z zimna' where Id = 2
update Conclusions set description = 'Zostaniesz zjedzony przez niedźwiedzia' where Id = 3
update Conclusions set description = 'Zginiesz w pożarze' where Id = 4
update Conclusions set description = 'Ktoś cię zabije' where Id = 5
update Conclusions set description = 'Zapadniesz na nieuleczalną chorobę' where Id = 6
update Conclusions set description = 'Dostaniesz wstrząsu anafilaktycznego' where Id = 7
update Conclusions set description = 'Zginiesz w wypadku' where Id = 8
update Conclusions set description = 'Trafi w ciebie piorun' where Id = 9
update Conclusions set description = 'Zapadniesz na chorobę popromienną' where Id = 11
update Conclusions set description = 'Popelnisz samobojstwo, przypadkowe' where Id = 12
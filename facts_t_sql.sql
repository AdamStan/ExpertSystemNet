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
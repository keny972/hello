-----------
   livre
-----------
- id_livre (INT(3), PK AI)
- titre (VARCHAR(100))
- auteur (VARCHAR(100))
------------
   emprunt
------------
- id emprunt (INT(3), PK AI)
- id_livre (INT(3), FK)
- id_abonne (INT(3), FK)
- date_sortie (DATE)
- date_retour (DATE DEFAULT NULL)
-----------
   abonne
-----------
- id_abonne (INT(3), PK AI)
- prenom (VARCHAR(20))
-----------

CREATE DATABASE diw27_bibliotheque;

USE diw27_bibliotheque;

CREATE TABLE abonne (
  id_abonne INT(3) NOT NULL AUTO_INCREMENT,
  prenom VARCHAR(20) NOT NULL,
  PRIMARY KEY(id_abonne)
) ENGINE=InnoDB ;

DESC abonne;

--------------------------------------------

CREATE TABLE livre (
  id_livre INT(3) NOT NULL AUTO_INCREMENT,
  titre VARCHAR(100) NOT NULL,
  auteur VARCHAR(100) NOT NULL,
  PRIMARY KEY(id_livre)
) ENGINE=InnoDB ;

DESC livre;

--------------------------------------------

CREATE TABLE emprunt (
  id_emprunt INT(3) NOT NULL AUTO_INCREMENT,
  id_livre INT(3) NOT NULL,
  id_abonne INT(3) NOT NULL,
  date_sortie DATE NOT NULL,
  date_retour DATE DEFAULT NULL,
  PRIMARY KEY(id_emprunt),
  FOREIGN KEY(id_livre) REFERENCES livre(id_livre),
  FOREIGN KEY(id_abonne) REFERENCES abonne(id_abonne)
) ENGINE=InnoDB ;

DESC emprunt;


SHOW TABLES;

--------------------------------------------

select id_livre from emprunt where date_rendu IS NULL;
--Cas particulier : la valeur NULL se test avec IS et non pas =.


select titre from livre where id_livre in(select id_livre from emprunt where date_rendu IS NULL);

+-------------------------+
| titre                   |
+-------------------------+
| Les Trois Mousquetaires |
| Une vie                 |
+-------------------------+
2 rows in set (0.00 sec)

--Afficher les n° de livres que chloe a emprunté
--table(s) : abonne, emprunt
--relation(s) : id_abonne

select id_livre from emprunt where id_abonne = (select id_abonne from abonne where prenom = 'Chloe');

+----------+
| id_livre |
+----------+
|      100 |
|      105 |
+----------+
2 rows in set (0.00 sec)

-----------------------------------------------------------------------

--Afficher les prénoms des abonnés ayant emprunté un livre le 19/12/2014
select prenom from abonne where id_abonne IN (select id_abonne from emprunt where date_sortie = '2014-12-19');

--Afficher le nombre de livres Guillaume a emprunté à la bibliothèque

select COUNT(id_livre) from emprunt where id_abonne IN (select id_abonne from abonne where prenom = 'Guillaume');

--Afficher les prénoms des abonnés ayant déà emprunté un livre d'Alphonse Daudet (3 étapes, on les créer 1 par 1 puis on les imbrique)

-- ETape 1 Afficher les id_livre d'Alphonse Daudet :
select id_livre from livre where auteur = 'Alphonse Daudet';
--ETape 2 Afficher les id_çabonne qui ont emprunté ces id_livre :
select id_abonne from emprunt where id_livre = 
	(select id_livre from livre where auteur = 'Alphonse Daudet');
--Etape 3 Afficher les prénoms des abonnés correspondant à ces id_abonnes
select prenom from abonne where id_abonne IN 
	(select id_abonne from emprunt where id_livre = 
		(select id_livre from livre where auteur = 'Alphonse Daudet'));

--Afficher les titres des livres que Chloe a emprunté 
select titre from livre where id_livre IN 
	(select id_livre from emprunt where id_abonne = 
		(select id_abonne from abonne where prenom = 'Chloe')
	);

--Afficher les titres des livres que Chloe n'a pas emprunté 
select titre from livre where id_livre NOT IN 
	(select id_livre from emprunt where id_abonne = 
		(select id_abonne from abonne where prenom = 'Chloe')
	);

--Afficher les titres des livres que Chloe n'a pas encore rendu
select titre from livre where id_livre IN 
	(select id_livre from emprunt where date_rendu IS NULL AND id_abonne = 
		(select id_abonne from abonne where prenom = 'Chloe')
	);

-------Mettre les requetes (lignes de codes) sur 3 lignes permet de les rendre plus lisibles------

--Afficher les dates de passage de Guillaume (pour emprunter) :


--Requete imbriquée
select date_sortie, date_rendu from emprunt where id_abonne =
	(select id_abonne from abonne where prenom = 'Guillaume');

--Jointure
	select a.prenom, e.date_sortie, e.date_rendu --ou = abonne.prenom, emprunt.date_sortie, emprunt.date_rendu
	from abonne a, emprunt e -- = légende, la table représentée par chaque initiale
	where a.id_abonne = e.id_abonne --= on sélectionne l'id commun entre 2 tables, indispensable à leur mise en relation
	AND a.prenom = 'Guillaume';

	--SELECT - ce qu'on souhaite afficher
	--FROM - de quelles tables j'ai besoin ?
	--WHERE - conditioon avec la colonne en commun entre les deux tables à joindre
	--AND - condition complémentaire(s)...(on termine toujours la requete par un ;)

	-- Différence entre requete imbriquée et jointure :

	--la requete imbriquée permet d'effectuer des relations et de produire un resultat avec des conlonnes issues d'une seule table
	--la jointure permet également d'effectuer des relations entre plusieurs tables et de produire un résultat avec des colonnes issues d'une seule table ou de plusieurs tables différentes (pour avoir une composition de colonnes).

	--Afficher les dates de sortie et de rendu pour les livres écrits par Alphonse Daudet

	select e.date_sortie, e.date_rendu, l.auteur
	from emprunt e, livre l
	where e.id_livre = l.id_livre
	And l.auteur = 'Alphonse Daudet';

	-- 1 -- Qui a emprunté le livre Une Vie sur 2014 ? (resultat : prenom)

	select a.prenom, e.date_sortie, l.titre
	from abonne a, emprunt e, livre l
	where a.id_abonne = e.id_abonne 
	and e.id_livre = l.id_livre
	AND l.titre = 'Une vie'
	And e.date_sortie BETWEEN '2014-01-01' AND '2014-12-31';

	-- 2 -- Afficher le nombre de livres à rendre pour chaque abonné (resultat : prenom + nombre)

	select a.prenom, count(e.id_livre)
	from abonne a, emprunt e
	where a.id_abonne = e.id_abonne
	Group by a.prenom;

	-- 3 -- Afficher le nombre de livres à rendre pour chaque abonné (resultat : prenom + nombre)

	select a.prenom, count(e.id_livre)
	from abonne a, emprunt e
	where a.id_abonne = e.id_abonne
	and e.date_rendu IS NULL
	Group by a.prenom;

	-- 4 -- Quçi a emprunté Quoi et Quand ? (résultat qui = prénom, quoi " titre, quand = date_sortie")

	select a.prenom, l.titre, e.date_sortie
	from abonne a, emprunt e, livre l
	where a.id_abonne = e.id_abonne
	and e.id_livre = l.id_livre;

	-- 5 -- Qui a emprunté quoi ? (résultat : prenom + id_livre)

	select a.prenom, e.id_livre
	from abonne a, emprunt e
	where a.id_abonne = e.id_abonne;

--------------------------------------------------------------------------------------------------------------
insert into abonne (prenom) values ('Rachid');

	select * from abonne;

--------------------------------------------------------
--Jointure externe

	select a.prenom, e.id_livre
	FROM abonne a left join emprunt e
	on a.id_abonne = e.id_abonne;

-----------


------------------------------Mettre au format jj-mm-aa------------------------

select id_emprunt, id_livre, id_abonne,
date_format(date_sortie, '%d/%m/%y') AS 
'date_sortie' from emprunt;
-- Date format permet d'afficher la date au format de son choix


-------------Meme exemple avec date de rendu ajouté--------------------

select id_emprunt, id_livre, id_abonne,
date_format(date_sortie, '%d/%m/%y') AS 
'date de sortie', date_format(date_rendu, '%d/%m/%y') 
AS 'date de rendu' from emprunt;


--------------------Union et Concat----------------------------

select auteur FROM livre union select prenom from abonne;
--Union permet de fusionner 2 resultats en 1 seul

select CONCAT (id_abonne, '', prenom) from abonne;
--CONCAT permet de concaténer 2 colonnes en 1 seule (fusion de 2 colonnes en 1 seule)
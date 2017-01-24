---------
livre
---------
- id_livre    (INT(3), PK-AI)
- titre       (VARCHAR(100))
- auteur      (VARCHAR(100))

---------
emprunt
---------
- id_emprunt  (INT(3), PK-AI)
- id_livre    (INT(3), FK)
- id_abonne   (INT(3), FK)
- date_sortie (DATE DEFAULT NULL)

---------
abonne
---------
- id_abonne   (INT(3), PK-AI)
- prenom      (VARCHAR(20))

CREATE DATABASE diw27_entreprise ;

USE diw27_entreprise ;

CREATE TABLE abonne (
  id_abonne INT(3) NOT NULL AUTO_INCREMENT,
  prenom VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_abonne)
) ENGINE=InnoDB ;

DESC abonne ;

CREATE TABLE livre (
  id_livre INT(3) NOT NULL AUTO_INCREMENT,
  titre VARCHAR(100) NOT NULL,
  auteur VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_livre)
) ENGINE=InnoDB ;

CREATE TABLE emprunt (
  id_emprunt INT(3) NOT NULL AUTO_INCREMENT,
  id_abonne INT(3) NOT NULL,
  id_livre INT(3) NOT NULL,
  date_sortie DATE NOT NULL,
  date_rendu DATE DEFAULT NULL,
  PRIMARY KEY (id_emprunt),
  FOREIGN KEY (id_livre) REFERENCES livre(id_livre),
  FOREIGN KEY (id_abonne) REFERENCES abonne(id_abonne)
) ENGINE=InnoDB ;
-- comme js le dernier avec la parenthèse fermante n'a pas de virgules sinon virgule partout (,) suivi de 
DESC emprunt ;
SHOW TABLES ;
SELECT id_livre FROM emprunt WHERE date_rendu IS NULL ;
-- cas particulier : la valeur NULL se teste avec IS et non pas =

-- afficher les titres des livres qui n'ont pas ete rendus à la bibliotheque
SELECT titre FROM livre WHERE id_livre IN(SELECT id_livre FROM emprunt WHERE date_rendu IS NULL) ;


-- afficher les livres que chloe a emprunte
-- table(s): abonne, emprunt
-- relation(s) : id_abonne
SELECT id_livre FROM emprunt WHERE id_abonne = 3; 
SELECT id_livre FROM emprunt WHERE id_abonne = (SELECT id_abonne FROM abonne WHERE prenom = 'chloe') ;
----------------------------------------------
-- afficher les prénoms des abonnés ayant emprunté un livre le 19/12/2014
table : emprunt, abonné
relation : id_abonne
SELECT prenom FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt WHERE date_sortie ='2014-12-19') ;
---affiche le nombre de livres que guillaume a emprunté à la bibliothèque ?
table : abonne, emprunt
relation : id_abonne
SELECT COUNT(date_sortie) AS 'date' FROM emprunt WHERE id_abonne = (SELECT  id_abonne FROM abonne WHERE prenom = 'guillaume') ;

------ afficher les prenoms des abonnes ayant déjà emprunté un livre d'alphonse daudet
table : emprunt, abonne, livre
relation: id_abonne<id_abonne>emprunt , livre<id_livre>emprunt
1- SELECT id_livre FROM livre WHERE auteur = 'alphonse daudet'; resultat 103
2- SELECT id_abonne FROM emprunt WHERE id_livre = 103; resultat 4
-- on remplace les resultat 
(SELECT id_livre FROM livre WHERE auteur = 'alphonse daudet');  



SELECT prenom FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt WHERE id_livre IN (SELECT id_livre FROM livre WHERE auteur = 'alphonse daudet'));  


------ afficher les titres des livres que chloé a emprunte à la bibliothqèue
SELECT id_abonne FROM abonne WHERE prenom LIKE '%chloe%';

SELECT titre FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE id_abonne = (SELECT id_abonne FROM abonne WHERE prenom LIKE '%chloe%'));

--- afficher les titres des livres que chloé n'a pas encore emprunte
SELECT titre FROM livre WHERE id_livre NOT IN (SELECT id_livre FROM emprunt WHERE id_abonne = (SELECT id_abonne FROM abonne WHERE prenom LIKE '%chloe%'));
--- afficher les titres des livres que chloé n'a pas encore rendu
SELECT titre FROM livre WHERE id_livre IN (
 SELECT id_livre FROM emprunt WHERE date_rendu IS NULL AND id_abonne = (
 SELECT id_abonne FROM abonne WHERE prenom = 'chloe'
 )
);
-- affiche les dates de passage de guillaume (pour emprunter un livre)
----****** requete imbriquée ******---
SELECT date_sortie, date_rendu FROM emprunt WHERE id_abonne = (SELECT id_abonne FROM abonne WHERE prenom = 'guillaume');
--**** autre methode   JOINTURE *****--
SELECT a.prenom, e.date_sortie, e.date_rendu --** ce que veut afficher ** --
FROM abonne a, emprunt e --** de quelles tables j'ai besoin *--
WHERE a.id_abonne = e.id_abonne --** le lien entre les tables à joindre *----
AND a.prenom = 'guillaume'; -- condition supplémentaire ...

--** et point virgule à la dernière ligne --
--**** autre methode   JOINTURE  sans explication *****--
SELECT a.prenom, e.date_sortie, e.date_rendu 
FROM abonne a, emprunt e 
WHERE a.id_abonne = e.id_abonne 
AND a.prenom = 'guillaume'; 

-- *** on peut mettre soit des prefixes soit nom de la table qui fera la jointure
-- difference entre req. imbriquée et jointure :
-- la req imbriquée permet d'effectuer des relation entre plusieurs tables et de produire un resultat avec des colonnes issue d'une seule table.
-- la jointure imbriquée permet d'effectuer des relation entre plusieurs tables et de produire un resultat avec des colonnes issue d'une seule table ou de plusieurs tables différentes (pour avoir une composition de colonnes).

-- afficher les dates de sortie et de rendu ecrit par alphonse daudet
table: emprunt (date_sortie, date_rendu) livre (auteur)


SELECT l.auteur, e.date_sortie, e.date_rendu
FROM livre l, emprunt e 
WHERE e.id_livre = l.id_livre
AND l.auteur = 'alphonse daudet';

SELECT livre.auteur, emprunt.date_sortie, emprunt.date_rendu
FROM livre livre, emprunt emprunt 
WHERE emprunt.id_livre = livre.id_livre
AND livre.auteur = 'alphonse daudet';
-------
-- qui a emprunte "une vie" sur l'année 2014
SELECT a.prenom, l.titre, e.date_sortie
FROM abonne a, livre l, emprunt e
WHERE a.id_abonne = e.id_abonne AND e.id_livre = l.id_livre
AND l.titre = 'une vie'  AND date_sortie LIKE '%2014%'; 

-- afficher le nombre de livre emprunté par chaque abonné
SELECT COUNT(id_emprunt) AS 'nombre de sortie' FROM emprunt GROUP BY id_abonne;

SELECT a.prenom, COUNT(e.id_livre) 
FROM emprunt e, abonne a
WHERE e.id_abonne = a.id_abonne
GROUP BY a.id_abonne;

-- aficher le nombre de livre a rendre pour chaque abonné
SELECT a.prenom, COUNT(e.id_livre) 
FROM emprunt e, abonne a
WHERE e.id_abonne = a.id_abonne 
AND date_rendu IS NULL
GROUP BY a.id_abonne;
--qui a emprunté quoi et quand (resultat : qui=prenom , quoi =titre quand=date_sortie)
SELECT a.prenom, e.date_sortie, l.titre , COUNT(e.id_livre) 
FROM emprunt e, abonne a, livre l
WHERE e.id_abonne = a.id_abonne AND e.id_livre = l.id_livre
GROUP BY a.id_abonne;
--- qui a emprunte quoi
SELECT a.prenom, id.titre
FROM abonne a, livre l
WHERE a.id_abonne = e.id_abonne;
------
INSERT into abonne(prenom) VALUES ('eric');
SELECT * FROM abonne;

------ jointure externe ----
SELECT a.prenom, e.id_livre
FROM abonne a LEFT JOIN emprunt e
ON a.id_abonne = e.id_abonne;

membre 
id membre   prenom
1           julien
2           marie * disparait
3           alex

Marie clos son compte : elle disparait de membre et devient null dans commande
commande
id commande   id membre       id produit        date
705             2 * null                1               2014  
709             1                       1               2014
713             2 * null                3               2015

produit
id produit    titre         prix
1             tshirt          15
2             pull            80
3             chemise         70

SELECT id_emprunt, id_livre, id_abonne, DATE_FORMAT(date_sortie,'%d/%m/%Y') AS 'date de sortie', DATE_FORMAT(date_rendu,'%d/%m/%Y') AS 'date de rendu' FROM emprunt ; -- Y majuscule = 2016 y minuscule = 16
-- date format permet d'afficher la date au format de son choix
SELECT auteur FROM livre UNION SELECT prenom FROM abonne;
-- union permet de fusionner 2 resultat en 1 seul
SELECT CONCAT(id_abonne,' ', prenom) FROM abonne;
-- concat = permet de fusionner 2 colonnes en une seule 
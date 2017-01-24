SELECT id_livre FROM emprunt WHERE date_rendu IS NULL ;
-- Cas particulier : la valeur se test avec IS et non pas =.

-- Afficher les titres des livres qui n'ont pas été rendu à la bibliotheque
SELECT titre FROM livre WHERE id_livre IN(100, 105);

SELECT titre FROM livre WHERE id_livre IN(
  SELECT id_livre FROM emprunt WHERE date_rendu IS NULL
);

-- Afficher les n° des livres que Chloe a emprunté.
-- table(s) : abonne, emprunt
-- relation(s) : id_abonne
SELECT id_livre FROM emprunt WHERE id_abonne = (
  SELECT id_abonne FROM abonne WHERE prenom = 'Chloe'
);

------------------------------------------------------

-- Afficher les prénoms des abonnés ayant empruntés un livre le 19/12/2014
-- table(s) : abonne, emprunt
-- relation : id_abonne
SELECT prenom FROM abonne WHERE id_abonne IN(
  SELECT id_abonne FROM emprunt WHERE date_sortie = '2014-12-19'
);
-- Afficher le nombre de livre empruntés par Guillaume à la bibliotheque ?
-- Afficher l'id_abonne de Guillaume dans la table abonne
-- Compter (count) l'id_abonne de Guillaume dans la table emprunt
SELECT COUNT(id_abonne) FROM emprunt WHERE id_abonne = (
  SELECT id_abonne FROM abonne WHERE prenom = 'Guillaume'
);

-- Afficher les prénoms des abonnés ayant déjà empruntés un livre d'Alphonse Daudet.
-- table(s) : abonne, emprunt, livre
-- relation(s) : abonne<id_abonne>emprunt -- livre<id_livre>emprunt
-- 3/ Afficher les id_livre d'Alphonse Daudet (table : livre)
-- 2/ Afficher les id_abonne qui ont emprunté ces id_livre.
-- 1/ Afficher les prénoms des abonnés correspondant à ces id_abonnes.
SELECT id_livre FROM livre WHERE auteur = 'Alphonse Daudet';
SELECT id_abonne FROM emprunt WHERE id_livre = 103 ;
SELECT prenom FROM abonne WHERE id_abonne = 4;

SELECT prenom FROM abonne WHERE id_abonne IN(
  SELECT id_abonne FROM emprunt WHERE id_livre IN(
    SELECT id_livre FROM livre WHERE auteur = 'Alphonse Daudet'
  )
);

-- Afficher les titres des livres que Chloe a empruntés a la bibliotheque
SELECT titre FROM livre WHERE id_livre IN(
  SELECT id_livre FROM emprunt WHERE id_abonne=(
    SELECT id_abonne FROM abonne WHERE prenom = 'chloe'
    )
);

-- Afficher les titres des livres que Chloe n'a pas encore empruntés a la bibliotheque
SELECT titre FROM livre WHERE id_livre NOT IN(
  SELECT id_livre FROM emprunt WHERE id_abonne=(
    SELECT id_abonne FROM abonne WHERE prenom = 'chloe'
    )
);

-- Afficher les titres des livres que Chloe n'a pas encore rendus a la bibliotheque
SELECT titre FROM livre WHERE id_livre IN(
  SELECT id_livre FROM emprunt WHERE date_rendu IS NULL AND id_abonne = (
    SELECT id_abonne FROM abonne WHERE prenom = 'Chloe'
  )
);

-- Afficher les dates de passage de Guillaume (pour emprunté un livre).
-- Requete imbriquee
SELECT date_sortie, date_rendu FROM emprunt WHERE id_abonne = (
  SELECT id_abonne FROM abonne WHERE prenom = 'Guillaume'
);

-- Jointure
SELECT x.prenom, e.date_sortie, e.date_rendu
FROM abonne x, emprunt e
WHERE x.id_abonne = e.id_abonne
AND x.prenom = 'Guillaume' ;

-- SELECT - ce qu'on souhaite afficher
-- FROM - de quelles tables j'ai besoin ?
-- WHERE - condition avec la colonne en commun entre les deux tables à joindre.
-- AND - condition(s) complémentaire(s)...

-- Différence entre req. imbriquee et jointure :
  -- la req. imbriquee permet d'effectuer des relations entre plusieurs tables et de produire un résultat avec des colonnes issue d'une seule table.
  -- la jointure permet également d'effectuer des relations entre plusieurs tables et de produire un résultat avec des colonnes issue d'une seule table ou de plusieurs tables différentes (pour avoir une composition de colonnes).
  
-- Afficher les dates de sortie et de rendu pour les livres écrit par Alphonse Daudet ?
SELECT l.auteur, e.date_sortie, e.date_rendu
FROM emprunt e, livre l
WHERE e.id_livre = l.id_livre
AND l.auteur = 'Alphonse Daudet' ;

-----------------------------------------------

-- 1 -- Qui a emprunté le livre Une Vie sur l'année 2014 ? (résultat : prenom)
SELECT a.prenom, c.titre, b.date_sortie
FROM abonne a, emprunt b, livre c
WHERE b.id_abonne = a.id_abonne
AND b.id_livre = c.id_livre
AND c.titre = 'Une Vie'
AND b.date_sortie BETWEEN '2014-01-01' AND '2014-12-31' ;

-- 2 -- Afficher le nombre de livre emprunté par chaque abonné (résultat : prenom + nombre)
SELECT a.prenom, COUNT(e.id_livre)
FROM emprunt e, abonne a
WHERE a.id_abonne = e.id_abonne
GROUP BY a.prenom ;

-- 3 -- Afficher le nombre de livre a rendre pour chaque abonné (résultat : prenom + nombre)
SELECT a.prenom, COUNT(e.id_livre)
FROM emprunt e, abonne a
WHERE a.id_abonne = e.id_abonne
AND e.date_rendu IS NULL
GROUP BY a.prenom ;

-- 4 -- Qui a emprunté Quoi et Quand ? (résultat : qui=prenom, quoi=titre, quand=date_sortie)
SELECT a.prenom, l.titre, e.date_sortie
FROM abonne a, emprunt e, livre l
WHERE a.id_abonne = e.id_abonne
AND e.id_livre = l.id_livre ;

-- 5 -- Qui a emprunté quoi (résultat : prenom + id_livre).
SELECT a.prenom, e.id_livre
FROM abonne a, emprunt e
WHERE a.id_abonne = e.id_abonne ;

-----------------------------------------------
-----------------------------------------------

INSERT INTO abonne (prenom) VALUES ('votre prenom');

SELECT * FROM abonne ;

-- JOINTURE EXTERNE.
SELECT a.prenom, e.id_livre
FROM abonne a LEFT JOIN emprunt e
ON a.id_abonne = e.id_abonne ;

-- membre
-- id_membre      prenom
    -- 1         Julien
    -- 3         Alex

-- commande
-- id_commande   id_membre   id_produit    date
    -- 705         NULL          1           2014
    -- 709         1             1           2014
    -- 713         NULL          3           2015

-- produit
-- id_produit    titre        prix
     -- 1         Tshirt      15
     -- 2         pull        80
     -- 3         chemise     70

SELECT id_emprunt, id_livre, id_abonne, DATE_FORMAT(date_sortie, '%d/%m/%Y') AS 'date de sortie', DATE_FORMAT(date_rendu, '%d/%m/%Y') AS 'date de rendu' FROM emprunt;
-- DATE_FORMAT permet d'afficher la date au format de son choix.

SELECT auteur FROM livre UNION SELECT prenom FROM abonne ;
-- UNION permet de fusionner 2 résultats en 1 seul.

SELECT CONCAT(id_abonne, ' ', prenom) FROM abonne ;
-- CONCAT permet de concaténer. fusion de 2 colonnes en 1 seule.

















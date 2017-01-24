SHOW DATABASES ;
-- Voir les bases de données.

CREATE DATABASE diw27_entreprise ;
-- Créer une base de données.

SHOW DATABASES ;
-- Voir les bases de données.

USE diw27_entreprise ;
-- Utilise la base de données diw27_entreprise.

DESC employes ;
-- Description de la table employes.

SELECT * FROM employes ;
-- Affiche-moi toutes les colonnes de la table employes.

SELECT nom, prenom FROM employes ;
-- Affiche-moi (SELECT) la colonne nom (nom) suivi de (,) la colonne prenom (prenom) dans la table (FROM) employes (employes).

SELECT nom, prenom, service FROM employes WHERE service = 'informatique' ;
-- Affiche-moi (SELECT) la colonne nom (nom) suivi de (,) la colonne prenom (prenom) suivi de (,) la colonne service (service) dans la table (FROM) employes (employes) à condition que (WHERE) le service soit (=) informatique (informatique). 
-- WHERE = à condition que.

SELECT service FROM employes ;
-- Afficher la liste des services.

SELECT DISTINCT(service) FROM employes ;
-- DISTINCT permet d'éliminer les doublons.

SELECT prenom, nom, date_embauche FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND '2016-12-09' ;
-- Liste des employés recrutés entre le 01/01/2010 et le 09/12/2016.

SELECT CURDATE();
-- Affiche la date du jour.

SELECT prenom, nom, date_embauche FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND CURDATE() ;

SELECT prenom FROM employes WHERE prenom LIKE 's%';
SELECT prenom FROM employes WHERE prenom LIKE '%s';
SELECT prenom FROM employes WHERE prenom LIKE '%s%';
-- LIKE : valeur approchante.

SELECT nom, prenom, service FROM employes WHERE service != 'informatique';
-- != différent de...

SELECT nom, prenom, service, salaire FROM employes WHERE salaire > 3000 ;
-- Afficher la liste des employés gagnant un salaire supérieur a 3000 €
-- > strictement supérieur.

SELECT prenom FROM employes ORDER BY prenom ASC ;
-- Classement (ORDER BY)
-- ASC ascendant croissant.
-- DESC descendant décroissant.

SELECT id_employes, prenom FROM employes LIMIT 0,3 ;
SELECT id_employes, prenom FROM employes LIMIT 3,3 ;
SELECT id_employes, prenom FROM employes LIMIT 6,3 ;
-- LIMIT permet de limiter les résultats.

SELECT prenom, (salaire*12) AS 'salaire annuel' FROM employes ;
-- salaire*12 = salaire annuel.
-- AS est un alias.

SELECT SUM(salaire*12) FROM employes ;
-- Somme des salaires payés sur 12 mois.

SELECT AVG(salaire) FROM employes ;
-- Moyenne des salaires. (AVG).

SELECT ROUND(AVG(salaire)) FROM employes ;
SELECT ROUND(AVG(salaire),2) FROM employes ;
-- Round permet d'arrondir

SELECT COUNT(prenom) FROM employes WHERE sexe = 'f';
-- COUNT permet de compter.

SELECT MIN(salaire) FROM employes ;
-- MIN = minimum, MAX = maximum.

SELECT prenom, MIN(salaire) FROM employes ;
-- /!\ résultat incohérent ou une erreur.
SELECT prenom, salaire FROM employes WHERE salaire = (SELECT MIN(salaire) FROM employes) ;

SELECT prenom, service FROM employes WHERE service IN('informatique', 'comptabilite');
-- IN permet d'inclure plusieurs valeurs.
-- = permet d'inclure 1 seule valeur.

SELECT prenom, service FROM employes WHERE service NOT IN('informatique', 'comptabilite');
-- NOT IN permet d'exclure plusieurs valeurs.
-- != permet d'exclure 1 seule valeur.

SELECT nom, prenom, salaire, service FROM employes WHERE service = "commercial" AND salaire <= 2000 ;
-- AND = et
-- OR = ou

SELECT service, COUNT(prenom) AS 'nombre' FROM employes GROUP BY service ;
-- GROUP BY permet d'effectuer un regroupement.
-- Afficher la liste des services avec le nombre de personne qui y travaille.

SELECT service, COUNT(prenom) AS 'nombre' FROM employes GROUP BY service HAVING COUNT(prenom) > 1;
-- HAVING permet d'effectuer une condition sur les groupes.

-- https://dev.mysql.com/doc/refman/5.7/en/func-op-summary-ref.html

-- SELECT
--------------------------------------------------------------------
-- INSERT
INSERT INTO employes (prenom, nom, sexe, service, date_embauche, salaire) VALUES ('votre prenom', 'votre nom', 'm', 'web', '2016-12-09', 1000);
-- INSERT INTO permet d'ajouter des données.
-- VALUES permet de préciser les valeurs.

INSERT INTO employes VALUES ('', 'votre prenom', 'votre nom', 'm', 'web', '2016-12-09', 1000);
-- '' apostrophes vide pour laisser mysql générer l'id en auto incrément

INSERT INTO employes VALUES (NULL, 'votre prenom', 'votre nom', 'm', 'web', '2016-12-09', 1000);
-- NULL pour laisser mysql générer l'id en auto incrément

SELECT * FROM employes ;
------------------------------------------------------------
-- UPDATE
SELECT * FROM employes ;

UPDATE employes SET salaire = 1391 WHERE id_employes = 699 ;
-- UPDATE permet de mettre à jour.

SELECT * FROM employes ;
------------------------------------------------------------
-- DELETE
SELECT * FROM employes ;

DELETE FROM employes WHERE id_employes = 699 ;

SELECT * FROM employes ;
------------------------------------------------------------
-- 1 -- Afficher la profession de l'employé 547
-- 2 -- Afficher la date d'embauche d'Amandine
-- 3 -- Afficher le nom de famille de Guillaume
-- 4 -- Afficher le nombre de personne ayant un n° d'id_employes commençant par le chiffre 5
-- 5 -- Afficher le nombre de commerciaux
-- 6 -- Afficher le salaire moyen des informaticiens (+arrondir)
-- 7 -- Afficher les 5 premiers employés après avoir classé leur nom de famille par ordre alphabétique
-- 8 -- Afficher le coût des commerciaux sur 1 année
-- 9 -- Afficher le salaire moyen par service
-- 10 -- Afficher le nombre de recrutement sur l'année 2010
-- 11 -- Afficher le salaire moyen appliqué lors des recrutements sur la période allant de 2005 a 2007
-- 12 -- Afficher le nombre de service différent
-- 13 -- Afficher tous les employés (sauf ceux du service production et secretariat)
-- 14 -- Afficher conjoitement le nombre d'homme et de femme
-- 15 -- Afficher les commerciaux ayant été recrutés avant 2005 de sexe masculin et gagnant un salaire supérieur a 2 500 €
-- 16 -- Afficher l'(ou les) employé(s) ayant été embauché en dernier
-- 17 -- Afficher les informations sur l'(ou les) employé(s) du service commercial gagnant le salaire le plus élevé
-- 18 -- Afficher le prénom de l'(ou les) employé(s) du service informatique ayant été recruté en premier
-- 19 -- Augmenter chaque employé de 100 €
-- 19 -- Supprimer les employés du service secretariat







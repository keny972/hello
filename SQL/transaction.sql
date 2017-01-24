-- TRANSACTION --
USE diw27_entreprise ;

START TRANSACTION ;

SELECT * FROM employes ;

UPDATE employes SET salaire = 1000 ;

SELECT * FROM employes ;

ROLLBACK ; -- ROLLBACK annule et TERMINE la transaction.
COMMIT ; -- COMMIT valide et TERMINE la transaction.

SELECT * FROM employes ;
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- TRANSACTION & SAVEPOINT --
START TRANSACTION ;

SELECT * FROM employes ;
SAVEPOINT point1 ;

UPDATE employes SET salaire = 4000 WHERE id_employes = 350 ;
SELECT * FROM employes ;
SAVEPOINT point2 ;

UPDATE employes SET salaire = 3000 WHERE id_employes = 350 ;
SELECT * FROM employes ;
SAVEPOINT point3 ;

UPDATE employes SET salaire = 2000 WHERE id_employes = 350 ;
SELECT * FROM employes ;
SAVEPOINT point4 ;

UPDATE employes SET salaire = 1000 WHERE id_employes = 350 ;
SELECT * FROM employes ;
SAVEPOINT point5 ;

ROLLBACK TO point3 ; -- retour sur un point particulier.
SELECT * FROM employes ;
ROLLBACK TO point4 ; -- /!\ erreur, pas possible d'aller dans le futur.

ROLLBACK TO point2 ; -- retour sur un point particulier.
SELECT * FROM employes ;

COMMIT ; -- valide et termine la transaction.






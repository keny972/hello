-- TABLE VIRTUELLE (VIEW)
CREATE VIEW vue_emprunt AS
  SELECT a.prenom, l.titre, e.date_sortie
  FROM abonne a, emprunt e, livre l
  WHERE a.id_abonne = e.id_abonne
  AND e.id_livre = l.id_livre ;
  
SHOW TABLES ;

SELECT * FROM vue_emprunt ;
-- DROP VIEW vue_emprunt ;

-- Une table virtuelle se construit à partir d'une requete.
-- Une table virtuelle est pratique pour isoler des résultats suite à une jointure complexe.

-----------------------------------------------------------------
-- TABLE TEMPORAIRE
CREATE TEMPORARY TABLE emprunt2014 AS SELECT * FROM emprunt WHERE date_sortie BETWEEN '2014-01-01' AND '2014-12-31' ;

SHOW TABLES ;

SELECT * FROM emprunt2014 ;

-- Une table temporaire a une durée de vie très courte (dès la fermeture de la console, elle est supprimé).
-- Une table temporaire est une copie des données à un moment clé.
-- Une table temporaire permet d'isoler des résultats pour travailler dessus.





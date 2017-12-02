-- CONSULTATIONS --

-- Liste des foyers ayant souscrits à un contrat donné

CREATE OR REPLACE FUNCTION liste_foyers_contrat (id_contrat INTEGER)
RETURNS TABLE(id_foyer INTEGER) STABLE AS
$$
  SELECT id_foyer FROM souscrire_a WHERE id_contrat=$1;
$$ LANGUAGE SQL;


-- Liste des livraisons prévues à un mois

CREATE OR REPLACE FUNCTION liste_livraisons_mois (mois INTEGER)
RETURNS TABLE(id_livraison INTEGER) STABLE AS
$$
SELECT id_livraison FROM livraison WHERE EXTRACT( month FROM date_livraison)=$1;
$$ LANGUAGE SQL;


-- Liste des livraisons pour lesquelles personne n'est inscrit

CREATE OR REPLACE FUNCTION liste_livraisons_sans_inscriptions ()
RETURNS TABLE(id_livraison INTEGER) STABLE AS
$$
SELECT id_livraison FROM livraison WHERE id_foyer IS NULL;
$$ LANGUAGE SQL;


-- Calendrier des livraisons de l'ensemble des contrats d'un adhérent donné

CREATE OR REPLACE FUNCTION calendrier_livraisons_contrats_adherent(id_adherent INTEGER)
RETURNS TABLE(id_contrat INTEGER, date_livraison DATE) STABLE AS
$$
SELECT sa.id_contrat, date_livraison FROM souscrire_a sa
JOIN foyer USING (id_foyer)
JOIN livraison USING (id_foyer)
JOIN appartenir_a USING (id_foyer)
JOIN client USING (id_client)
WHERE id_client=$1
ORDER BY date_livraison ASC
$$ LANGUAGE SQL;

-- Calendrier des livraisons de l'ensemble des contrats d'un foyer donné

CREATE OR REPLACE FUNCTION calendrier_livraisons_contrats_foyer(id_foyer INTEGER)
RETURNS TABLE(id_contrat INTEGER, date_livraison DATE) STABLE AS
$$
SELECT sa.id_contrat, date_livraison FROM souscrire_a sa
JOIN foyer f USING (id_foyer)
JOIN livraison USING (id_foyer)
WHERE f.id_foyer=$1
ORDER BY date_livraison ASC
$$ LANGUAGE SQL;

-- STATISTIQUES --

-- Liste des foyers, avec pour chaque foyer, son nombre de participations à des distributions pour une année donnée

CREATE OR REPLACE FUNCTION nombre_participations_annee(annee INTEGER)
RETURNS TABLE(id_foyer INTEGER, n_participations BIGINT) STABLE AS
$$
SELECT f.id_foyer, COUNT(DISTINCT id_livraison) AS n_participations FROM foyer f
JOIN livraison USING (id_foyer)
wHERE EXTRACT(year FROM date_livraison)=$1
GROUP BY f.id_foyer
ORDER BY n_participations DESC
$$ LANGUAGE SQL;

-- Somme des montants des tous les contrats souscrits pour chaque foyer

CREATE OR REPLACE FUNCTION somme_montants_contrats_foyer()
RETURNS TABLE(id_foyer INTEGER, somme_contrats BIGINT) STABLE AS
$$
SELECT f.id_foyer, SUM(prix_total) AS somme FROM foyer f
JOIN souscrire_a USING (id_foyer)
JOIN contrat USING (id_contrat)
GROUP BY f.id_foyer
ORDER BY somme DESC
$$ LANGUAGE SQL;

-- Somme des montants des tous les contrats souscrits pour chaque adhérent

CREATE OR REPLACE FUNCTION somme_montants_contrats_adherent()
RETURNS TABLE(id_adherent INTEGER, somme_contrats BIGINT) STABLE AS
$$
SELECT id_client, SUM(prix_total) AS somme FROM foyer f
JOIN souscrire_a USING (id_foyer)
JOIN contrat USING (id_contrat)
JOIN appartenir_a USING (id_foyer)
JOIN client USING (id_client)
GROUP BY id_client
ORDER BY somme DESC
$$ LANGUAGE SQL;

-- Prix moyen du panier pour chaque contrat

CREATE OR REPLACE FUNCTION prix_moyen_panier()
RETURNS TABLE(id_contrat INTEGER, prix_moyen INTEGER) STABLE AS
$$
SELECT id_contrat, prix_total/quantité AS prix_moyen FROM contrat
JOIN prevision_calendrier USING (id_contrat)
GROUP BY id_contrat, prix_moyen
ORDER BY prix_moyen DESC
$$ LANGUAGE SQL;

-- Revenu moyen par mois pour chaque producteur, pour une année donnée

CREATE OR REPLACE FUNCTION revenu_moyen_mensuel()	
RETURNS TABLE(id_producteur INTEGER, revenu_moyen BIGINT) STABLE AS
$$
SELECT p.id_producteur, SUM(prix_total*nb_souscriptions)/12 AS revenu_moyen FROM producteur p
JOIN contrat USING (id_producteur)
JOIN souscrire_a USING (id_contrat)
JOIN foyer USING (id_foyer)
GROUP BY p.id_producteur
ORDER BY revenu_moyen DESC 
$$ LANGUAGE SQL;
-- Tests des fonctions --

SELECT liste_foyers_contrat(2);
SELECT liste_livraisons_mois(11);
SELECT liste_livraisons_sans_inscriptions();
SELECT calendrier_livraisons_contrats_adherent(1);
SELECT calendrier_livraisons_contrats_foyer(1);
SELECT nombre_participations_annee(2017);
SELECT somme_montants_contrats_foyer();
SELECT somme_montants_contrats_adherent();
SELECT prix_moyen_panier();
SELECT revenu_moyen_mensuel();

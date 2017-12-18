DROP FUNCTION liste_foyers_contrat (id_contrat INTEGER);
DROP FUNCTION liste_livraisons_mois (mois INTEGER);
DROP FUNCTION liste_livraisons_sans_inscriptions ();
DROP FUNCTION calendrier_livraisons_contrats_adherent(id_adherent INTEGER);
DROP FUNCTION calendrier_livraisons_contrats_foyer(id_foyer INTEGER);
DROP FUNCTION nombre_participations_annee(annee INTEGER);
DROP FUNCTION somme_montants_contrats_foyer();
DROP FUNCTION somme_montants_contrats_adherent();
DROP FUNCTION prix_moyen_panier();
DROP FUNCTION revenu_moyen_mensuel();	
DROP FUNCTION max_id_adresse();
DROP FUNCTION max_id_denree();
DROP FUNCTION max_id_panier();
DROP FUNCTION max_id_livraison();
DROP FUNCTION max_id_client();
DROP FUNCTION max_id_foyer();
DROP FUNCTION max_id_contrat();
DROP FUNCTION max_id_producteur();
DROP FUNCTION ajout_adresse(id INTEGER, pays VARCHAR(50), ville VARCHAR(50), code_postal VARCHAR(50), numero_rue VARCHAR(50), rue VARCHAR(50));
DROP FUNCTION ajout_foyer(id INTEGER, id_adresse INTEGER, nom VARCHAR(50), description VARCHAR(1000), adresse_mail VARCHAR(50), telephone VARCHAR(50));
DROP FUNCTION ajout_client(id INTEGER, id_adresse INTEGER, nom VARCHAR(50), prenom VARCHAR(50), adresse_mail VARCHAR(50), telephone VARCHAR(50));
DROP FUNCTION supprime_adresse(id INTEGER);
DROP FUNCTION supprime_denree(id INTEGER);
DROP FUNCTION supprime_panier(id INTEGER);
DROP FUNCTION supprime_livraison(id INTEGER);
DROP FUNCTION supprime_client(id INTEGER);
DROP FUNCTION supprime_foyer(id INTEGER);
DROP FUNCTION supprime_contrat(id INTEGER);
DROP FUNCTION supprime_producteur(id INTEGER);
DROP FUNCTION supprimer_souscrire_a(id INTEGER, id_2 INTEGER);
DROP FUNCTION supprimer_contenir(id INTEGER, id_2 INTEGER);
DROP FUNCTION supprimer_appartenir_a(id INTEGER, id_2 INTEGER);
DROP FUNCTION supprimer_prevision_calendrier(id INTEGER, id_2 INTEGER, id_3 INTEGER);
DROP FUNCTION supprime_table_adresse();
DROP FUNCTION supprime_table_denree();
DROP FUNCTION supprime_table_panier();
DROP FUNCTION supprime_table_livraison();
DROP FUNCTION supprime_table _client();
DROP FUNCTION supprime_table_foyer();
DROP FUNCTION supprime_table_contrat();
DROP FUNCTION supprime_table_producteur();
DROP FUNCTION supprimer_table_souscrire_a();
DROP FUNCTION supprimer_table_contenir();
DROP FUNCTION supprimer_table_appartenir_a();
DROP FUNCTION supprimer_table_prevision_calendrier();

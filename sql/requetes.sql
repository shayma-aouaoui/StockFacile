-- Q1.5.1
SELECT * FROM produits;

-- Q1.5.2
SELECT * FROM produits
WHERE quantite = 0;

-- Q1.5.3
SELECT * FROM produits
ORDER BY prix DESC;

-- Q1.5.4
SELECT produits.nom AS produit, categories.nom AS categorie
FROM produits
INNER JOIN categories ON produits.categorie_id = categories.id;

-- Q1.5.5
SELECT categories.nom AS categorie, COUNT(produits.id) AS nombre_produits
FROM categories
LEFT JOIN produits ON produits.categorie_id = categories.id
GROUP BY categories.id, categories.nom;

-- Q1.5.6
SELECT COALESCE(SUM(prix * quantite), 0) AS valeur_totale_stock
FROM produits;

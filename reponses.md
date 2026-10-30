# Réponses — Q1.3

- **Stockage de `disponible` et de `date_ajout` :** SQLite n'a pas de type booléen natif. `disponible` est stocké comme un entier (`INTEGER`), avec `1` pour vrai et `0` pour faux. SQLite n'a pas non plus de type date/heure natif : `date_ajout` est stocké comme du texte (`TEXT`), ici au format ISO 8601.
- **`AUTOINCREMENT` :** attribue automatiquement un identifiant entier et empêche de réutiliser un identifiant déjà attribué à une ligne supprimée. Cela évite de réutiliser les anciens identifiants, au prix d'un léger surcoût.
- **`UNIQUE` sur `nom` :** interdit d'enregistrer deux catégories ayant le même nom.
- **`CHECK (prix >= 0)` :** impose que le prix soit positif ou égal à zéro; une insertion ou une mise à jour avec un prix négatif est rejetée.
- **`ON DELETE RESTRICT` :** empêche de supprimer une catégorie tant qu'au moins un produit y fait référence.

# Réponses — Q1.6

Les trois requêtes de test ont été exécutées séparément avec les clés étrangères activées. Les tentatives ont été annulées après chaque erreur afin de conserver les données de départ.

- **a) Prix négatif :** `CHECK constraint failed: prix >= 0`
- **b) Catégorie inexistante :** `FOREIGN KEY constraint failed`
- **c) Suppression d'une catégorie contenant des produits :** `FOREIGN KEY constraint failed` (la règle `ON DELETE RESTRICT` bloque la suppression)

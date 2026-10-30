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

# Réponses — Q3.2

- **(1) Si on écrit deux fois `DatabaseHelper()`, combien d'objets sont créés ?**
  Aucun objet supplémentaire n'est créé. Le code utilise un singleton : le constructeur est privé (`DatabaseHelper._interne()`) et le `factory` renvoie toujours la même instance stockée dans `_instance`. Autrement dit, `DatabaseHelper()` et `DatabaseHelper()` donnent la même instance unique dans toute l'application.

- **(2) Que fait l'opérateur `??=` ?**
  Il est l'équivalent de : « si la variable de gauche vaut `null`, donne-lui la valeur de droite ; sinon, laisse la valeur existante ». Ici, `_db ??= await _ouvrirBase();` signifie : si `_db` est `null`, on ouvre la base puis on la stocke ; sinon, on réutilise la connexion déjà ouverte.

- **(3) Pourquoi le `PRAGMA foreign_keys = ON` est-il dans `onConfigure` et non dans `onCreate` ?**
  Parce que `onConfigure` est appelé à chaque ouverture de la base, avant les autres étapes. Il garantit que la vérification des clés étrangères est activée pour toutes les connexions, même celles ouvertes ensuite. `onCreate` n'est exécuté qu'une seule fois, au tout premier lancement, donc il ne garantit pas l'état pour les futures ouvertures.

- **(4) Combien de fois `onCreate` est-il appelé dans toute la vie de l'application ?**
  Une seule fois, au premier démarrage de l'application, uniquement si le fichier SQLite n'existe pas encore. Ensuite, si la base existe déjà, SQLite ne réexécute pas `onCreate` ; il garde le schéma existant.

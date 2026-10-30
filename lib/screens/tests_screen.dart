import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../database/categorie_dao.dart';
import '../database/database_helper.dart';
import '../models/categorie.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tests SQLite')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () async {
              final db = await DatabaseHelper().database;
              final resultat =
                  await db.rawQuery('SELECT COUNT(*) AS nb FROM categories');
              debugPrint(
                'Nombre de catégories : ${resultat.first['nb']}',
              );
            },
            child: const Text('Ouvrir la base'),
          ),
          ElevatedButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.maybeOf(context);

              try {
                final id = await CategorieDao().insererCategorie(
                  const Categorie(
                    nom: 'Électroménager',
                    description: 'Petits appareils',
                  ),
                );
                debugPrint('Catégorie insérée avec l\'id $id');
              } on DatabaseException catch (e) {
                if (e.isUniqueConstraintError()) {
                  messenger?.showSnackBar(
                    const SnackBar(content: Text('Cette catégorie existe déjà')),
                  );
                } else {
                  debugPrint('Erreur SQLite : $e');
                }
              }
            },
            child: const Text('Test : ajouter une catégorie'),
          ),
        ],
      ),
    );
  }
}
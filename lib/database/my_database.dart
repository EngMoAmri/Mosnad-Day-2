import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static Database? myDatabase;

  static bool isInitialized() => myDatabase != null;

  static Future<Database> open() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    myDatabase = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'mosnad.db'),
      // When the database is first created, create tables.
      onCreate: (database, version) async {
        // here we made the store is and customer id as string coz this table can be used by customers and owners
        await database.execute("""
          CREATE TABLE IF NOT EXISTS services(
            id INTEGER NOT NULL, 
            name TEXT NOT NULL, 
            description TEXT NOT NULL, 
            price INTEGER NOT NULL, 
            days INTEGER NOT NULL,
            PRIMARY KEY(id)
            )
          """);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    return myDatabase!;
  }

  static Future close() async => MyDatabase.myDatabase!.close();
}
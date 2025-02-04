import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> initializeDatabase() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final directory = await getApplicationDocumentsDirectory();
  final dbPath = join(directory.path, 'Quality_parameters.db');

  if (!await File(dbPath).exists()) {
    File(dbPath).createSync();
  }

  final db = await openDatabase(
    dbPath,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE "Parameters" (
          "parameter" TEXT NOT NULL UNIQUE,
          "Unit" TEXT,
          "Ideal" INTEGER NOT NULL,
          "Standard" INTEGER NOT NULL,
          "Weight" INTEGER NOT NULL
        )
      ''');
    },
  );

  return db;
}


Future<void> addParameter(
    Database db,String table, String parameter, String unit, int ideal, int standard, int weight) async {
  try {
    await db.insert(
      table,
      {
        'parameter': parameter,
        'Unit': unit,
        'Ideal': ideal,
        'Standard': standard,
        'Weight': weight,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if the primary key conflicts
    );

  } catch (e) {

  }
}



Future<List<String>> getAllTables(Database db) async {
  try {
    // Query the sqlite_master table to get all table names
    final List<Map<String, dynamic>> tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table';",
    );

    // Extract the table names from the query result
    List<String> tableNames = tables.map((table) => table['name'] as String).toList();

    return tableNames;
  } catch (e) {
    print("Error retrieving tables: $e");
    return [];
  }
}


Future<List<String>> getAllTable() async {
  Database db=await initializeDatabase();
  try {
    // Query the sqlite_master table to get all table names
    final List<Map<String, dynamic>> tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table';",
    );

    // Extract the table names from the query result
    List<String> tableNames = tables.map((table) => table['name'] as String).toList();

    return tableNames;
  } catch (e) {
    print("Error retrieving tables: $e");
    return [];
  }
}


Future<void> addTable(Database db, String tableName, String createTableSql) async {
  try {
    // Execute the SQL command to create the table
    await db.execute(createTableSql);
    print("Table '$tableName' created successfully.");
  } catch (e) {
    print("Error creating table '$tableName': $e");
  }
}

Future<void> deleteTable(Database db, String tableName) async {
  try {
    // Execute the SQL command to drop the table
    await db.execute('DROP TABLE IF EXISTS "$tableName"');
    print("Table '$tableName' deleted successfully.");
  } catch (e) {
    print("Error deleting table '$tableName': $e");
  }
}


Future<void> deleteEntry(Database db, String tableName, String name) async {
  try {
    // SQL command to delete a row where the 'name' column matches the provided value
    await db.delete(
      tableName,
      where: 'parameter = ?',
      whereArgs: [name],
    );
    print("Entry with name '$name' deleted successfully.");
  } catch (e) {
    print("Error deleting entry: $e");
  }
}



Future<void> updateEntry(Database db, String tableName, String name, Map<String, dynamic> updatedValues) async {
  try {
    // SQL command to update the row where the 'name' column matches the provided value
    await db.update(
      tableName,
      updatedValues,
      where: 'parameter = ?',
      whereArgs: [name],
    );
    print("Entry with name '$name' updated successfully.");
  } catch (e) {
    print("Error updating entry: $e");
  }
}




Future<Map<String, dynamic>?> getEntry(Database db, String tableName, String name) async {
  try {
    // SQL query to retrieve the row where the 'name' column matches the provided value
    List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: 'parameter = ?',
      whereArgs: [name],
    );

    if (result.isNotEmpty) {
      return result.first; // Return the first matching entry
    } else {
      print("Entry with name '$name' not found.");
      return null;
    }
  } catch (e) {
    print("Error retrieving entry: $e");
    return null;
  }
}




Future<List<Map<String, dynamic>>> getAllItems(Database db, String tableName) async {
  try {
    // SQL query to fetch all items from the specified table
    List<Map<String, dynamic>> result = await db.query(tableName);

    if (result.isNotEmpty) {
      return result; // Return all items in the table
    } else {
      print("No items found in the table '$tableName'.");
      return [];
    }
  } catch (e) {
    print("Error retrieving items from '$tableName': $e");
    return [];
  }
}




Future<List<Map<String, dynamic>>> getAllparameters(Database db, String tableName) async {
  try {
    // SQL query to fetch all items from the specified table
    List<Map<String, dynamic>> result = await db.query(
      "$tableName", // Table name
      columns: ['parameter'], // Specify only the 'name' column
    );

    if (result.isNotEmpty) {
      return result; // Return all items in the table
    } else {
      print("No items found in the table '$tableName'.");
      return [];
    }
  } catch (e) {
    print("Error retrieving items from '$tableName': $e");
    return [];
  }
}

void add_input()async{
  Database db=await initializeDatabase();
  try {
    // SQL query to fetch all items from the specified table
    List<Map<String, dynamic>> result = await db.query(
      "Parameters", // Table name
      columns: ['parameter'], // Specify only the 'name' column
    );

    if (result.isEmpty) {
      db.execute('''
      INSERT INTO "Parameters" ("parameter", "Unit", "Ideal", "Standard", "Weight") VALUES
('Alkalinity', 'mg/L', 0.0, 500, 2),
('Ammonia (NH3)', 'mg/L', 0.0, 0.5, 4),
('Antimony (Sb)', 'mg/L', 0.0, 0.006, 3),
('Arsenic (As)', 'mg/L', 0.0, 0.01, 5),
('Benzene', 'mg/L', 0.0, 0.005, 5),
('Beryllium (Be)', 'mg/L', 0.0, 0.004, 3),
('Chloride (Cl-)', 'mg/L', 0.0, 200, 3),
('Chlorobenzene', 'mg/L', 0.0, 0.1, 4),
('Conductivity', 'uS/cm2', 0.0, 2150, 2),
('Copper (Cu)', 'mg/L', 0.0, 1.0, 2),
('Cyanide (CN-)', 'mg/L', 0.0, 0.07, 5),
('Dissolved Oxygen (DO)', 'mg/L', 14.6, 10.0, 3),
('Ethylbenzene', 'mg/L', 0.0, 0.7, 3),
('Electrical Conductivity (EC)', 'mg/L', 0.0, 2150, 2),
('Fluoride (F-)', 'mg/L', 0.0, 1.5, 4),
('Hardness', 'mg/L', 0.0, 500, 3),
('Iron (Fe)', 'mg/L', 0.0, 0.3, 3),
('Lead (Pb)', 'mg/L', 0.0, 0.001, 5),
('Manganese (Mn)', 'mg/L', 0.0, 0.05, 2),
('Mercury (Hg)', 'mg/L', 0.0, 0.006, 5),
('Nitrate (NO3-)', 'mg/L', 0.0, 50, 4),
('Nitrite (NO2-)', 'mg/L', 0.0, 0.2, 4),
('pH', '-', 7.0, 8.5, 3),
('Selenium (Se)', 'mg/L', 0.0, 0.05, 2),
('Silver (Ag)', 'mg/L', 0.0, 0.1, 3),
('Styrene', 'mg/L', 0.0, 0.1, 3),
('Sulfate (SO42-)', 'mg/L', 0.0, 200, 2),
('Tetrachloroethylene', 'mg/L', 0.0, 0.005, 5),
('Thallium (Tl)', 'mg/L', 0.0, 0.002, 5),
('Toluene', 'mg/L', 0.0, 1.0, 4),
('Total Coliforms', 'CFU/ml', 0.0, 0.001, 3),
('Total Dissolved Solids (TDS)', 'mg/L', 0.0, 1000, 3),
('Total Suspended Solids', 'mg/L', 0.0, 250, 3),
('Trichloroethylene', 'mg/L', 0.0, 0.005, 4),
('Turbidity', 'NTU', 0.0, 5, 3),
('Xylenes (Total)', 'mg/L', 0.0, 10, 3),
('Zinc (Zn)', 'mg/L', 0.0, 5, 3),
('Fecal Coliforms', 'CFU/ml', 0.0, 0.001, 5),
('Escherichia coli (E.coli)', 'CFU/ml', 0.0, 0.001, 5);

      
      ''');// Return all items in the table
    }
  } catch (e) {
    print("Error retrieving items from 'Parameters': $e");

  }
}
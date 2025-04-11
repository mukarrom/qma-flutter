import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbHelper {
  static const String DB_NAME = 'qms.db';
  static const String CATEGORY_TABLE_NAME = 'categories';
  static const String CATEGORY_COLUMN_ID = 'id';
  static const String CATEGORY_COLUMN_NAME = 'name';
  static const String CATEGORY_COLUMN_IMAGE = 'image';
  static const String CATEGORY_COLUMN_TOTAL_PRODUCTS = 'total_products';
  static const String CATEGORY_COLUMN_IS_DELETED = 'is_deleted';
  static const String CATEGORY_COLUMN_CREATED_AT = 'created_at';
  static const String CATEGORY_COLUMN_UPDATED_AT = 'updated_at';

  /// A private constructor because this class is not meant to be instantiated or extended; this constructor ensures that instances of this class can only be obtained by calling the singleton getter `DatabaseHelper.instance` defined below.
  DbHelper._(); // Private constructor
  static final DbHelper _instance = DbHelper._(); // Singleton instance
  static DbHelper get instance => _instance; // Singleton getter

  Database? _database; // Database instance

  /// Initializes the database and returns it as a Future.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initializes the database.
  Future<Database> _initDatabase() async {
    /// check the platform
    if (Platform.isAndroid || Platform.isIOS) {
      // Mobile: Use sqflite
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'qms.db');
      return await openDatabase(path, version: 1, onCreate: _onCreate);
    } else {
      // Desktop (Windows/macOS/Linux): Use sqflite_common_ffi
      sqfliteFfiInit(); // Initialize FFI
      final dbFactory = databaseFactoryFfi;
      final path = join(
          Directory.current.path, 'qms.db'); // Save DB in the current directory
      return await dbFactory.openDatabase(path,
          options: OpenDatabaseOptions(version: 1, onCreate: _onCreate));
    }
  }

  /// Creates the database schema.
  Future<void> _onCreate(Database db, int version) async {
    // Create your tables here
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $CATEGORY_TABLE_NAME (
        $CATEGORY_COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $CATEGORY_COLUMN_NAME TEXT,
        $CATEGORY_COLUMN_IMAGE TEXT,
        $CATEGORY_COLUMN_TOTAL_PRODUCTS INTEGER DEFAULT 0,
        $CATEGORY_COLUMN_IS_DELETED BOOLEAN DEFAULT 0,
        $CATEGORY_COLUMN_CREATED_AT DATETIME DEFAULT CURRENT_TIMESTAMP,
        $CATEGORY_COLUMN_UPDATED_AT DATETIME DEFAULT CURRENT_TIMESTAMP
      )
  ''');
  }
}

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   Database? _database;
//   DatabaseHelper._internal();
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//   Future<Database> _initDatabase() async {
//     /// Check the platform
//     if (Platform.isAndroid || Platform.isIOS) {
//       // Mobile: Use sqflite
//       final dbPath = await getDatabasesPath();
//       final path = join(dbPath, 'qms.db');
//       return await openDatabase(path, version: 1, onCreate: _onCreate);
//     } else {
//       // Desktop (Windows/macOS/Linux): Use sqflite_common_ffi
//       sqfliteFfiInit(); // Initialize FFI
//       final dbFactory = databaseFactoryFfi;
//       final path = join(
//           Directory.current.path, 'qms.db'); // Save DB in the current directory
//       return await dbFactory.openDatabase(path,
//           options: OpenDatabaseOptions(version: 1, onCreate: _onCreate));
//     }
//   }
//   Future<void> _onCreate(Database db, int version) async {
//     // Create your tables here
//     await db.execute('''
//       CREATE TABLE IF NOT EXISTS category_table (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         image TEXT,
//         totalProducts INTEGER,
//         isDeleted BOOLEAN,
//         createdAt TIMESTAMP,
//         updatedAt TIMESTAMP,
//       );
//     ''');
//     await db.execute('''
//       CREATE TABLE IF NOT EXISTS qms_table (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         description TEXT
//       )
//     ''');
//   }
// }

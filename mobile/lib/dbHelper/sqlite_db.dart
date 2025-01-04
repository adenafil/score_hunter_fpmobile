import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // Nama database
  final String _databaseName = 'auth_token.db';
  // Versi database
  final int _databaseVersion = 1;
  // Nama tabel
  final String table = 'token_table';
  // Kolom tabel
  final String columnId = 'id';
  final String columnToken = 'token';

  // Named constructor
  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  // Inisialisasi database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Membuat database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    print("path: ${path}");
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Membuat tabel
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnToken TEXT NOT NULL
      )
    ''');
  }

  // Method untuk menyimpan token
  Future<int> saveToken(String token) async {
    print("saving");
    Database db = await database;

    // Hapus token yang ada (jika ada)
    await db.delete(table);

    // Insert token baru
    Map<String, dynamic> row = {
      columnToken: token,
    };
    return await db.insert(table, row);
  }

  // Method untuk menghapus token
  Future<int> deleteToken() async {
    Database db = await database;
    return await db.delete(table);
  }

  // Method tambahan untuk mengambil token (jika diperlukan)
  Future<String> getToken() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(table);

    if (maps.isNotEmpty) {
      return maps.first[columnToken];
    }
    return "";
  }
}
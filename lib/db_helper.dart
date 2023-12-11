import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as pth;
import 'dart:async';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = pth.join(databasesPath, 'user.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE user (id INTEGER PRIMARY KEY, username TEXT, password TEXT, phone TEXT, email TEXT, address TEXT)');
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    return await dbClient.insert('user', user.toMap());
  }

  Future<List<User>> getUsers() async {
    var dbClient = await db;
    List<Map<String, dynamic>> users = await dbClient.query('user');
    return users.map((user) => User.fromMap(user)).toList();
  }

  Future<void> test_read(String db_name) async {
    var databasesPath = await getDatabasesPath();
    String path = pth.join(databasesPath, db_name);

    Database database = await openDatabase(path, version: 1);

    List<Map> list = await database.rawQuery('SELECT * FROM user');
    print(list);
  }
}

class User {
  int? id;
  String username;
  String password;
  String phone;
  String email;
  String address;

  User(this.id, this.username, this.password, this.phone, this.email,
      this.address);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
      'phone': phone,
      'email': email,
      'address': address
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        password = map['password'],
        phone = map['phone'],
        email = map['email'],
        address = map['address'];
}

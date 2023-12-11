import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'registration_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DBHelper _dbHelper = DBHelper();
  late Future<List<User>> _users;

  @override
  void initState() {
    super.initState();
    _users = _getUsers();
  }

  Future<List<User>> _getUsers() async {
    final db = await _dbHelper.db;
    List<Map<String, dynamic>> users = await db.rawQuery('SELECT * FROM user');
    return users.map((user) => User.fromMap(user)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      body: FutureBuilder<List<User>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];
                return ListTile(
                  title: Text('Username: ${user.username}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone: ${user.phone}'),
                      Text('Email: ${user.email}'),
                      Text('Address: ${user.address}'),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

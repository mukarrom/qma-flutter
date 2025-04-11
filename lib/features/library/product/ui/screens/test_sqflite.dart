import 'package:flutter/material.dart';
import 'package:qma/services/db/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class TestSqflite extends StatefulWidget {
  const TestSqflite({super.key});

  @override
  State<TestSqflite> createState() => _TestSqfliteState();
}

class _TestSqfliteState extends State<TestSqflite> {
  final dbHelper = DbHelper.instance;

  Future<void> _insertData() async {
    final db = await dbHelper.database;
    await db.insert(
      DbHelper.CATEGORY_TABLE_NAME,
      {
        DbHelper.CATEGORY_COLUMN_NAME: 'Test 1',
        DbHelper.CATEGORY_COLUMN_IMAGE: 'https://via.placeholder.com/150',
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    setState(() {});
  }

  Future<List<Map<String, Object?>>> _getData() async {
    final db = await dbHelper.database;
    return await db.query(DbHelper.CATEGORY_TABLE_NAME);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _insertData,
          child: const Text('Insert Data'),
        ),
        Expanded(
          child: FutureBuilder<List<Map<String, Object?>>>(
            future: _getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data found'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return ListTile(
                      leading: const Icon(Icons.category_outlined),
                      title:
                          Text(item[DbHelper.CATEGORY_COLUMN_NAME].toString()),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

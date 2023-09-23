import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_app_db/model/student.dart';

class DbHlper {
  DbHlper._();

  static final DbHlper dbHlper = DbHlper._();

  Database? database;

  Future<void> create_datebase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "stud.db");

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String qure =
            "CREATE TABLE IF NOT EXISTS student(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTEGER,couser TEXT,image BLOB);";

        await db.execute(qure);
      },
    );
  }

  Future<int> insert_recode(
      {required String name,
      required int age,
      required String couser,
      required Uint8List image}) async {
    create_datebase();

    String quer = "INSERT INTO student(name,age,couser,image) VALUES(?,?,?,?);";
    List res = [name, age, couser, image];
    int i = await database!.rawInsert(quer, res);
    print(i);

    return i;
  }

  Future<List<Student>> fechatAll_recode() async {
    create_datebase();
    String qure = "SELECT * FROM student;";

    List<Map<String, Object?>> data = await database!.rawQuery(qure);

    List<Student> k = data
        .map(
          (e) => Student.fromMap(data: e),
        )
        .toList();

    return k;
  }

  Future<int> UpdateRecode(
      {required String name,
      required int age,
      required String couser,
      required int id,
      required Uint8List image}) async {
    create_datebase();
    String qure =
        "UPDATE student SET name =?,age = ? , couser = ?, image = ? WHERE id = ?;";

    List res = [
      name,
      age,
      couser,
      image,
      id,
    ];

    int k = await database!.rawUpdate(qure, res);

    return k;
  }

  Future<int> Deletesp(int id) async {
    create_datebase();

    String qure = "DELETE FROM student WHERE id = ?;";
    int k = await database!.rawDelete(qure, [id]);

    return k;
  }
}

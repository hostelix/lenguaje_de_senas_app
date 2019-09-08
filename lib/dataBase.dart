import 'package:lenguaje_de_senas_app/Model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io'as io;


class DBLenguajeSenas{

  final String tableName = "Users";

  static Database dbInstance;

  Future<Database> get db async{
    if(dbInstance == null)
      dbInstance = await initDB();

    return dbInstance;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "LenguajeSenas.db");

    var db = await openDatabase(path, version: 1, onCreate: onCreateFunc);

    return db;
  }


  void onCreateFunc (Database db, int version) async{
    //create table
    await db.execute('CREATE TABLE $tableName (idUsers INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(30));');
  }

  /*
    CRUD FUNCTION
  */

  // Get User
  Future<List<User>> getUsers() async{
    var dbConnection = await db;

    List<Map> list = await dbConnection.rawQuery('SELECT * FROM $tableName');
    List<User> users = new List();

    for(int i = 0; i< list.length; i++)
    {
      User user = new User();
      user.idUser = list[i]['idUsers'];
      user.nameUser =  list[i]['nameUsers'];

      users.add(user);
    }

    return users;
  }


  // Add New User
  void addNewUser (User user) async{
    var dbConnection = await db;
    String query = 'INSERT INTO $tableName (nameUsers) VALUE (\'${user.nameUser}\')';
    await dbConnection.transaction((transaction) async{
      return await transaction.rawInsert(query);
    });
  }


  // Update User
  void updateUser (User user) async{
    var dbConnection = await db;
    String query = 'UPDATE $tableName SET nameUsers=\'${user.nameUser}\' WHERE idUsers=${user.idUser}';
    await dbConnection.transaction((transaction) async{
      return await transaction.rawQuery(query);
    });
  }


  // Delete User
  void deleteUser (User user) async{
    var dbConnection = await db;
    String query = 'DELETE FROM $tableName  WHERE idUsers=${user.idUser}';
    await dbConnection.transaction((transaction) async{
      return await transaction.rawQuery(query);
    });
  }
}
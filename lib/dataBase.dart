import 'package:lenguaje_de_senas_app/Model/category.dart';
import 'package:lenguaje_de_senas_app/Model/user.dart';
import 'package:lenguaje_de_senas_app/Model/detailCategory.dart';
import 'package:lenguaje_de_senas_app/Model/achievements.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io'as io;


class DBLenguajeSenas{

  static Database dbInstance;

  Future<Database> get db async{
    if(dbInstance == null)
      dbInstance = await initDB();

    return dbInstance;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "LenguajeSenas.db");

    var db = await openDatabase(path, version: 3, onCreate: onCreateFunc);

    return db;
  }


  void onCreateFunc (Database db, int version) async{
    //create table
    await db.execute('CREATE TABLE Users (idUsers INTEGER PRIMARY KEY AUTOINCREMENT, nameUsers VARCHAR(30) )');
    await db.execute('CREATE TABLE Categorys (idCategorys INTEGER PRIMARY KEY AUTOINCREMENT, nameCategorys VARCHAR(30), urlCategorys VARCHAR(30) )');
    await db.execute('CREATE TABLE DetailCategorys (idDetailCategorys INTEGER PRIMARY KEY AUTOINCREMENT, idCategorysFr INTEGER, urlImageGif Text, word VARCHAR(30) )');
  //   await db.execute('CREATE TABLE Achievements (idAchievements INTEGER PRIMARY KEY AUTOINCREMENT, idUsers INTEGER, idCategory INTEGER, porcentage FLOAT(2) );');
  }

  /*
    CRUD FUNCTION
  */

  // Get User
  Future<List<User>> getUsers() async{
    var dbConnection = await db;

    List<Map> list = await dbConnection.rawQuery('SELECT * FROM Users');
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
    String query = 'INSERT INTO Users (nameUsers) VALUES (\'${user.nameUser}\')';
    await dbConnection.transaction((transaction) async{
      return await transaction.rawInsert(query);
    });
  }


  // Update User
  void updateUser (User user) async{
    var dbConnection = await db;
    String query = 'UPDATE Users SET nameUsers=\'${user.nameUser}\' WHERE idUsers=${user.idUser}';
    await dbConnection.transaction((transaction) async{
      return await transaction.rawQuery(query);
    });
  }


  // Delete User
  void deleteUser (User user) async{
    var dbConnection = await db;
    String query = 'DELETE FROM Users  WHERE idUsers=${user.idUser}';
    await dbConnection.transaction((transaction) async{
      return await transaction.rawQuery(query);
    });
  }


  // Get Category
  Future<List<Category>> getCategorys() async{
    var dbConnection = await db;

    List<Map> list = await dbConnection.rawQuery('SELECT * FROM Categorys');
    List<Category> categorys = new List();

    for(int i = 0; i< list.length; i++)
    {
      Category category = new Category();
      category.idCategory = list[i]['idCategorys'];
      category.nameCategory =  list[i]['nameCategorys'];
      category.urlCategory =  list[i]['urlCategorys'];

      categorys.add(category);
    }

    return categorys;
  }


  //add category
  void addCategory () async{

    var category = [
      {
        "nameCategory" : "Familia",
        "urlCategory"  : "assets/activity/family/logo_family.png"
      },
      {
        "nameCategory" : "Alimentos",
        "urlCategory"  : "assets/activity/aliments/logo_aliments.png"
      },
      {
        "nameCategory" : "Animales",
        "urlCategory"  : "assets/activity/animals/logo_animals.png"
      },
      {
        "nameCategory" : "Numeros",
        "urlCategory"  : "assets/activity/numbers/logo_numbers.png"
      },
      {
        "nameCategory" : "Colores",
        "urlCategory"  : "assets/activity/colors/logo_colors.png"
      },
    ];

    var dbConnection = await db;
    String query = 'INSERT INTO Categorys (nameCategorys, urlCategorys) VALUES (\'${category[0]['nameCategory']}\',\'${category[0]['urlCategory']}\'),(\'${category[1]['nameCategory']}\',\'${category[1]['urlCategory']}\'),(\'${category[2]['nameCategory']}\',\'${category[2]['urlCategory']}\'),(\'${category[3]['nameCategory']}\',\'${category[3]['urlCategory']}\'),(\'${category[4]['nameCategory']}\',\'${category[4]['urlCategory']}\')';
    await dbConnection.transaction((transaction) async{
      return await transaction.rawInsert(query);
    });
  }



  // Get DetailCategory
  Future<List<DetailCategory>> getDetailCategorys() async{
    var dbConnection = await db;

    List<Map> list = await dbConnection.rawQuery('SELECT * FROM Categorys INNER JOIN DetailCategorys ON DetailCategorys.idCategorysFr = Categorys.idCategorys');
    List<DetailCategory> detailCategorys = new List();

    for(int i = 0; i< list.length; i++)
    {
      DetailCategory detailCategory = new DetailCategory();
      detailCategory.idDetailCategory = list[i]['idDetailCategorys'];
      detailCategory.idCategory = list[i]['idCategorys'];
      detailCategory.urlImageGif =  list[i]['urlImageGif'];
      detailCategory.word =  list[i]['word'];

      detailCategorys.add(detailCategory);
    }

    return detailCategorys;
  }



   //add detailcategory
  void addDetailCategory () async{
      var dbConnection = await db;
      int idCategory = 0;

      var detailCategory = [
        {
          "nameCategory" : "Familia",
          "urlCategoryGif"  : "assets/activity/family/familia.gif",
          "word" : "Familia"
        },
        {
          "nameCategory" : "Alimentos",
          "urlCategoryGif"  : "assets/activity/aliments/alimentos.gif",
          "word" : "Alimentos"
        },
        {
          "nameCategory" : "Animales",
          "urlCategoryGif"  : "assets/activity/animals/animales.gif",
          "word" : "Animales"
        },
        {
          "nameCategory" : "Numeros",
          "urlCategoryGif"  : "assets/activity/numbers/numeros.gif",
          "word" : "Numeros"
        },
        {
          "nameCategory" : "Colores",
          "urlCategoryGif"  : "assets/activity/colors/colores.gif",
          "word" : "Colores"
        },
      ];

      List<Map> list = await dbConnection.rawQuery('SELECT * FROM Categorys');

      for (int i = 0; i < list.length; i++) {
        for(int d = 0; d< detailCategory.length; d++) {
          if(detailCategory[d]['nameCategory'] == list[i]['nameCategorys']){
            idCategory = list[i]['idCategorys'];

            String query = 'INSERT INTO DetailCategorys (idCategorys, urlImageGif, word) VALUES (\'$idCategory\',\'${detailCategory[d]['urlCategoryGif']}\',\'${detailCategory[d]['word']}\')';
            await dbConnection.transaction((transaction) async{
              return await transaction.rawInsert(query);
            });

          }
        }
      }


  }

}
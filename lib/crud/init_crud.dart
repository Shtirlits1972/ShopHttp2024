import 'package:path/path.dart';
import 'package:shop_http_2024/constants.dart';
import 'package:sqflite/sqflite.dart';

class InitCrud {
  static init() async {
    String paramsTab =
        'CREATE TABLE [Params]([id] INTEGER PRIMARY KEY AUTOINCREMENT,  [NameParams] NVARCHAR, [ValueParams] NVARCHAR );  ';

    String insToken =
        'INSERT INTO [Params] (NameParams, ValueParams) values("token", "");';

    String insRemember =
        'INSERT INTO [Params] (NameParams, ValueParams) values("remember", "");';

    String insLogin =
        'INSERT INTO [Params] (NameParams, ValueParams) values("login", "");';

    String insPassword =
        'INSERT INTO [Params] (NameParams, ValueParams) values("password", "");';

    getDatabasesPath().then((String strPath) {
      String path = join(strPath, dbName);
      try {
        final database = openDatabase(path, onCreate: (db, version) async {
          await db.execute(paramsTab);

          await db.execute(insToken);
          await db.execute(insRemember);
          await db.execute(insLogin);
          await db.execute(insPassword);

          print('DB created');
        }, version: 1);
      } catch (e) {
        print(e);
      }
    });
  }
}

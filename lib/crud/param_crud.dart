import 'package:path/path.dart';
import 'package:shop_http_2024/constants.dart';
import 'package:sqflite/sqflite.dart';

class ParamCrud {
  static Future upd(String NameParams, String ValueParams) async {
    //   [Params] (NameParams, ValueParams)
    String command =
        'UPDATE [Params] SET ValueParams = ? WHERE NameParams = NameParams';
    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count = await db.rawUpdate(command, [ValueParams, NameParams]);

      print('row updated = $count ');
    } catch (e) {
      print(e);
    }
  }
}

import 'package:path/path.dart';
import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/model/params_bag.dart';
import 'package:sqflite/sqflite.dart';

class ParamCrud {
  static Future<Database> _get_db() async {
    String strPath = await getDatabasesPath();
    String path = join(strPath, dbName);
    Database db = await openDatabase(path, version: 1);

    return db;
  }

  static Future<int> upd(String NameParams, String ValueParams) async {
    String command = 'UPDATE [Params] SET ValueParams = ? WHERE NameParams = ?';
    try {
      Database db = await _get_db();
      int count = await db.rawUpdate(command, [ValueParams, NameParams]);

      print('row updated = $count ');
      return count;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<int> clear() async {
    String command = 'UPDATE [Params] SET ValueParams = "" ';
    try {
      Database db = await _get_db();
      int count = await db.rawUpdate(command);

      print('row updated = $count ');
      return count;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<String> getValue(String NameParams) async {
    String ValueParams = '';

    try {
      Database db = await _get_db();

      List<Map> list = await db.rawQuery(
          'SELECT ValueParams FROM Params WHERE NameParams = ?  LIMIT 1;',
          [NameParams]);
      int h = 0;
      if (list.isNotEmpty) {
        ValueParams = list[0]['ValueParams'];
        return ValueParams;
      }

      //===========================================
    } catch (e) {
      print(e);
    }

    return ValueParams;
  }

  static Future<ParamsBag> getParamsBag() async {
    ParamsBag paramsBag = ParamsBag.empty();

    try {
      Database db = await _get_db();

      List<Map> list =
          await db.rawQuery('SELECT NameParams, ValueParams FROM Params;');

      list.forEach((param) {
        if (param['NameParams'] == 'token') {
          paramsBag.token = param['ValueParams'];
        } else if (param['NameParams'] == 'remember') {
          paramsBag.remember = bool.parse(param['ValueParams']);
          int g = 0;
        } else if (param['NameParams'] == 'login') {
          paramsBag.login = param['ValueParams'];
        } else if (param['NameParams'] == 'password') {
          paramsBag.password = param['ValueParams'];
        }
      });
    } catch (e) {
      print(e);
    }

    print(paramsBag);

    int h2 = 0;

    return paramsBag;
  }
}

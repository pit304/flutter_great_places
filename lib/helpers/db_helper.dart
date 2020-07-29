import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class DBHelper {
  static StoreRef store = StoreRef<String, String>.main();
  static DatabaseFactory factory =
      kIsWeb ? databaseFactoryWeb : databaseFactoryIo;

  static Future<Database> database() async {
    var dbPath = 'places.db';
    if (!kIsWeb) {
      // get the application documents directory
      var dir = await getApplicationDocumentsDirectory();
      // make sure it exists
      await dir.create(recursive: true);
      // build the database path
      dbPath = join(dir.path, 'places.db');
    }
    // Open the database
    return factory.openDatabase(dbPath);
  }

  static void insert(Map<String, Object> data) async {
    final db = await database();
    await store.record(data['title']).put(db, data);
  }

  static Future<List<RecordSnapshot<dynamic, dynamic>>> getData() async {
    final db = await database();
    // Read the record
    return store.find(db);
  }
}

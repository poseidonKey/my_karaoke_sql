import 'package:my_karaoke_sql/src/song_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 1;
  Database? db;

  static final DbHelper _dbHelper = DbHelper._internal();
  DbHelper._internal();
  factory DbHelper() {
    return _dbHelper;
  }
  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'mysongs.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE mysongs(id INTEGER PRIMARY KEY, songName TEXT, songGYNumber text, songTJNumber text, songJanre text, songUtubeAddress text, songETC text, songCreateTime text, songFavorite text)');
      }, version: version);
    }
    return db!;
  }

  Future<List<SongItem>> getLists() async {
    final List<Map<String, dynamic>> maps = await db!.query('mysongs');

    return List.generate(maps.length, (i) {
      return SongItem(
          maps[i]["id"].toString(),
          maps[i]["songName"],
          maps[i]["songGYNumber"],
          maps[i]["songTJNumber"],
          maps[i]["songJanre"],
          maps[i]["songUtubeAddress"],
          maps[i]["songETC"],
          maps[i]["songCreateTime"],
          maps[i]["songFavorite"]);
    });
  }

  Future testDb() async {
    db = await openDb();
    await db!.execute(
        "insert into mysongs values (0,'aa','aa','aa','aa','aa','aa','aa','true')");
    List lists = await db!.rawQuery("select * from mysongs");
    print(lists[0].toString());
  }

  Future<int> insertList(SongItem list) async {
    int id = await this.db!.insert(
          'mysongs',
          list.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return id;
  }

  Future<int> deleteList(SongItem list) async {
    int id =
        await this.db!.delete("mysongs", where: "id = ?", whereArgs: [list.id]);
    return id;
  }

  Future<List<SongItem>> searchList(String searchTerm) async {
    String query =
        "select * from mysongs where songName like '%" + searchTerm + "%'";
    final List<Map<String, dynamic>> maps = await db!.rawQuery(query);
    return maps
        .map(
          (e) => SongItem(
              e["id"].toString(),
              e["songName"],
              e["songGYNumber"],
              e["songTJNumber"],
              e["songJanre"],
              e["songUtubeAddress"],
              e["songETC"],
              e["songCreateTime"],
              e["songFavorite"]),
        )
        .toList();

    // return List.generate(
    //   maps.length,
    //   (i) {
    //     return SongItem(
    //         maps[i]["id"].toString(),
    //         maps[i]["songName"],
    //         maps[i]["songGYNumber"],
    //         maps[i]["songTJNumber"],
    //         maps[i]["songJanre"],
    //         maps[i]["songUtubeAddress"],
    //         maps[i]["songETC"],
    //         maps[i]["songCreateTime"],
    //         maps[i]["songFavorite"]);
    //   },
    // );
  }
}

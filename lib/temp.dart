/*
class SqliteTestModel {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await initDB();
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'RawData.db');

    return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade
    );
  }
  FutureOr<void> _onCreate(Database db, int version) {
    String sql = '''
  CREATE TABLE Raws(
    No INTEGER PRIMARY KEY,
    Ch1 FLOAT)
  ''';

    db.execute(sql);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {}

  Future<List<RawData>> Raws() async {
    // 데이터베이스 reference를 얻습니다.
    var db = await database;

    // 모든 Dog를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('Raws');

    // List<Map<String, dynamic>를 List<Dog>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return RawData(
        No: maps[i]['No'] as int,
        Ch1: maps[i]['Ch1'] as double,

      );
    });
  }

  Future<void> testInsert(RawData item) async {
    var db = await database;

    await db.insert(
        'Raws',
        item.toMap()
    );
  }

  Future<void> testUpdate(RawData item) async {
    var db = await database;

    await db.update(
        'Raws',
        item.toMap(),
        where: 'No = ?',
        whereArgs: [item.No]
    );
  }
}

 */
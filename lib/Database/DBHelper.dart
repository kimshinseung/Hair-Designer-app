import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper{
  static Database? _database;
  static const String dbName = 'image_database.db';
  static const String tableImages = 'images';

  // 데이터베이스 연결
  Future<Database> get database async {
    if (_database != null) return _database!;

    // 데이터베이스가 없으면 생성
    _database = await initDB();
    return _database!;
  }

  // 이미지 테이블의 모든 데이터 가져오기
  Future<List<Map<String, dynamic>>> getAllImages() async {
    final db = await database;
    return await db.query(tableImages);
  }

  // 데이터베이스 초기화 및 생성
  initDB() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE $tableImages(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imagePath TEXT,
            category TEXT
          )
          ''');
    });
  }

  // 이미지 추가
  Future<int> insertImage(String imagePath, String category) async {
    final db = await database;
    return await db.insert(tableImages, {'imagePath': imagePath, 'category': category});
  }
  //이미지 삭제
  Future<void> deleteImage(String imagePath, String category) async {
    final db = await database;
    await db.delete(
        tableImages,
        where: 'imagePath = ? AND category = ?',
        whereArgs: [imagePath, category]
    );
  }

  // 카테고리에 해당하는 이미지들 불러오기
  Future<List<Map<String, dynamic>>> getImagesByCategory(String category) async {
    final db = await database;
    return await db.query(tableImages, where: 'category = ?', whereArgs: [category]);
  }
}
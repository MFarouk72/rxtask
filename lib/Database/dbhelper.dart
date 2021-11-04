import 'package:rxtask/Commons/CommonModels/FriendsModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DbHelper{
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();

  static late Database _db;

  Future<Database> createDatabase() async {
    String path = join(await getDatabasesPath(), 'friends.db');
    _db = await openDatabase(path, version: 1 , onCreate: (Database db , int v){
      db..execute(
          'CREATE TABLE friends (id INTEGER PRIMARY KEY autoincrement, firstName TEXT, lastName TEXT, email TEXT, phone TEXT,address TEXT , gender TEXT , imagePath TEXT ,lat TEXT , long TEXT , audioPath TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error When Creating Table ${error.toString()}');
      });
    });
    return _db;
  }

  Future<int> addFriend(FriendsModel friendsModel) async{
    Database db = await createDatabase();
    return db.insert('friends' ,friendsModel.toMap());
  }

  Future<List> getAllFriends() async{
    Database db = await createDatabase();
    return db.query('friends');
  }

  Future <int> deleteFriend(int id) async{
    Database db = await createDatabase();
    return db.delete('friends', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> editFriendInfo(FriendsModel friendsModel) async{
    Database db = await createDatabase();
    return await db.update('friends', friendsModel.toMap(), where: 'id = ? ' , whereArgs: [friendsModel.id]);

  }

}
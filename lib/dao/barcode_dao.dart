
import 'package:flutter_app_auth_template/db/data_base.dart';
import 'package:flutter_app_auth_template/model/barcodes_model.dart';
import 'package:sembast/sembast.dart';




class CodesDao{
  static const String folderName = "Codes";
  final _booksFolder = intMapStoreFactory.store(folderName);


  Future<Database> get  _db  async => await AppDatabase.instance.database;


  Future insertBooks(BarCodes books) async{

    await  _booksFolder.add(await _db, books.toJson() );

  }

  Future updateBooks(BarCodes books) async{
    final finder = Finder(filter: Filter.byKey(books.barCode));
    await _booksFolder.update(await _db, books.toJson(),finder: finder);

  }


  Future delete(BarCodes books) async{
    final finder = Finder(filter: Filter.byKey(books.barCode));
    await _booksFolder.delete(await _db, finder: finder);
  }

  Future<List<BarCodes>> getAllCodes()async{
    final recordSnapshot = await _booksFolder.find(await _db);
    return recordSnapshot.map((snapshot){
      final books = BarCodes.fromJson(snapshot.value);
      return books;
    }).toList();
  }


}
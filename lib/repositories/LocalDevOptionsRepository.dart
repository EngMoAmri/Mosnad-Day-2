
import 'package:mosnad_flutter/database/my_database.dart';
import 'package:mosnad_flutter/models/ServiceData.dart';
import 'package:mosnad_flutter/repositories/abstracts/services_provider.dart';
import 'package:mosnad_flutter/repositories/abstracts/services_saver.dart';
import 'package:sqflite/sqflite.dart';

class LocalDevOptionsRepository implements ServicesProvider, ServicesSaver{
  // singleton
  static final LocalDevOptionsRepository _singleton = LocalDevOptionsRepository._internal();

  factory LocalDevOptionsRepository() {
    return _singleton;
  }

  LocalDevOptionsRepository._internal();
  // singleton end

  @override
  Future<List<ServiceData>> getServices() async{
    List<Map<String, dynamic>> maps;
    maps = await MyDatabase.myDatabase!.query(
      'services',
    );
    List<ServiceData> services = [];
    for (var map in maps) {
      var product = ServiceData.fromMap(map);
      services.add(product);
    }
    return services;
  }


  @override
  Future<void> saveServices(List<ServiceData> services) async {
    for(var service in services) {
      await MyDatabase.myDatabase!.insert(
        'services',
        service.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

}